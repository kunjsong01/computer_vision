function [] = my_disp(X, n)
figure(n)
imagesc(X);
colormap(gray);
axis image;
%axis off;
zoom;
