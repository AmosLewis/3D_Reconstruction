function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
%EPIPOLARCORRESPONDENCE 
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q2.6 - Todo:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q2_6.mat
%
%           Explain your methods and optimization in your writeup
%

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
       X=X;
       Y = -c/b*ones(size(Y,1),1);    
    end
    %remove wrrong point%
    X_wrong_ID=find(X<1|X>col|((abs(X-x1))>15));
    X (X_wrong_ID) = [];
    Y (X_wrong_ID) = [];

    Y_wrong_ID=find(Y<1|Y>row|((abs(Y-y1))>15));
    X (Y_wrong_ID) = [];
    Y (Y_wrong_ID) = [];
    
    %at picture corner
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
    for i=1:size(X,1)
        window = im2(Y_start(i):Y_start(i)+window_size-1,X_start(i):X_start(i)+window_size-1);
        h = fspecial('gaussian',[window_size window_size],1.6);
        window_blur=double(window).*h;
        dis = sum(sum((window_blur-window1_blur).*(window_blur-window1_blur)));
        Dis = [Dis;dis];
    end
    ID = find(Dis==min(Dis));
    if numel(ID) == 0
        x2=x1;
        y2=y1;
    else
        Id = ID(1);
        x2 = X(Id);
        y2 = Y(Id);
    end
end

