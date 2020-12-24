%% Model_B
load('inject.mat', 't_c');
load('inject.mat', 'iosT');
load('steady_time.mat', 'steady_time')
load theta_mU.mat
load const_v.mat

%% get postion
P = cell(length(t_c), 1);
for indexO = 1: length(t_c)
    eF_P = cell(length(t_c{indexO}), 1);
    for indexI = 1: length(t_c{indexO})
        eF_P{indexI} = inject_u(iosT{indexO, indexI}, 1, R(indexO));
    end
    P{indexO} = eF_P;
end

%% load file
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

rv = cell(length(t_c), 1);

for indexO = 1: length(t_c)
    eF_rv = zeros(length(t_c{indexO}), 1);
    for indexI = 1: length(t_c{indexO})
        eP = P{indexO}{indexI};
        [~, ~, eF_rv(indexI)] = VF{indexO}.GetData_Pos(eP(2), eP(1), t_c{indexO}(indexI), 'rv' );
    end
    rv{indexO} = eF_rv;
end