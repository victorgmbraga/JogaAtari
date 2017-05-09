while true
    frame = screencapture(0,[1,298,576,420]);
    frame_preproc = rgb2gray(imresize(frame,0.125,'nearest'));
    disp(CalculaPlacarJogador(frame_preproc));
end