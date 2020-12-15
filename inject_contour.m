clear; clc; close all;

VF = {
    NProData('./Ra1E7Pr10/R0.010/data/', 'R0p10000-');
    NProData('./Ra1E7Pr10/R0.020/data/', 'R0p10000-');
    NProData('./Ra1E7Pr10/R0.040/data/', 'R0p10000-');
    NProData('./Ra1E7Pr10/R0.080/data/', 'R0p10000-');
    NProData('./Ra1E7Pr10/R0.250/data/', 'R0p10000-');
    NProData('./Ra1E7Pr10/R0.400/data/', 'R0p10000-');
    
    NProData('./Ra1E8Pr10/R0.010/data/', 'R0p01000-');
    NProData('./Ra1E8Pr10/R0.020/data/', 'R0p01000-');
    NProData('./Ra1E8Pr10/R0.040/data/', 'R0p01000-');
    NProData('./Ra1E8Pr10/R0.080/data/', 'R0p01000-');
    NProData('./Ra1E8Pr10/R0.250/data/', 'R0p01000-');
    NProData('./Ra1E8Pr10/R0.400/data/', 'R0p01000-');
    
    NProData('./Ra5E8Pr10/R0.010/data/', 'R0p01000-');
    NProData('./Ra5E8Pr10/R0.020/data/', 'R0p01000-');
    NProData('./Ra5E8Pr10/R0.040/data/', 'R0p01000-');
    NProData('./Ra5E8Pr10/R0.080/data/', 'R0p01000-');
    NProData('./Ra5E8Pr10/R0.250/data/', 'R0p01000-');
    NProData('./Ra5E8Pr10/R0.400/data/', 'R0p01000-');
    
    NProData('C:/Users/mfpcz/Documents/ProData/NC_BIGMD/Ra1E6Pr10/R0.010/data/', 'R0p01500-');
    NProData('C:/Users/mfpcz/Documents/ProData/NC_BIGMD/Ra1E6Pr10/R0.020/data/', 'R0p01500-');
    NProData('C:/Users/mfpcz/Documents/ProData/NC_BIGMD/Ra1E6Pr10/R0.040/data/', 'R0p01500-');
    NProData('C:/Users/mfpcz/Documents/ProData/NC_BIGMD/Ra1E6Pr10/R0.080/data/', 'R0p01500-');
    NProData('C:/Users/mfpcz/Documents/ProData/NC_BIGMD/Ra1E6Pr10/R0.250/data/', 'R0p01500-');
    NProData('C:/Users/mfpcz/Documents/ProData/NC_BIGMD/Ra1E6Pr10/R0.400/data/', 'R0p01500-');
    };

t_c = cell(size(VF));
T_n = 300;
iosT = cell([length(VF), T_n]);
iosu = cell([length(VF), T_n]);

for ind = 1:length(VF)
    begin = min( VF{ind}.TimeList);
    endv  = max( VF{ind}.TimeList);
    t = linspace(begin, endv, T_n);
    t_c{ind} = t;
    for now_t = 1: T_n
        [h_grid, r_grid, T_grid] = VF{ind}.GetData_Pos('h', 'r', t(now_t), 'T' );
        [     ~,      ~, u_grid] = VF{ind}.GetData_Pos('h', 'r', t(now_t), 'av');
        iosT{ind, now_t} = contourc(h_grid(1,:), r_grid(:,1), T_grid, [299.9362 299.9362]);
        iosu{ind, now_t} = contourc(h_grid(1,:), r_grid(:,1), u_grid, [299.9362 299.9362]);
    end
end