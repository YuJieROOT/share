function [X,tnn,trank,W_new] = prox_tnn_weight(Y,rho,W,tau)


if (nargin < 4)
    tau = 1;
end
 
[n1,n2,n3] = size(Y);
X = zeros(n1,n2,n3);
Y = fft(Y,[],3);
tnn = 0;
trank = 0;
W_new=W;        
% first frontal slice
[U,S,V] = svd(Y(:,:,1),'econ');
S = diag(S);
r = length(find(S>rho));
if r>=1
    S = S(1:r)-W(1:r,1)*rho;
    X(:,:,1) = U(:,1:r)*diag(S)*V(:,1:r)';
    tnn = tnn+sum(S);
    trank = max(trank,r);
    W_new(1:r,1)=CalcWeights(S,tau);W_new(r:end,1)=1;
end
% i=2,...,halfn3
halfn3 = round(n3/2);
for i = 2 : halfn3
    [U,S,V] = svd(Y(:,:,i),'econ');
    S = diag(S);
    r = length(find(S>rho));
    if r>=1
        S = S(1:r)-W(1:r,i)*rho;
        X(:,:,i) = U(:,1:r)*diag(S)*V(:,1:r)';
        tnn = tnn+sum(S)*2;
        trank = max(trank,r);
        W_new(1:r,i)=CalcWeights(S,tau);W_new(r:end,1)=1;
    end
    X(:,:,n3+2-i) = conj(X(:,:,i));
    W_new(:,n3+2-i)=W_new(:,i);
end

% if n3 is even
if mod(n3,2) == 0
    i = halfn3+1;
    [U,S,V] = svd(Y(:,:,i),'econ');
    S = diag(S);
    r = length(find(S>rho));
    if r>=1
        S = S(1:r)-W(1:r,i)*rho;
        X(:,:,i) = U(:,1:r)*diag(S)*V(:,1:r)';
        tnn = tnn+sum(S);
        trank = max(trank,r);
        W_new(1:r,i)=CalcWeights(S,tau);W_new(r:end,1)=1;
    end
end
tnn = tnn/n3;
X = ifft(X,[],3);
