%   Now, we can determine the 3D location of these point correspondences using
%   the triangulate function. These 3D point locations can then plotted using the
%   MATLAB function scatter3. The resulting figure can be rotated using the Rotate
%   3D tool, which can be accessed through the figure menubar.
%

    clc;clear
    load('temple/templeCoords.mat');
    load('q2_1.mat');
    load('temple/intrinsics.mat')
    im1 = imread('temple/im1.png');
    im2 = imread('temple/im2.png');
    E = essentialMatrix( F,K1,K2 );
    M1 = K1*[eye(3,3),zeros(3,1)];
    M2s = camera2(E);
    M2 = K2*M2s(:,:,3);

    p1=[x1,y1];
    p2=[];
    for i=1:size(x1,1)
       [x2,y2] = epipolarCorrespondence( im1, im2, F, x1(i), y1(i) );
       p2 =[p2;x2,y2];
    end
    P = triangulate( M1,p1,M2,p2 );
    h=scatter3(P(1,:),P(2,:),P(3,:));
