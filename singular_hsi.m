clear;clc;close all
% 读取MAT文件
load('DC_mall_200×200×160.mat')

% 提取数据
I = data(:,:,:);

I = abs(porder_diff(I,2));

% 初始化存储奇异值的数组
singular_values_I = cell(1, size(I,3));

for i = 1:size(I,3)
    I_frame = I(:, :, i);
    
    % 计算当前帧Y分量的奇异值
    [~, S, ~] = svd(double(I_frame));
    singular_values_I{i} = diag(S);
    
end

% 选择要绘制的帧的奇异值，例如第1帧
singular_values = singular_values_I{1};

% 4. 绘制奇异值图
figure;
plot(singular_values, 'r', 'LineWidth', 2);
xlabel('Index', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Singular value', 'FontSize', 12, 'FontWeight', 'bold');
grid on;

% % 保存图形为PDF文件
% saveas(gcf, 'singular_yuv_mode_1.pdf');