function [X,htnn,tsvd_rank,W_new] = prox_htnn_C_Weight_Huber(Y,rho,W,tau)

%The proximal operator for the order-D tensor nuclear norm under Discrete Cosine Transform (DCT)
%
% Written by  Wenjin Qin  (qinwenjin2021@163.com)
%

W_new=W;
p = length(size(Y));
n = zeros(1,p);
for i = 1:p
    n(i) = size(Y,i);
end
X = zeros(n);

for i = 1:p-2
    M{i} = sqrt(n(i+2))*dct(eye(n(i+2)));
end

L = ones(1,p);
for i = 3:p
     Y = tmprod(Y,M{i-2},i);
    L(i) = L(i-1) * n(i);
end

htnn = 0;
tsvd_rank = 0;
       
for i=1:L(p)
[U,S,V] = svd(Y(:,:,i),'econ');
S = diag(S);
W_new(:,i)=CalcWeights_Huber_root(S+eps,tau);
%r = length(find(S>rho));
r = length(find(S>W(1:end,i)*rho));
if r>=1
   % S =max( S(1:r)-rho,0);
   S = max(S(1:r)-W(1:r,i)*rho,0);
    X(:,:,i) = U(:,1:r)*diag(S)*V(:,1:r)';
    htnn = htnn+sum(S);
    tsvd_rank = max(tsvd_rank,r);
    %  W_new(1:r,i)=CalcWeights_Huber_root(S,tau);
    %  W_new(r:end,i)=1;
end
end

% for i=1:L(p)
%  [U,S,V] = svd(Y(:,:,i));
%  S = diag(S);
%    S = max(S-W(:,i)*rho,0);
%     X(:,:,i) = U*diag(S)*V';
%     htnn = htnn+sum(S);
%     tsvd_rank = max(tsvd_rank,r);
%      W_new(:,i)=CalcWeights_Huber_root(S+eps,tau);
%      %W_new(r:end,i)=1;
% end

rho=1;
for j=3:p
     Tran_M=M{j-2};
     a=sum(diag(Tran_M*(Tran_M)'))/n(j);
     rho=rho*a;
end

htnn = htnn/rho;

for i = p:-1:3
    X = tmprod(X,inv(M{i-2}),i);
end  

X = real(X);
