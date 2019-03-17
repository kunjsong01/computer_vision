% Task1 process:
% Step 1: read image and display image and colour sacle
% Step 2: create a mask for ROI (ellipse) and crop it out
% Step 3: ? ROI Gaussian filter (to remove noise)
% Step 4: ? ROI sharpen (to increase the contrast for Otsu)
% Step 5: Otsu method to find global thresholding

%Step 1: 
X = pgmread('task1.pgm');
figure(1)
I = imagesc(X);
colormap(gray);
axis image;
colorbar
%Step 2: 
x = getimage(gcf);
bw = drawpolygon();
mask = createMask(bw);
figure(2)
I2 = imagesc(mask);
colormap(gray);
axis image;
colorbar
ROI_I = X.*mask;
figure(3)
I3 = imagesc(ROI_I);
colormap(gray);
axis image;
colorbar












