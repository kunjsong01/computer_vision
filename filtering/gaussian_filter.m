pkg load image;
img = imread("/Users/kunjian_song/Downloads/schnauzer.jpg");

hsize = 31; # size of the kernel 31 x 31
sigma = 5; # bigger sigma, more blurry

# create a Gaussian filter, i.e. the box window for filtering
h = fspecial("gaussian", hsize, sigma);

# plot the filter as 3D plot
surf(h)

# show filter as image
imagesc(h)

# filtered image and show
out_img = imfilter(img, h);
imshow(out_img)

