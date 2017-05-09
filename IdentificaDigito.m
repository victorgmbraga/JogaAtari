function num = IdentificaDigito (img, jogo, w, h)
    load(strcat('Templates',jogo,'.mat'));
    menorDiff = inf;
    for i = 1:size(TemplatesDigitos,3)
        diff = sum(sum(abs(double(img) - double(reshape(TemplatesDigitos(:,:,i),[h,w])))));
        if diff < menorDiff
            num = i;
            menorDiff = diff;
        end
    end
    if num > 9
        num = 0;
    end
end