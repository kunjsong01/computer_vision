pkg load image;
img = imread("/Users/kunjian_song/Downloads/schnauzer.jpg");
img = rgb2gray(img);

% use figure to open a new window and imshow the image in that window
%figure, imshow(img), title('original image, color');

% smooth the image using Gaussian filter, h=11x11, sigma = 4
h = fspecial('gaussian', [11, 11], 4);
%figure, surf(h);
imgSmooth = imfilter(img, h);
%figure, imshow(imgSmooth), title('Smoothed image');

% Method 1: shift left and right, and show diff image
imgL = imgSmooth;
imgL(:, [1:(end-1)]) = imgL(:, [2:end]);
imgR = imgSmooth;
imgR(:, [2:(end)]) = imgL(:, [1:(end-1)]);
imgdiff = double(imgR) - double(imgL);
%figure, imshow(imgdiff, []), title('diff img with []');
%figure, imshow(imgdiff), title('diff img without []');

% Method 2: Canny edge detector (performs non-maximal suppression)
cannyImg = edge(img, 'Canny');
figure, imshow(cannyImg), title('Canny image');
cannySmooth = edge(imgSmooth, "Canny");
figure, imshow(cannySmooth), title('Canny image smooth');

% Method 3: Laplacian of Gaussian
logEdge = edge(img, 'LoG');
figure, imshow(logEdge), title('LoG image');

