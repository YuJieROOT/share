function [ w ] = CalcWeights_l1_Fair(res,tau )
%Adaptive Weight Learning for DATRPCA (2023-TIP)

if (nargin < 2)
    tau = 1;
end
%Update sigma-----------------------------------------------------
     res_abs=abs(res); res_abs_vec=res_abs(:);  
     tau2=tau*mean(res_abs_vec)+eps; %Here the coefficient tau can be tuned. 
%Update weight----------------------------------------------------- 
     w =1./((1+res_abs/tau2).^2);  

end

