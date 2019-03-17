% Task1:
% Aim: 
%   - Get a new graph showing th white matter on a black background
% Process: 
% Step 1: read image and display it using imagesc function and use gray
% Step 2: create a mask for ROI (ellipse), crop it out, inspect hist
% Step 3: binarize the image using above and below thresholds of the peak
%         g(I) = 1 if above < I < below, else g(I) = 0
% Finally, display the white matter on a new image with black background

clf
close all
% ----------------------- Step 1 ----------------------- 
X = pgmread('task1.pgm');
figure(1)
I = imagesc(X);
colormap(gray);
axis image;
colorbar

% ----------------------- Step 2 ----------------------- 
x = getimage(gcf);
bw = drawpolygon();
mask = createMask(bw);
figure(2)
I2 = imagesc(mask);
colormap(gray);
axis image;
colorbar
% create a new image using ROI and dark background
ROI_I = X.*mask;
figure(3)
I3 = imagesc(ROI_I);
colormap(gray);
axis image;
colorbar
% plot histogram of the the new image (only non-zero minimum) 
figure(4)
flat = ROI_I(:);
non_zero = flat(flat>0);
i = min(non_zero) : (max(non_zero)- min(non_zero))/64.0 : max(non_zero);
h = hist(non_zero,i);
bar(i, h);
title('');

% ----------------------- Step 3 ----------------------- 
% try with thresholds of 180 < I < 220
binarized1 = (ROI_I > 180) & (ROI_I < 220);
figure(5)
I4 = imagesc(binarized);
colormap(gray);
axis image;
colorbar
title('thresholds of 180 < I < 220')

binarized2 = (ROI_I > 200) & (ROI_I < 215);
figure(6)
I5= imagesc(binarized2);
colormap(gray);
axis image;
colorbar
title('thresholds of 200 < I < 215')

















