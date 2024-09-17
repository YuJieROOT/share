function [psnr_value, ssim_value, fsimc_value] = im_quality(image, ref)
%==========================================================================
% Evaluates the quality assessment indices for two tensors.
%
% Syntax:
%   [psnr_value, ssim_value, fsim_value] = quality(imagery1, imagery2)
%
% Input:
%   imagery1 - the reference tensor
%   imagery2 - the target tensor

% NOTE: the tensor is a M*N*K array and DYNAMIC RANGE [0, 255]. 

% Output:
%   psnr_value - Peak Signal-to-Noise Ratio
%   ssim_value - Structure SIMilarity
%   fsim_value - Feature SIMilarity

% See also StructureSIM, FeatureSIM
%
% by Yi Peng
% update by Yu-Bang Zheng 11/19/2018
%==========================================================================
% Nway = size(imagery1);
% psnr_value = zeros(Nway(3),1);
% ssim_value = psnr_value;
% fsim_value = psnr_value;
% for i = 1:Nway(3)
%     psnr_value(i) = psnr(imagery1(:, :, i), imagery2(:, :, i));
%     ssim_value(i) = ssim(imagery1(:, :, i), imagery2(:, :, i));
%     fsim_value(i) = FeatureSIM(imagery1(:, :, i), imagery2(:, :, i));
% end
% psnr_value = mean(psnr_value);
% ssim_value = mean(ssim_value);
% fsim_value = mean(fsim_value);
psnr_value=psnr(image, ref);
ssim_value=ssim(image, ref);
[~,fsimc_value]=FeatureSIM(image, ref);




