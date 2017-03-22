% load('temple/some_corresp.mat');
I1 = imread('temple/im1.png');
I2 = imread('temple/im2.png');
load('q2_2.mat');

displayEpipolarF(I1, I2, Fcorrect);