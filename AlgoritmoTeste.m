jogo = 'Seaquest';
frameTime = 0.017;
randRate = 0.1;
numFramesEstado = 4;
numFramesObtidos = 0;
numExps = 0;
estado = [];
usaRede = 1;
contTestes = 1;
maxTestes = 10;
debug = 0;

pause(5);

load(strcat('Net', jogo, num2str(1000), 'Treinos.mat'));

%if(usaRede && exist(strcat('Net', jogo, contTestes * 10, 'Treinos.mat'), 'file') == 2)
%    load(strcat('Net', jogo, contTestes * 10, 'Treinos.mat'));
%    contTestes = contTestes + 1;
%end

tic;
IniciaJogo();

while contTestes <= maxTestes
    if(toc > frameTime)
        if(numFramesObtidos == numFramesEstado) % Já preencheu o buffer de frames
            % Ve se o jogo acabou
            if(JogoAcabou(frame, jogo, debug))
                
                pontuacao(contTestes) = CalculaPlacar(frame, jogo);
                
                %if(usaRede && exist(strcat('Net', jogo, contTestes * 10, 'Treinos.mat'), 'file') == 2)
                %    load(strcat('Net', jogo, contTestes * 10, 'Treinos.mat'));
                %end
                
                contTestes = contTestes + 1;
                IniciaJogo();
                
            else % Toma uma acao
                if((rand < randRate) || ~usaRede)
                    acao = randi(10);
                else
                    aux = net(estado);
                    acao = find(aux == max(aux));
                end
                SoltaBotoes();
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
            
            estado = [];
            numFramesObtidos = 0;
            
        else % Adiciona os frames ao buffer
            % Note 13'
            %frame = rgb2gray(screencapture(0,[1,298,576,420]));
            % Note 15'
            frame = rgb2gray(screencapture(0,[2,657,576,420]));
            framePreproc = imcrop(frame,[30 0 545 420]);
            framePreproc = imresize(framePreproc,[84 110]);
            framePreproc = imcrop(framePreproc,[13 1 83 83]);
            estado = double(vertcat(estado,reshape(framePreproc,[],1)));
            numFramesObtidos = numFramesObtidos + 1;
        end
        tic;
    end
end