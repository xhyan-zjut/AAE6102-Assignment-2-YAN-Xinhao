%
gt = [22.328444770087565; 114.1713630049711];

[error_lat,error_lon] = latlon_to_meters(22.328444770087565, 114.1713630049711, navSolutions.latitude, navSolutions.longitude);

error_height = navSolutions.height - 3;

% 参数设置
sigma = 3;          % 伪距噪声标准差 [m]
P_fa = 1e-2;        % 误报概率
P_md = 1e-7;        % 漏检概率
AL = 50;            % 3D警报限值 [m]
n_sat = 5;          % 卫星数量
num_samples = 39;% 样本数量

% 计算3D保护级别
PL_3D = 29.63;
fprintf('3D Protection Level: %.2f meters\n', PL_3D);


% 生成模拟数据（VPE和VPL）
rng(0); % 固定随机种子以便复现
VPE = error_lat'; % 垂直定位误差（正态分布）
VPL = PL_3D*ones(num_samples,1); % 垂直保护级别（带随机波动）

% 创建二维直方图数据
x_edges = linspace(0, 60, 50);
y_edges = linspace(0, 60, 50);
[N, ~, ~] = histcounts2(VPE, VPL, x_edges, y_edges);

% 绘制Stanford Chart热力图
figure;
h = pcolor(x_edges(1:end-1), y_edges(1:end-1), log10(N' + 1)); % 对数变换增强可视化
set(h, 'EdgeColor', 'none');
colormap(parula); % 推荐使用parula替代jet
colorbar;
hold on;

% 绘制AL阈值线（红色虚线）
plot(xlim, [AL AL], 'r--', 'LineWidth', 2, 'DisplayName', sprintf('AL=%.1fm', AL));

% 绘制对角线（黑色实线）：VPE = VPL
plot([0 max(xlim)], [0 max(ylim)], 'r --', 'LineWidth', 1.5, 'DisplayName', 'VPE = VPL');

% 绘制PL_3D参考线（蓝色实线）
plot([AL AL], ylim, 'r--', 'LineWidth', 2, 'DisplayName', sprintf('AL=%.1fm', PL_3D));

% % 标注安全区域（绿色半透明区域）
% fill([min(xlim) max(xlim) max(xlim) min(xlim)], ...
%      [0 0 AL AL], 'g', 'FaceAlpha', 0.5, 'EdgeColor', 'none', ...
%      'DisplayName', 'Safe Zone (VPL < AL)');

% % 标注危险区域（红色半透明区域，可选）
% fill([min(xlim) max(xlim) max(xlim) min(xlim)], ...
%      [AL AL max(ylim) max(ylim)], 'r', 'FaceAlpha', 0.8, 'EdgeColor', 'none', ...
%      'DisplayName', 'Hazard Zone (VPL > AL)');
% 
% fill([min(xlim) max(xlim) max(xlim) min(xlim)], ...
%      [AL AL max(xlim) max(xlim)], 'r', 'FaceAlpha', 0.8, 'EdgeColor', 'none', ...
%      'DisplayName', 'Hazard Zone (VPL > AL)');



% 图形标注
xlabel('Vertical Position Error (VPE) [m]');
ylabel('Vertical Protection Level (VPL) [m]');
title(sprintf('Stanford Chart Analysis\nn=%d satellites, σ=%.1fm, AL=%.1fm', n_sat, sigma, AL));
legend('Location', 'northeast');
grid on;

% 添加性能指标文本
text(0.05*max(xlim), 0.9*max(ylim), ...
     sprintf('P_{fa}=%.0e\nP_{md}=%.0e', P_fa, P_md), ...
     'BackgroundColor', 'white', 'FontSize', 10);

% 设置坐标轴范围
xlim([0 max(x_edges)]);
ylim([0 max(y_edges)]);


load('skymask_A1_urban.csv');
azimuth = skymask_A1_urban(:,1);
elevation = skymask_A1_urban(:,2);
% 假设你的数据是 360×2 矩阵: [Azimuth, Elevation]
% Azimuth: 0-360°（方位角）
% Elevation: 0-90°（仰角）

% --- 生成示例数据（替换为你的实际数据）---

% --- 绘制极坐标天势图 ---
figure;
polarplot(deg2rad(azimuth), 90 - elevation, 'b-', 'LineWidth', 1.5); % 90-el 使 0°=天顶
hold on;

% handles(1, 1) = subplot(1, 1, 1 : 1);
%     %--- Satellite sky plot -----------------------------------------------
%     skyPlot(handles(1, 1), ...
%             navSolutions.az, ...
%             navSolutions.el, ...
%             navSolutions.PRN(:, 1));
%         
%     title (handles(1, 1), ['Sky plot (mean PDOP: ', ...
%                                num2str(mean(navSolutions.DOP(2,:))), ')']);  
                           
% --- 标记卫星位置（示例：(az0=45°, el0=30°)）---
az0 = [57.373079481041
          139.846297612608
           21.819680619507
          41.5608139864159
          207.180891799642
          116.020031622361]; % 卫星方位角

el0 = [73.8389672888709
          22.3163665202597
          59.8762379792772
          46.8764477490953
          59.9415398414719
          28.4027161879816]; % 卫星仰角

% 转换为极坐标（径向距离 r = 90 - EL）
theta = deg2rad(az0);       % 方位角（弧度）
r = [90;90;90;90;90;90] - el0;               % 径向距离：天顶(r=0), 地平线(r=90)

% 绘制极坐标天顶图

ssl = polarplot(theta(1), r(1), 'go', 'MarkerSize', 10, 'LineWidth', 2);
ssn = polarplot(theta(2), r(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
polarplot(theta(3), r(3), 'go', 'MarkerSize', 10, 'LineWidth', 2);
polarplot(theta(4), r(4), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
polarplot(theta(5), r(5), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
polarplot(theta(6), r(6), 'ro', 'MarkerSize', 10, 'LineWidth', 2);

% 设置图形属性
title('天顶图（极坐标）');
rlim([0 90]);              % 限制径向范围
set(gca, 'ThetaDir', 'clockwise');      % 顺时针方向
set(gca, 'ThetaZeroLocation', 'top');   % 0°指向北方
ax = gca;
ax.RAxis.Label.String = 'Zenith Angle (90 - EL)';
legend([ssn, ssl], {'LOS', 'NLOS'}, 'Location', 'best');set(gca, 'ThetaDir', 'clockwise'); % 顺时针方向

% 
% ssn = polarplot(deg2rad(az0(1)), el0(1), 'ro', 'MarkerSize', 10, 'LineWidth', 5); % 红点标记卫星
% polarplot(deg2rad(az0(4)), el0(4), 'ro', 'MarkerSize', 10, 'LineWidth', 5); % 红点标记卫星
% polarplot(deg2rad(az0(3)), el0(3), 'ro', 'MarkerSize', 10, 'LineWidth', 5); % 红点标记卫星
% 
% 
% ssl = polarplot(deg2rad(az0(2)), el0(2), 'go', 'MarkerSize', 10, 'LineWidth', 5); % 红点标记卫星
% polarplot(deg2rad(az0(5)), el0(5), 'go', 'MarkerSize', 10, 'LineWidth', 5); % 红点标记卫星
% 
% hold off;
% 
% % --- 设置极坐标参数 ---
% title('Sky Mask Polar Plot');
% rlim([0 90]); % 径向范围：0=天顶，90=地平线
% set(gca, 'ThetaZeroLocation', 'top'); % 0°位于顶部（北）
% ax = gca;

function [PL_3D, HPL, VPL] = dynamic_PL(n_sat, sigma, P_fa, P_md, A, W)
    % 输入实时参数：卫星数n_sat，噪声sigma，几何矩阵A，权重W
    dof = n_sat - 4;
    
    % 3D PL计算
    T_thresh = chi2inv(1-P_fa, dof) * sigma^2;
    fun = @(PL) ncx2cdf(T_thresh, dof, (PL^2)/sigma^2) - (1 - P_md);
    PL_3D = fzero(fun, 50);
    
    % 分方向PL计算
    S = inv(A'*W*A); % 协方差矩阵
    K_H = 5.33;      % 水平扩展因子（假设值）
    K_V = 5.33;      % 垂直扩展因子
    
    HPL = K_H * sqrt(max(S(1,1), S(2,2)));
    VPL = K_V * sqrt(S(3,3));
end

function PL = calculate_3D_PL(n_sat, sigma, P_fa, P_md)
    dof = n_sat - 4; % 自由度
    T_threshold = chi2inv(1 - P_fa, dof) * sigma^2;
    
    fun = @(PL) ncx2cdf(T_threshold, dof, (PL^2)/sigma^2) - (1 - P_md);
    PL_guess = 50; % 初始猜测值
    options = optimset('Display','off');
    PL = fzero(fun, PL_guess, options);
end

function [distance_lat,distance_lon] = latlon_to_meters(latGT, lonGT, lat, lon)
    % 地球半径（米）
    R = 6371000;  
    
    % 纬度差和经度差
    latitude_diff = lat - latGT;
    longitude_diff = lon - lonGT;
    
    % 转换为米
    distance_lat = latitude_diff * (pi / 180) * R;  % 纬度转换
    distance_lon = longitude_diff * (pi / 180) * R * cosd(latGT);  % 经度转换
    
    % 计算总距离
end