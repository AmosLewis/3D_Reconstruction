%function [ F ] = eightpoint( pts1,pts2,M )
load('temple/some_corresp.mat');
im1 = imread('temple/im1.png');
im2 = imread('temple/im2.png');
[row,col,~]=size(im1);
M = max(row,col);
    
    Pts1 = pts1;
    Pts2 = pts2;
    %nomalize%
    pts1 = pts1/M;
    pts2 = pts2/M;
    
    % Create A matrix % Af=0
    X1X2 = pts1(:,1).* pts2(:,1); 
    Y1X2 = pts1(:,2).* pts2(:,1); 
    X2 = pts2(:,1);
    X1Y2 = pts1(:,1).* pts2(:,2);
    Y1Y2 = pts1(:,2).* pts2(:,2);
    Y2 = pts2(:,2);
    X1 = pts1(:,1);
    Y1 = pts1(:,2);
    I = ones(size(pts1,1),1);
    
    A = [X1X2,Y1X2,X2,X1Y2,Y1Y2,Y2,X1,Y1,I];
    
    %the least square(svd) find best result of f%
    ATA = A'*A;
    [U,S,V] = svd(ATA);
    f = V(:,end);
    f = f./norm(f);
    F = [f(1),f(4),f(7);...
         f(2),f(5),f(8);...
         f(3),f(6),f(9)];
    F = refineF(F,pts1,pts2);
    
    %nonomalize%
    T = [1/M,0,0;0,1/M,0;0,0,1];
    F = T'*F*T;
    
    pts1 = Pts1;
    pts2 = Pts2;
    save('q2_1.mat','F','M','pts1','pts2');


