function circle(x,y,r)
% Plot a circle with center x,y and radius r
fplot(@(t) r*sin(t)+x, @(t) r*cos(t)+y, 'k');
end