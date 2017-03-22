%function [ F ] = seven( pts1,pts2,M )
load('seven_pst.mat');
im1 = imread('temple/im1.png');
im2 = imread('temple/im2.png');
% cpselect(im1,im2);
[row,col,~]=size(im1);
M = max(row,col);    
    
    
    Pts1 = pts1(1:7,:);
    Pts2 = pts2(1:7,:);
    %nomalize%
    pts1 = pts1(1:7,:)/M;
    pts2 = pts2(1:7,:)/M;
    
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
    
    [~,~,V] = svd(A);
    
    f1 = V(:,end);
    f2 = V(:,end-1);
%     f1 = f1./norm(f1);
%     f2 = f1./norm(f2);
    F1 = [f1(1),f1(4),f1(7);...
          f1(2),f1(5),f1(8);...
          f1(3),f1(6),f1(9)];
    F2 = [f2(1),f2(4),f2(7);...
          f2(2),f2(5),f2(8);...
          f2(3),f2(6),f2(9)];
    
    syms b;
    a = solve(det(b*F1+(1-b)*F2)==0,b);
    a = double(a);
%      a = round(10000*a)/10000;
    
    T = [1/M,0,0;0,1/M,0;0,0,1];
    for i = 1:2
        if isreal(a(i))
            F{i} = a(i).*F1+(1-a(i)).*F2;
            %denomalize%
            F{i}=T'*F{i}*T;
            i =i+1;
        end
    end
    Fcorrect = F{2};
    pts1 = Pts1;
    pts2 = Pts2;
    save('q2_2.mat','Fcorrect','M','pts1','pts2');