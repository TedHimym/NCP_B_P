function L = length_of_inject_bottom(X, layer, R)

ind = 1; LI = 1;

while (LI ~= layer)
    ind = ind + X(2, ind) + 1;
    LI = LI + 1;
end

xR = X(2, ind+1:ind+X(2,ind));
z  = X(1, ind+1:ind+X(2,ind));
if (min(z) > 0.005)
    L = 4;
else
    L = xR(z == min(z)) - R;
end


% clf
% hold on
% plot(xR(z == min(z)), min(z), '*')
% plot([R R], [0 1])
% plot(xR, z)
% axis equal; axis([0 4+R 0 1])
% pause(0.01)

end 