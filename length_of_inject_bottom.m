function P = length_of_inject_bottom(X, layer, R)

ind = 1; LI = 1;

while (LI ~= layer)
    ind = ind + X(2, ind) + 1;
    LI = LI + 1;
end

xR = X(2, ind+1:ind+X(2,ind));
z  = X(1, ind+1:ind+X(2,ind));

[z, I] = sort(z);
xR = xR(I);
Ind = z < 0.1;

if (min(z) > 0.005)
    L = 4;
else
    L = xR(z == min(z));
%     L = interp1(z(Ind), xR(Ind), 0.05, 'linear');
end
P = [L min(z)];


% clf
% hold on
% plot(xR(z == min(z)), min(z), '*')
% plot([R R], [0 1])
% plot(xR, z)
% axis equal; axis([0 4+R 0 1])
% pause(0.01)

end 