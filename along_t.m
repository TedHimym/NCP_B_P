clear; clc;

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

T_n = 300;

U_r = cell([length(VF), T_n]);
T_r = cell([length(VF), T_n]);
t_c = cell(size(VF));
r_c = cell(size(VF));

hold on
for ind = 1:length(VF)
    begin = min( VF{ind}.TimeList);
    endv  = max( VF{ind}.TimeList);
    t = linspace(begin, endv, T_n);
    t_c{ind} = t;
    for now_t = 1: T_n
        [~, r_c{ind}, T_r{ind, now_t}] = VF{ind}.GetData_Pos(0.5, 'r', t(now_t), 'T' );
        [~, ~       , U_r{ind, now_t}] = VF{ind}.GetData_Pos(0.5, 'r', t(now_t), 'av');
    end
end

