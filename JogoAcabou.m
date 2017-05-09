function acabou = JogoAcabou(frame, jogo, debug)
    persistent placarEnduro;
    persistent contPlacarEnduro;
    switch jogo
        case 'Breakout'
            vidas = IdentificaDigito(imcrop(frame, [361 11 42 19]), jogo, 43, 20);
            if(debug)
                disp(vidas);
            end
            if vidas > 0
                acabou = 0;
            else
                acabou = 1;
            end
        case 'Pong'
            dig1(2) = IdentificaDigito(imcrop(frame, [419 3 42 39]), strcat(jogo,'Jogador'), 43, 40);
            dig1(1) = IdentificaDigito(imcrop(frame, [361 3 42 39]), strcat(jogo,'Jogador'), 43, 40);
            dig2(2) = IdentificaDigito(imcrop(frame, [131 3 42 39]), strcat(jogo,'Adversario'), 43, 40);
            dig2(1) = IdentificaDigito(imcrop(frame, [73 3 42 39]), strcat(jogo,'Adversario'), 43, 40);            
            pontosJogador = sum(10.^(length(dig1)-1:-1:0).*dig1);
            pontosAdversario = sum(10.^(length(dig2)-1:-1:0).*dig2);
            if pontosJogador == 21
                acabou = 1;
            elseif pontosAdversario == 21
                acabou = 1;
            else
                acabou = 0;
            end
        case 'Beamrider'
            if(frame(373,123) > 100)
                acabou = 0;
            else
                acabou = 1;
            end
        case 'Seaquest'
            if(frame(53,221) > 120)
                acabou = 0;
            else
                acabou = 1;
            end
        case 'Enduro'
            if isempty(contPlacarEnduro)
                contPlacarEnduro = 0;
            end
            if isempty(placarEnduro)
                placarEnduro = 0;
            end
            novoPlacarEnduro = CalculaPlacar(frame, jogo);
            if(novoPlacarEnduro == placarEnduro)
                contPlacarEnduro = contPlacarEnduro + 1;
                %disp(strcat('Contador Placar: ',num2str(contPlacarEnduro)));
                if(contPlacarEnduro > 100)
                    contPlacarEnduro = 0;
                    placarEnduro = 0;
                    acabou = 1;
                else
                    acabou = 0;
                end
            else
                placarEnduro = novoPlacarEnduro;
                contPlacarEnduro = 0;
                acabou = 0;
            end
        case 'SpaceInvaders'
            if(frame(380,570) > 90)
                acabou = 0;
            else
                acabou = 1;
            end
    end
end