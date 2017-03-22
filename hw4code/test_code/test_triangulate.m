% [ P ] = triangulate( M1,p1,M2,p2 )

load('q2_1.mat');
load('temple/intrinsics.mat')
E = essentialMatrix( F,K1,K2 );
M1 = K1*[eye(3,3),zeros(3,1)];
M2s = camera2(E);
M2 = K2*M2s(:,:,3);
p1 = pts1;
p2 = pts2;

num = size(p1,1);
P =[];
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














