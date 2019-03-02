pkg load image;
img = imread("/Users/kunjian_song/Downloads/schnauzer.jpg");

# add Gaussian noise
noise_sigma = 100; # noise intensity. This sigma is NOT kernel sigma used by filtering
noise = randn(size(img)) .* noise_sigma;
noisy_img = img + noise;

# create gaussian filter
hsize = 31; # size of the kernel 31 x 31
sigma = 5; # bigger sigma, more blurry
sigma_big = 20; # bigger sigma, more blurry
h = fspecial("gaussian", hsize, sigma);
h2 = fspecial("gaussian", hsize, sigma_big);

# apply the filter to remove noise
smoothed_noisy = imfilter(noisy_img, h);
smoothed_clean_small_sig = imfilter(img, h);
smoothed_clean_big_sig = imfilter(img, h2);

figure(2);
subplot(2, 2, 1);
imshow(img);
subplot(2, 2, 2);
imshow(noisy_img);
subplot(2, 2, 3);
imshow(smoothed_clean_big_sig);
subplot(2, 2, 4);
imshow(smoothed_noisy);




