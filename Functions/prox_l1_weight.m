function [x,w_new]= prox_l1_weight(b,lambda,w,tau)
 
if nargin<4
    tau=5;
end
x = max(0,b-lambda*w)+min(0,b+lambda*w);
w_new = CalcWeights(x,tau);