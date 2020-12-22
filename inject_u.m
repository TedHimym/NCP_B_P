function P = inject_u(X, layer, R)

ind = 1; LI = 1;

while (LI ~= layer)
    ind = ind + X(2, ind) + 1;
    LI = LI + 1;
end

xR = X(2, ind+1:ind+X(2,ind));
 z = X(1, ind+1:ind+X(2,ind));

pR = max(xR);
pz = z(xR == pR);
P = [pR pz];

% clf
% plot(pR, pz, 'o')
% hold on
% plot([R R], [0 1])
% plot(xR, z)
% axis equal; axis([0 4+R 0 1])
% pause(0.01)

end 