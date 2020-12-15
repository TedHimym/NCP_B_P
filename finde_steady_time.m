clear; clc;

global t_c theta
%%
% load('theta_mU.mat', 'theta')
% load('inject.mat'  ,   't_c')
%%
load('theta_mU_S.mat', 'theta')
load('Ra1E6_5E8.mat')
%%

t_c = cell2mat(t_c);
t_i = [...
    25 25 25 25 25 25 ...
    10 10 10 10 10 10 ...
    3  3  3  3  3  3  ...
    2  2  2  2  2  2  ...
    ];

steady_time = zeros(size(t_c,1), 1);

for index = 1: size(t_c, 1)
    fprintf('File Number is %.3d', index)
    lhs = min(t_c(index,:));
    rhs = t_i(index);
    steady_time(index) = gold_split(lhs, rhs, index);
    fprintf('\n')
end

plot(t_c', theta')
%%
% save('steady_time.mat', 'steady_time')
%%
save('steady_time_S.mat', 'steady_time')
%%

function nf = nigtave_f(t, index)
global t_c theta
nf = interp1(t_c(index,:), theta(index,:), t, 'linear');
end

function x = gold_split(a, b, index)
% fprintf(' |%.3f,%.3f|',a,b)
fprintf(' |%.3f,%.3f|', a, b)
if (abs(a-b) < 0.01)
    x = (a+b)/2;
    return;
end

rhs = a + 0.618*(b -a);
lhs = b - 0.618*(b -a);

% global t_c theta
% clf
% plot(t_c(index,:), theta(index,:))
% hold on
% plot([a lhs rhs b], [nigtave_f(a, index) nigtave_f(lhs, index) nigtave_f(rhs, index) nigtave_f(b, index)], 'o')
% pause(0.05)

if (nigtave_f(lhs, index) > nigtave_f(rhs, index))
    x = gold_split(a, rhs, index);
else
    x = gold_split(lhs, b, index);
end
end