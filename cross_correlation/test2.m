% Test code:
pkg load image;
img = imread("/Users/kunjian_song/Downloads/schnauzer.jpg");
img = rgb2gray(img);
disp(size(img));

% crop image : these numbers show face of the schnauzer
cropped = img(130:250, 170:300);
%imshow(cropped);

% create a template that looks for the face of the schnauzer
% part of the image as cropped above
template = img(130:250, 170:300);

[y x] = find_template_2D(template, img);
disp([y x]); % should display (130, 170)

% plot where the template was found
colormap('gray'), imagesc(img);
hold on;
plot(x, y, 'r+', 'markersize', 16)
hold off;

