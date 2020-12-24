clear; clc; close all;

load const_v.mat
load('steady_time_S.mat')

VF = {
    NProData('C:/Users/mfpcz/Documents/ProData/NC_BIGMD/Ra1E6Pr10/R0.010/data/', 'R0p01500-');
    NProData('C:/Users/mfpcz/Documents/ProData/NC_BIGMD/Ra1E6Pr10/R0.020/data/', 'R0p01500-');
    NProData('C:/Users/mfpcz/Documents/ProData/NC_BIGMD/Ra1E6Pr10/R0.040/data/', 'R0p01500-');
    NProData('C:/Users/mfpcz/Documents/ProData/NC_BIGMD/Ra1E6Pr10/R0.080/data/', 'R0p01500-');
    NProData('C:/Users/mfpcz/Documents/ProData/NC_BIGMD/Ra1E6Pr10/R0.250/data/', 'R0p01500-');
    NProData('C:/Users/mfpcz/Documents/ProData/NC_BIGMD/Ra1E6Pr10/R0.400/data/', 'R0p01500-');
    
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra1E7Pr10/R0.010/data/', 'R0p10000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra1E7Pr10/R0.020/data/', 'R0p10000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra1E7Pr10/R0.040/data/', 'R0p10000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra1E7Pr10/R0.080/data/', 'R0p10000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra1E7Pr10/R0.250/data/', 'R0p10000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra1E7Pr10/R0.400/data/', 'R0p10000-');
    
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra1E8Pr10/R0.010/data/', 'R0p01000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra1E8Pr10/R0.020/data/', 'R0p01000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra1E8Pr10/R0.040/data/', 'R0p01000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra1E8Pr10/R0.080/data/', 'R0p01000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra1E8Pr10/R0.250/data/', 'R0p01000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra1E8Pr10/R0.400/data/', 'R0p01000-');
    
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra5E8Pr10/R0.010/data/', 'R0p01000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra5E8Pr10/R0.020/data/', 'R0p01000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra5E8Pr10/R0.040/data/', 'R0p01000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra5E8Pr10/R0.080/data/', 'R0p01000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra5E8Pr10/R0.250/data/', 'R0p01000-');
    NProData('D:/ProjectData/NCPROJECT_big_modle/Ra5E8Pr10/R0.400/data/', 'R0p01000-');
    };

t_c      = cell(size(VF));
T_n      = 300;
iosT     = cell([length(VF), T_n]);
iosu     = cell([length(VF), T_n]);
U_r      = cell([length(VF), T_n]);
T_r      = cell([length(VF), T_n]);
r_c      = cell([length(VF), T_n]);
P        = cell([length(VF), T_n]);
rv_front = cell([length(VF), T_n]);
rv_botto = cell([length(VF), T_n]);
theta    = zeros(size(T_r));
mU       = zeros(size(U_r));
theti    = zeros(size(U_r));
scale    = [...
    7.6 7.6 7.6 7.6 7.6 7.6...
    30  30  30  30  30  30 ...
    19  19  19  19  19  19 ...
    50  50  50  50  50  50 ...
    ];

for ind = 1:length(VF)
    begin = min( VF{ind}.TimeList);
    endv  = steady_time(ind)*scale(ind);
    t = logspace(log10(begin), log10(endv), T_n);
    t_c{ind} = t;
    for now_t = 1: T_n
        [h_grid, r_grid, T_grid] = VF{ind}.GetData_Pos('h', 'r', t(now_t), 'T' );
        [     ~,      ~, u_grid] = VF{ind}.GetData_Pos('h', 'r', t(now_t), 'av');
        iosT{ind, now_t}         = contourc(h_grid(1,:), r_grid(:,1), T_grid, [299.9362 299.9362]);
        iosu{ind, now_t}         = contourc(h_grid(1,:), r_grid(:,1), u_grid, [299.9362 299.9362]);
        eP                       = inject_u(iosT{ind, now_t}, 1, R(ind));
        bP                       = length_of_inject_bottom(iosT{ind, now_t}, 1, R(ind));
        P{ind, now_t}            = eP;
        rv_front{ind, now_t}     = VF{ind}.GetData_Pos(eP(2), eP(1), t(now_t), 'rv' );
        rv_botto{ind, now_t}     = VF{ind}.GetData_Pos(bP(2), bP(1), t(now_t), 'rv' );
        [~, r_c{ind, now_t}, T_r{ind, now_t}] = VF{ind}.GetData_Pos(0.5, 'r', t(now_t), 'T' );
        [~, ~              , U_r{ind, now_t}] = VF{ind}.GetData_Pos(0.5, 'r', t(now_t), 'av');
        theta(ind, now_t)        = del_T(r_c{ind}, T_r{ind, now_t});
           mU(ind, now_t)        = getmU(r_c{ind}, U_r{ind, now_t});
        theti(ind, now_t)        = inject_t(iosT{ind, now_t}, 1, R(ind), theta(ind, now_t));
    end
end

function delv = del_T(R, T)
T = T(R < R(1)+0.5);
R = R(R < R(1)+0.5);
ER = min(T) + (max(T)-min(T))*0.99;
indexR=(T==min(T(T>ER)));
indexL=(T==max(T(T<ER)));
ER = interp1([T(indexL) T(indexR)], [R(indexL) R(indexR)], ER, 'linear');
delv = ER - min(R);
end
function mU = getmU(~, av)
mU = max(abs(av));
end
function P = inject_t(X, layer, R, theta)
ind = 1; LI = 1;
while (LI ~= layer)
    ind = ind + X(2, ind) + 1;
    LI = LI + 1;
end
xR = X(2, ind+1:ind+X(2,ind));
 z = X(1, ind+1:ind+X(2,ind));
P = min(z(xR<(R+2*theta)));
end 