function L = contourLplot(X, layer, R)
ind = 1; LI = 1;
while (LI ~= layer)
    ind = ind + X(2, ind) + 1;
    LI = LI + 1;
end
% clf
% plot(X(2, ind+1:ind+X(2,ind)), X(1, ind+1:ind+X(2,ind)))
% hold on
% plot([R R], [0 1])
% axis equal; axis([0 4+R 0 1])
% pause
L = max(X(2, ind+1:ind+X(2,ind))) - R;
end 