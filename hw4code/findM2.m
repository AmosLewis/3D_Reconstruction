   clc; clear;
    % Q2.5 - Todo:

    %       2. Obtain the correct M2
    %       4. Save the correct M2, p1, p2, R and P to q2_5.mat 

    load('q2_1.mat');
    load('temple/intrinsics.mat')
    E = essentialMatrix( F,K1,K2 );
    M1 = K1*[eye(3,3),zeros(3,1)];
    M2s = camera2(E);
    p1 = pts1;
    p2 = pts2;
    Error =[];
    for i =1:4
        M2 = K2*M2s(:,:,i);
        P  = triangulate( M1,p1,M2,p2 );
        P_estimate = P;
%         if all(P(3,:) > 0)
%             sprintf('correct M2 is: %d\n', i)
%             Pfinal = P;
%             M2 = M2s(:,:,i);
%         end

        p1_estimate = M1 * P_estimate ;
        p2_estimate = M2 * P_estimate ;
        
        p1_estimate(1,:) = p1_estimate(1,:)./p1_estimate(3,:);
        p1_estimate(2,:) = p1_estimate(1,:)./p1_estimate(3,:);
        p1_estimate(3,:) = [];
        p1_estimate = p1_estimate';
        p2_estimate(1,:) = p2_estimate(1,:)./p2_estimate(3,:);
        p2_estimate(2,:) = p2_estimate(1,:)./p2_estimate(3,:);
        p2_estimate(3,:) = [];
        p2_estimate = p2_estimate';       
        error = sum(sum((p1-p1_estimate).^2)) + sum(sum((p2-p2_estimate).^2));
        Error =[Error,error];    
   end
   n =find(Error == min(Error));
   M2 = K2*M2s(:,:,n);
   P  = triangulate( M1,p1,M2,p2 );
   sprintf('correct M2 is: %d\n', n)
   save('q2_5.mat','M2','p1','p2','P')