function [outputArg1,outputArg2] = disp_image(img, n, msg)
% display an image with color bar
% Input:
%   - img = image arrag, 
%   - n = figure number
%   - title = figure title

figure(n)
I = imagesc(img);
colormap(gray);
axis image;
colorbar
title(msg);


end

