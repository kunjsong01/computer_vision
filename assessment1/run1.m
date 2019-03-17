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
disp_image(X, 1, 'original img')

% ----------------------- Step 2 ----------------------- 
x = getimage(gcf);
bw = drawpolygon();
mask = createMask(bw);
disp_image(mask, 2, 'image mask')
% create a new image using ROI and dark background
ROI_I = X.*mask;
disp_image(ROI_I, 3, 'masked image - ROI + black out')
% plot histogram of the the new image (only non-zero minimum) 
figure(4)
flat = ROI_I(:);
non_zero = flat(flat>0);
i = min(non_zero) : (max(non_zero)- min(non_zero))/64.0 : max(non_zero);
h = hist(non_zero,i);
bar(i, h);
title('histogram of the masked image (Non-zero values only)');

% ----------------------- Step 3 ----------------------- 
% try with thresholds of 180 < I < 220
binarized1 = (ROI_I > 180) & (ROI_I < 220);
disp_image(binarized1, 5, 'thresholds of 180 < I < 220')

binarized2 = (ROI_I > 200) & (ROI_I < 215);
disp_image(binarized2, 6, 'thresholds of 200 < I < 215')

