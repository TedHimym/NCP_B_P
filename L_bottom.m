clear; clc;
%% Model_B
load('inject.mat', 't_c');
load('inject.mat', 'iosT');
load('steady_time.mat', 'steady_time')
load theta_mU.mat
load const_v.mat

%% get postion
L = cell(length(t_c), 1);
for indexO = 1: length(t_c)
    eF_L = zeros(length(t_c{indexO}), 1);
    for indexI = 1: length(t_c{indexO})
        eF_L(indexI) = length_of_inject_bottom(iosT{indexO, indexI}, 1, R(indexO));
    end
    L{indexO} = eF_L;
end

%% plot L vs t
hold on
for indexO = 1: length(t_c)
    nowT = t_c{indexO};
    nowL =   L{indexO};
    sL   = smooth(nowT, nowL, 0.05, 'loess')';
%     plot(nowT, sL)

    rv = gradient(sL, nowT);
    
%     Q = (mU(indexO,end).*theta(indexO,end).*(R(indexO)+theta(indexO,end).*0.15));
%     pQ = (2*pi*(R(indexO)+sL).*rv);
%     plot(nowT, pQ.*nowT)
    
    plot(nowT, rv)
    
%     pause
%     lhs = (nowT.*g(indexO).*0.0016.*7.*Q)./(2*pi*(R(indexO)+sL).*sL);
%     plot(power(lhs.*(nowT.^2),1/2), sL)
    
%     uin_d_1 = (R(indexO)+sL).*(sL.^3)./((g(indexO)*0.0016*7).*Q);
%     plot(nowT./steady_time(indexO), power(uin_d_1, 1/3)./steady_time(indexO), '-.')
end