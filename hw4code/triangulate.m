function [ P ] = triangulate( M1,p1,M2,p2 )
%TRIANGULATE 
%       M1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       M2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points
% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%   
    num = size(p1,1);
    P =[];
    A =[];
    for i = 1:num
        x1 = p1(i,1);
        x2 = p2(i,1);
        y1 = p1(i,2);
        y2 = p2(i,2);
        A = [ M1(1,:) - x1*M1(3,:);
              M1(2,:) - y1*M1(3,:);
              M2(1,:) - x2*M2(3,:);
              M2(2,:) - y2*M2(3,:)];
        [~,~,V]=svd(A'*A);
        p = V(:,end);
        p = p./norm(p);
        p = p/p(4);
        P = [P,p];
    end
end

