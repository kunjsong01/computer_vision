pkg load image;

dog = rgb2gray(imread('/Users/kunjian_song/Downloads/schnauzer.png'));
stone = rgb2gray(imread('/Users/kunjian_song/Downloads/stone.png'));

% octave imshowpair not implemented yet
% imshowpair(dog, stone, 'montage')

clf
figure(1);
imshow(dog)
figure(2);
%subplot(1, 2, 1);
%imshow(dog);
imshow(stone);


% 2D cross correlation
clf;
c = normxcorr2(stone, dog);
colormap ("default");
surfc(c); 


