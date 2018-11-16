%=======================================================%
% Programmers: 
% Wing-Kin Ma, E-mail: wkma@ieee.org
% Tsung-Han Chan, E-mail: chantsunghan@gmail.com
% Date: Dec. 26, 2007
% -------------------------------------------------------
% Reference: 
% T.-H. Chan, W.-K. Ma, C.-Y. Chi, and Y. Wang, ``A convex analysis 
% framework for blind separation of non-negative sources," submitted to
% IEEE Trans. Signal Process., July 2007. Accepted subject to minor
% revision, Dec 2007.
%=======================================================%
% This is a simple example for 5 human face separation using CAMNS algorithm
% N is number of sources
% M is number of observations (sensors)

clear all;close all;
N=5;
M=N; 

%----------------loading images--------------------------
IMG1=double(imread('1_v.bmp'))/255;
IMG2=double(imread('2_v.bmp'))/255;
IMG3=double(imread('3_v.bmp'))/255;
IMG4=double(imread('4_v.bmp'))/255;
IMG5=double(imread('5_v.bmp'))/255;
[m,n]=size(IMG1); L=m*n; % data length

%----------Vectorize the loaded images--------------------
S=[vec(IMG1) vec(IMG2) vec(IMG3) vec(IMG4) vec(IMG5)]; % source matrix L by N
%--- truncate to the specified no. of sources
S= S(:,1:N);
%-----------randomly unit row-sum mixing matrix---------
A=rand(N,M); A=(A./(ones(N,1)*sum(A))).'; % mixing matrix
%-----------Generate the observations--------------------
X=S*A';       % observation matrix L by M

%---------------Apply CAMNS-LP algorithm-------------------------------
hS =CAMNS_LP(X,N); % CAMNS-LP algorithm

%---------------plotting------------------------------
figure; cnt= 1;
for i=1:N;
    subplot(3,N,cnt); imshow(reshape(S(:,i),m,n)); title(['source ', num2str(i)]);
    subplot(3,N,N+cnt); imshow(reshape(X(:,i),m,n)); title(['observ. ', num2str(i)]);
    subplot(3,N,2*N+cnt); imshow(reshape(hS(:,i),m,n)); title(['source est. ', num2str(i)]);
    cnt= cnt+ 1;
end
