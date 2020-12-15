function delta = contourLplot_delta(X, layer, R)
ind = 1; LI = 1;
while (LI ~= layer)
    ind = ind + X(2, ind) + 1;
    LI = LI + 1;
end

x = X(2, ind+1:ind+X(2,ind));
y = X(1, ind+1:ind+X(2,ind));
try
    Ind = (y<0.51)&(y>0.49)&(x<(R+0.3))&(x>R);
    sy = y(Ind);
    [sy, I] = sort(sy);
    sx = x(Ind); sx = sx(I);
    delta_R = interp1(sy, sx, 0.5, 'linear');
    delta = delta_R - R;
catch
    disp('debug')
end

% clf; hold on;
% plot(x, y, '-')
% plot([R R], [0 1], '-')
% plot([R, delta_R], [0.5 0.5], '-')
% axis equal; axis([0 4+R 0 1])
% pause

end