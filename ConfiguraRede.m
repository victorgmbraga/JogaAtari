function net = ConfiguraRede(frameTime, numFramesEstado) 
    estado1 = [];
    estado2 = [];
    
    IniciaJogo();
    
    numFramesObtidos = 0;
    tic;
    
    while numFramesObtidos < numFramesEstado
        if(toc > frameTime)
            frame = rgb2gray(screencapture(0,[2,657,576,420]));
            framePreproc = imcrop(frame,[30 0 545 420]);
            framePreproc = imresize(framePreproc,[84 110]);
            framePreproc = imcrop(framePreproc,[13 1 83 83]);
            estado1 = double(vertcat(estado1, reshape(framePreproc,[],1)));
            numFramesObtidos = numFramesObtidos + 1;
            tic;
        end
    end
    
    AndaBaixo();
    AndaEsquerda();
    pause(2);
    SoltaBotoes();
    numFramesObtidos = 0;
    tic;
    
    while numFramesObtidos < numFramesEstado
        if(toc > frameTime)
            frame = rgb2gray(screencapture(0,[2,657,576,420]));
            framePreproc = imcrop(frame,[30 0 545 420]);
            framePreproc = imresize(framePreproc,[84 110]);
            framePreproc = imcrop(framePreproc,[13 1 83 83]);
            estado2 = double(vertcat(estado2, reshape(framePreproc,[],1)));
            numFramesObtidos = numFramesObtidos + 1;
            tic;
        end
    end
    
    A = [estado1 estado2];
    B = [rand rand;rand rand;rand rand;rand rand;rand rand;rand rand;rand rand;rand rand;rand rand;rand rand];
    
    net = feedforwardnet(440);
    net.trainFcn = 'traingd';
    net.divideFcn = '';
    net.trainParam.showWindow = false;
    net = configure(net, A, B);
    net.trainParam.epochs = 1;
end