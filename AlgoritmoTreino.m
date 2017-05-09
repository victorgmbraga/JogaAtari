jogo = 'SpaceInvaders';
frameTime = 0.017;
randRate = 1;
numFramesEstado = 4;
numFramesObtidos = 0;
numExps = 0;
estado = [];
proxEstado = [];
treina = 1;
gamma = 0.9;
primeiroEstado = 1;
contTreinos = 1;
maxTreinos = 1000;
debug = 0;

pause(5);

if(exist(strcat('Net', jogo, '.mat'), 'file') == 2)
    load(strcat('Net', jogo, '.mat'));
else
    net = ConfiguraRede(frameTime, numFramesEstado);
end

tic;
IniciaJogo();

while contTreinos < maxTreinos
    if(toc > frameTime)
        if(numFramesObtidos == numFramesEstado) % Já preencheu o buffer de frames
            
            % Pega o novo placar
            placarProx = CalculaPlacar(frame, jogo);
            
            if(treina && ~primeiroEstado) % Salva a experiencia
                recompensa = placarProx - placar;
                if(recompensa ~= 0)
                    if recompensa > 1
                        recompensa = 1;
                    elseif recompensa < -1
                        recompensa = -1;
                    end
                    if(debug)
                        disp(recompensa);
                    end
                end
                numExps = numExps + 1;
                exps(numExps) = experience;
                exps(numExps).store(estado, acao, recompensa, proxEstado);
            elseif(primeiroEstado)
                primeiroEstado = 0;
            end
            
            % Atualiza o estado atual
            estado = proxEstado;
            proxEstado = [];
            numFramesObtidos = 0;            
            placar = placarProx;
            SoltaBotoes();
            
            % Ve se o jogo acabou
            if(JogoAcabou(frame, jogo, debug))
                if(treina) % Treina a rede
                    for i = 1:numExps
                        if(debug)
                            disp(length(exps));
                        end
                        random = randi(length(exps));
                        trainSample = exps(random).get();
                        exps(random) = [];

                        retornoRedeEstado = net(trainSample.estado);
                        retornoRedeProxEstado = net(trainSample.proxEstado);

                        retornoRedeEstado(trainSample.acao) = trainSample.recompensa + gamma * max(retornoRedeProxEstado);

                        net = train(net, trainSample.estado, retornoRedeEstado);
                    end
                    
                    save(strcat('Net',jogo,'.mat'),'net'); 
                    
                    if(randRate > 0.1)
                        if(debug)
                            disp(strcat('E = ',num2str(randRate)));
                        end
                        randRate = randRate - 0.01;
                    end
                    
                    numExps = 0;
                    contTreinos = contTreinos + 1;
                    
                    if mod(contTreinos, 10) == 0
                        save(strcat('Net',jogo,num2str(contTreinos),'Treinos','.mat'),'net'); 
                    end
                end
                
                primeiroEstado = 1;
                IniciaJogo();
                
            else % Toma uma acao
                if(rand < randRate && treina)
                    acao = randi(10);
                else
                    aux = net(estado);
                    acao = find(aux == max(aux));
                end
                switch(acao)
                    case 1
                        AndaCima();
                        if(debug)
                            disp('CIMA');
                        end
                    case 2
                        AndaBaixo();
                        if(debug)
                            disp('BAIXO');
                        end
                    case 3
                        AndaEsquerda();
                        if(debug)
                            disp('ESQUERDA');
                        end
                    case 4
                        AndaDireita();
                        if(debug)
                            disp('DIREITA');
                        end
                    case 5
                        Atira();
                        AndaCima();
                        if(debug)
                            disp('ATIRA E CIMA');
                        end
                    case 6
                        Atira();
                        AndaBaixo();
                        if(debug)
                            disp('ATIRA E BAIXO');
                        end
                    case 7
                        Atira();
                        AndaEsquerda();
                        if(debug)
                            disp('ATIRA E ESQUERDA');
                        end
                    case 8
                        Atira();
                        AndaDireita();
                        if(debug)
                            disp('ATIRA E DIREITA');
                        end
                    case 9
                        Atira();
                        if(debug)
                            disp('ATIRA');
                        end
                    case 10
                        if(debug)
                            disp('PARADO');
                        end
                end
            end
        else % Adiciona os frames ao buffer
            % Note 13'
            %frame = rgb2gray(screencapture(0,[1,298,576,420]));
            % Note 15'
            frame = rgb2gray(screencapture(0,[2,657,576,420]));
            framePreproc = imcrop(frame,[30 0 545 420]);
            framePreproc = imresize(framePreproc,[84 110]);
            framePreproc = imcrop(framePreproc,[13 1 83 83]);
            proxEstado = double(vertcat(proxEstado,reshape(framePreproc,[],1)));
            numFramesObtidos = numFramesObtidos + 1;
        end
        tic;
    end
end