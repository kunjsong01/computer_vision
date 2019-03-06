% better to use a hexagon to get better understanding of the result!

function result = select_gdir(gmag, gdir, mag_min, angle_low, angle_high)
    % TODO Find and return pixels that fall within the desired mag, angle range
    % this is essentially a thresholding problem
    result = gmag >= mag_min & angle_low <= gdir & gdir <= angle_high;
endfunction

pkg load image;
img = imread("/Users/kunjian_song/Downloads/schnauzer.jpg");
img = rgb2gray(img);

% scale down to use range [0, 1] for convenience
img = double(img) / 255;
imshow(img); % same image displayed

% compute x, y gradients using sobel operator
[gx gy] = imgradientxy(img, 'sobel');
imshow((gy+4) / 8)

%% Obtain gradient magnitude and direction
[gmag gdir] = imgradient(gx, gy);
imshow(gmag / (4 * sqrt(2))); % mag = sqrt(gx^2 + gy^2), so [0, (4 * sqrt(2))]
imshow((gdir + 180.0) / 360.0); % angle in degrees [-180, 180]

%% Find pixels with desired gradient direction
my_grad = select_gdir(gmag, gdir, 1, 30, 60); % 45 +/- 15
%imshow(my_grad);  % NOTE: enable after you've implemented select_gdir


