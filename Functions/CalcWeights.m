function [ w ] = CalcWeights(res,tau )
%Adaptive Weight Learning for DATRPCA (2023-TIP)

if (nargin < 2)
    tau = 1;
end
%Update sigma-----------------------------------------------------
     res_abs=abs(res); res_abs_vec=res_abs(:);  
     gamma=tau*mean(res_abs_vec)+eps; %Here the coefficient tau can be tuned. 
%Update weight----------------------------------------------------- 
     w = exp(-res_abs/gamma); 

end

