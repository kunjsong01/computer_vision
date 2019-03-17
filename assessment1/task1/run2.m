% Use the original function to inspect histogram of ROI

clf
close all
Y = pgmread('task1.pgm');
my_disp(Y, 1)
roihist()