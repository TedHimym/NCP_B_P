clear; clc; close all;
load Ra1E7_1E8_5E8
load Ra1E6

r_c = [r_c_Ra1E6; r_c_Ra1E7_Ra1E8_Ra5E8];
t_c = [t_c_Ra1E6; t_c_Ra1E7_Ra1E8_Ra5E8];
T_r = [T_r_Ra1E6; T_r_Ra1E7_Ra1E8_Ra5E8];
U_r = [U_r_Ra1E6; U_r_Ra1E7_Ra1E8_Ra5E8];

T_n = 300;

%%

theta = zeros(size(T_r));
mU    = zeros(size(U_r));
for indo = 1: length(t_c)
    for indi = 1: T_n
        theta(indo, indi) = del_T(r_c{indo}, T_r{indo, indi});
           mU(indo, indi) = getmU(r_c{indo}, U_r{indo, indi});
        if (theta(indo, indi) > 1)
            plot(r_c{indo}, T_r{indo, indi});
        end
    end
end

figure(1); hold on;
figure(2); hold on;
for ind = 1: length(t_c)
    figure(1); plot(t_c{ind}, theta(ind,:))
    figure(2); plot(t_c{ind},    mU(ind,:))
end

save('theta_mU', 'theta', 'mU');
%%

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