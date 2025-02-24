%% Assignment 7 - Exercise 2
clear,clc,clf

% plot grid
x=-2:0.05:2;
[X,Y]=meshgrid(x);

% calculate vector field on grid
d=2;    % distance of two currents in x
[Hx,Hy]=H2d(X,Y,d);

% plot vectorfield
streamslice(X,Y,Hx,Hy);
axis equal, axis tight
xlabel('x'),ylabel('y')

% integration path: square with side 2s
s=1.5;
% plot integration path
rectangle('Position',[-s,-s,2*s,2*s])

% compute integral over the perimeter of the rectangle
Hintx = integral(@(x) H2dx(x,s,d),s,-s);
Hinty = integral(@(y) H2dy(s,y,d),-s,s);

Hint = 2*(Hintx + Hinty)
% result should be equal to 2A!! (enclosed currents)

% magnetic field at (x,y) of two parallel currents (I=1A) with distance d
function [Hx,Hy]=H2d(x,y,d)
r = (x-d/2).^2 + y.^2;
Hx= -1./(2*pi*r).*y;
Hy= +1./(2*pi*r).*(x-d/2);
r = (x+d/2).^2 + y.^2;
Hx=Hx -1./(2*pi*r).*y;
Hy=Hy +1./(2*pi*r).*(x+d/2);
end

% only in x
function Hx=H2dx(x,y,d)
r = (x-d/2).^2 + y.^2;
Hx= -1./(2*pi*r).*y;
r = (x+d/2).^2 + y.^2;
Hx=Hx -1./(2*pi*r).*y;
end

% only in y (otherwise integral can't access second argument)
function Hy=H2dy(x,y,d)
r = (x-d/2).^2 + y.^2;
Hy= +1./(2*pi*r).*(x-d/2);
r = (x+d/2).^2 + y.^2;
Hy=Hy +1./(2*pi*r).*(x+d/2);
end