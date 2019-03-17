% Task2: Improved
%   - Experiment with opening to remove the thin line (edges)
%     and isolated dots

clf; close all;
% ----------------------- singal global thresholding ----------------------- 
% Expecting bad background
X = pgmread('task2.pgm');
%disp_image(X, 1, 'original image');

% try with threshold of 90
binarized1 = (X > 100);
%disp_image(binarized1, 2, 'thresholds of x > 100');

% run a smoothing kernel and subtract it from the original image
hsize = 100; % size of kernel to be 100 x 100
sigma = 5;% bigger sigma, more blurry
h = fspecial("gaussian", hsize, sigma);
out_x = imfilter(X, h); % apply gaussian filter to the original image

%disp_image(out_x, 5, 'Smoothed image');

X_prime = X - out_x; % subtract result from original image
%disp_image(X_prime, 4, 'subtract result form the original image');

% get histogram
% roihist()
binarized2 = (X_prime > -30);
%disp_image(binarized2, 5, 'thresholds of x > -10');
disp_image(binarized2, 1, 'threshold of -30');

% opening and closing
se = strel('disk', 1);
afteropening1 = imopen(binarized2, se);
disp_image(afteropening1, 2, 'Morphological open image with SE = disk of size 1');

se = strel('disk', 2);
afteropening2 = imopen(binarized2, se);
disp_image(afteropening2, 3, 'Morphological open image with SE = disk of size 2');

se = strel('disk', 3);
afteropening2 = imopen(binarized2, se);
disp_image(afteropening2, 4, 'Morphological open image with SE = disk of size 3');

% erode/dilate changes the size of the major stuff
%shape = 'disk';
%se = strel(shape, 2);
%aftereroding = imerode(afteropening2, se);
%disp_image(aftereroding, 4, sprintf('Morphological erode with SE = %s of size 2', shape));





