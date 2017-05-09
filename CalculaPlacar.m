function retorno = CalculaPlacar (frame, jogo)
    switch (jogo)
        case 'Breakout'
            dig(3) = IdentificaDigito(imcrop(frame, [246 11 42 19]), jogo, 43, 20);
            dig(2) = IdentificaDigito(imcrop(frame, [188 11 42 19]), jogo, 43, 20);
            dig(1) = IdentificaDigito(imcrop(frame, [131 11 42 19]), jogo, 43, 20);
            retorno = sum(10.^(length(dig)-1:-1:0).*dig);
        case 'Pong'
            dig1(2) = IdentificaDigito(imcrop(frame, [419 3 42 39]), strcat(jogo,'Jogador'), 43, 40);
            dig1(1) = IdentificaDigito(imcrop(frame, [361 3 42 39]), strcat(jogo,'Jogador'), 43, 40);
            dig2(2) = IdentificaDigito(imcrop(frame, [131 3 42 39]), strcat(jogo,'Adversario'), 43, 40);
            dig2(1) = IdentificaDigito(imcrop(frame, [73 3 42 39]), strcat(jogo,'Adversario'), 43, 40);            
            retorno = sum(10.^(length(dig1)-1:-1:0).*dig1) - sum(10.^(length(dig2)-1:-1:0).*dig2);
        case 'Beamrider'
            dig(6) = IdentificaDigito(imcrop(frame,[365 21 21 15]), jogo, 22, 16);
            dig(5) = IdentificaDigito(imcrop(frame,[336 21 21 15]), jogo, 22, 16);
            dig(4) = IdentificaDigito(imcrop(frame,[307 21 21 15]), jogo, 22, 16);
            dig(3) = IdentificaDigito(imcrop(frame,[278 21 21 15]), jogo, 22, 16);
            dig(2) = IdentificaDigito(imcrop(frame,[249 21 21 15]), jogo, 22, 16);
            dig(1) = IdentificaDigito(imcrop(frame,[220 21 21 15]), jogo, 22, 16);
            retorno = sum(10.^(length(dig)-1:-1:0).*dig);
        case 'Enduro'
            dig(5) = 0;
            dig(4) = IdentificaDigito(imcrop(frame,[321 331 21 13]), jogo, 22, 14);
            dig(3) = IdentificaDigito(imcrop(frame,[293 331 21 13]), jogo, 22, 14);
            dig(2) = IdentificaDigito(imcrop(frame,[265 331 21 13]), jogo, 22, 14);
            dig(1) = IdentificaDigito(imcrop(frame,[237 331 21 13]), jogo, 22, 14);
            retorno = sum(10.^(length(dig)-1:-1:0).*dig);
        case 'Seaquest'
            dig(6) = IdentificaDigito(imcrop(frame,[357 19 20 15]), jogo, 21, 16);
            dig(5) = IdentificaDigito(imcrop(frame,[329 19 20 15]), jogo, 21, 16);
            dig(4) = IdentificaDigito(imcrop(frame,[301 19 20 15]), jogo, 21, 16);
            dig(3) = IdentificaDigito(imcrop(frame,[273 19 20 15]), jogo, 21, 16);
            dig(2) = IdentificaDigito(imcrop(frame,[245 19 20 15]), jogo, 21, 16);
            dig(1) = IdentificaDigito(imcrop(frame,[217 19 20 15]), jogo, 21, 16);
            retorno = sum(10.^(length(dig)-1:-1:0).*dig);
        case 'SpaceInvaders'
            dig(4) = IdentificaDigito(imcrop(frame,[188 21 42 17]), jogo, 43, 18);
            dig(3) = IdentificaDigito(imcrop(frame,[131 23 42 17]), jogo, 43, 18);
            dig(2) = IdentificaDigito(imcrop(frame,[73 23 42 17]), jogo, 43, 18);
            dig(1) = IdentificaDigito(imcrop(frame,[15 21 42 17]), jogo, 43, 18);
            retorno = sum(10.^(length(dig)-1:-1:0).*dig);
        case 'QBert'
    end
end