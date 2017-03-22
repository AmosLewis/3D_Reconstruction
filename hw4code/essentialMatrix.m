function [ E ] = essentialMatrix( F,K1,K2 )
%  F - Fundamental Matrix
%  K1 - Camera Matrix 1
%  K2 - Camera Matrix 2

% Q2.3 - Todo:
%       Compute the essential matrix 
%
%       Write the computed essential matrix in your writeup

E = (K2)'*F*K1;
end

