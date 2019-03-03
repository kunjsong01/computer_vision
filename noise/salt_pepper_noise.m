pkg load image;
img = imread("/Users/kunjian_song/Downloads/schnauzer.jpg");
imshow(img);

clf;
% add salt & pepper noise
noisy_image = imnoise(img, 'salt & pepper', 0.02);
imshow(noisy_image);

% apply a median filter to each colour
img_filtered = noisy_img;
for i = 1 : 3
    img_filtered(:, :, i) = medfilt2(noisy_img(:, :, i), [3, 3]);
end

% create gaussian filter
hsize = 31; % size of the kernel 31 x 31
sigma = 5; % bigger sigma, more blurry
h = fspecial("gaussian", hsize, sigma);
average_filtered = imfilter(noisy_img, h); % removed noisy but very blurry

%{
clf;
figure(2);
subplot(2, 2, 1);
imshow(img);
subplot(2, 2, 2);
imshow(noisy_img);
subplot(2, 2, 3);
imshow(average_filtered);
subplot(2, 2, 4);
imshow(img_filtered);
}%


