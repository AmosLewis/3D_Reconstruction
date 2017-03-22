%function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
    clc;clear;
    im1 = imread('temple/im1.png');
    im2 = imread('temple/im2.png');
    load('q2_1.mat');
    x1 = pts1(1,1);
    y1 = pts2(1,2);
    
    
    im2 = rgb2gray(im2);
    [row,col] = size(im2);
    %line%
    p = [x1,y1,1];
    L = p*F;

    a = L(1);
    b = L(2);
    c = L(3);
    X = [1:col]';
    Y = [1:row]';
    if b==0 && a==0
        error('Zero line vector in displayEpipolar');
    end

    if a~=0
       k = -b/a;
       m = -c/a;
       Y = Y;
       X = k*Y+m;     
    end

    if a==0
       k = -a/b;
       m = -c/b;
       X=X;
       Y = -c/b*ones(size(Y,1),1);    
    end
    %remove wrrong point%
   
    X_wrong_ID=find(X<1|X>col);
    X (X_wrong_ID) = [];
    Y (X_wrong_ID) = [];

    Y_wrong_ID=find(Y<1|Y>row);
    X (Y_wrong_ID) = [];
    Y (Y_wrong_ID) = [];
    
    X_wrong_ID=find(abs(X-x1)>20);
    X (X_wrong_ID) = [];
    Y (X_wrong_ID) = [];

    Y_wrong_ID=find(abs(Y-y1)>20);
    X (Y_wrong_ID) = [];
    Y (Y_wrong_ID) = [];

    if size(X,1)>2
      X(1:2)=[];
      Y(1:2)=[];
    end
    
    % Considering a window around each pixel in the image and in the  have considered
    % Calculating a descriptor for the first image, we have:
    % Current point is x,y. Thus we have a range window around x,y
    window_size = 5;
    X_start = int32(X-floor(window_size/2));
    Y_start = int32(Y-floor(window_size/2));


    X1_start = int32(x1-floor(window_size/2));
    Y1_start = int32(y1-floor(window_size/2));
    window1 = im1(Y1_start:Y1_start+window_size-1,X1_start:X1_start+window_size-1);
    h = fspecial('gaussian',[window_size window_size],1.6);
    window1_blur=double(window1).*h;
    
    Dis =[];
    for i=1:size(X,1)-3
        window = im2(Y_start(i):Y_start(i)+window_size-1,X_start(i):X_start(i)+window_size-1);
        h = fspecial('gaussian',[window_size window_size],1.6);
        window_blur=double(window).*h;
        dis = sum(sum((window_blur-window1_blur).*(window_blur-window1_blur)));
        Dis = [Dis;dis];
    end
    ID = find(Dis==min(Dis));
    Id = ID(1);
    x2 = X(Id);
    y2 = Y(Id);


