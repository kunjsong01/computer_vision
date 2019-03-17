% Task2:
% Aim: 
%   - use blockproc and Otsu method to find locally adaptive threshold for
%     each block. Need to correct nonuniform background first
% Step 1: Correct nonuniform background
% Step 2: blockproc and Otsu method to find adaptive levels for each block
% 

clf; close all;
% ----------------------- adaptive thresholding ----------------------- 
% read image into an array
X = pgmread('task2.pgm');

% run a smoothing kernel and subtract it from the original image
hsize = 100; % size of kernel to be 100 x 100
sigma = 5;% bigger sigma, more blurry
h = fspecial("gaussian", hsize, sigma);
out_x = imfilter(X, h); % apply gaussian filter to the original image
X_prime = X - out_x; % subtract result from original image

% run blockproc and apply Otsu method for each block




















