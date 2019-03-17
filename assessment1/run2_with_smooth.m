% Task2:
% Aim: 
%   - Simple global thresholding:
% Compare results: 
%   - global thresholding the original image
%   - run a Gaussian filter and subtract the result from the original image
%     Use global thresholding again to see the difference

clf; close all;
% ----------------------- singal global thresholding ----------------------- 
% Expecting bad background
X = pgmread('task2.pgm');
disp_image(X, 1, 'original image');

% try with threshold of 90
binarized1 = (X > 100);
disp_image(binarized1, 2, 'thresholds of x > 100');

% run a smoothing kernel and subtract it from the original image
hsize = 100; % size of kernel to be 100 x 100
sigma = 5;% bigger sigma, more blurry
h = fspecial("gaussian", hsize, sigma);
out_x = imfilter(X, h); % apply gaussian filter to the original image

disp_image(out_x, 5, 'Smoothed image');

X_prime = X - out_x; % subtract result from original image
disp_image(X_prime, 4, 'subtract result form the original image');

% get histogram
% roihist()
% try threshold of -10, -30, -50 (by inspecting the histogram of X_prime)
binarized2 = (X_prime > -10);
disp_image(binarized2, 5, 'thresholds of x > -10');
binarized3 = (X_prime > -30);
disp_image(binarized3, 6, 'thresholds of x > -30');
binarized4 = (X_prime > -50);
disp_image(binarized4, 7, 'thresholds of x > -50');


























