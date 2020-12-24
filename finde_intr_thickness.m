
load('inject.mat', 't_c');
load('inject.mat', 'iosT');
load('steady_time.mat', 'steady_time')
load theta_mU.mat
load const_v.mat

P = cell(length(t_c), 1);
for indexO = 1: length(t_c)
    eF_P = cell(length(t_c{indexO}), 1);
    for indexI = 1: length(t_c{indexO})
        eF_P{indexI} = inject_t(iosT{indexO, indexI}, 1, R(indexO), theta(indexO,300));
    end
    P{indexO} = eF_P;
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

clf
hold on
plot([R R], [0 1])
plot(xR, z)
plot([R R+4], [P P])
axis equal; axis([0 4+R 0 1])
pause(0.01)

end 

