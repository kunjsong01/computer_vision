pkg load image;
img = imread("/Users/kunjian_song/Downloads/schnauzer.jpg");
imshow(img, [])

fprintf('original image size: %d %d %d\n', size(img));

% colour plane: all columns, all rows with only 1st plane
img_red = img(:, :, 1);
fprintf('img_red size: %d %d\n', size(img_red));

img_green = img(:, :, 2);
fprintf('img_green size: %d %d\n', size(img_green));

img_blue = img(:, :, 3);
fprintf('img_blue size: %d %d\n', size(img_blue));

noise = rand(size(img)) .* 15;
noisy_img = img + noise;
clf
%imshow(noisy_img);
