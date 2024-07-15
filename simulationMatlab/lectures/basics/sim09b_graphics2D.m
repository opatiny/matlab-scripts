%% sim09b plot commands for 2d data

%% imagesc, colormap
clear,clc
% Each element of A specifies the color for one pixel of the image
% The color is defined in the colormap

A=eye(50);
imagesc(A)
colorbar      % show color legend

imagesc(rand(50)) 
   
imagesc(magic(50));
colorbar;            
colormap(flipud(colormap))  % flip colormap
 
colormap(gray);             % jet, copper, hot, gray ...

load('Mandrill');           % read image data and colormap
imagesc(X)
colormap(map)

colormap(gray)
colormap(jet);           


%% contourplot for functions
figure()
fcontour(@(x,y) x.^2+y.^2), axis equal

f=@(x,y) 3*(1-x).^2.*exp(-(x.^2) - (y+1).^2) ...
   - 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) ...
   - 1/3*exp(-(x+1).^2 - y.^2);

% define interval, levels and mesh density
fcontour(f,[-2,2, -3,3],'MeshDensity',100, 'LevelList',-6:.2:8)    
colorbar

% chose number of levels with option 'LevelStep' !!


%% contourplot for data: contour(X,Y,Z)

% generate regulary spaced data with meshgrid
x=linspace(-2,2,50);
y=linspace(-3,3,50);
[X,Y]=meshgrid(x,y);

% what does meshgrid do?
% it is the 2D extension of the linspace command
% in X,Y there are all coordinates of a regulary spaced grid
% simple example
[a,b]=meshgrid(-2:2,-1:1)

contour(X,Y,f(X,Y),9)      % 9/30 levels
contour(x,y,f(X,Y),30)   % grid coordinates may be vectors or arrays 
colorbar, axis equal

% with filling
contourf(X,Y,f(X,Y),30)  

% with labeling of levels
c=-6:2:6; % levels
[C,h]=contour(X,Y,f(X,Y),c)   
clabel(C,h,c);

load penny
contour(P,99),axis equal tight, colormap(copper)

% How can you flip the image?

%% exercise 9.2 Isolinie
% draw the contour line of the function 
% f(x,y)= (x^2+y-11)^2+(x+y^2-7)^2
% in the interval  -5 < x,y < 5

f = @(x,y) (x.^2 + y - 11).^2 + (x + y.^2 - 7).^2;

x=linspace(-5,5,50);
y=linspace(-5,5,50);
[X,Y]=meshgrid(x,y);

Z = f(X,Y);
figure(1);
contour(X,Y, Z, 30);
axis equal;
colorbar;
colormap(jet)

% or
figure(2);
fcontour(f,[-5,5], 'LevelStep', 50);
axis equal;
colorbar;
colormap(gray);

%% vector field 1 (streamslice)
% magnetic field of a long straight conductor with current I
% the conductor is located at x=y=0
% Hx = I/(2pi r^2) * (-y)
% Hy = I/(2pi r^2) * (+x)
% with r = sqrt(x^2+y^2)

clear,clc,clf
I=1;    % current [A]
% plot grid
X=-2:0.01:2;
[x,y]=meshgrid(X);
% radius square
r2 = x.^2 + y.^2;

% vector field of H
Hx= -I./(2*pi*r2).*y;
Hy=  I./(2*pi*r2).*x;

H = getNorm(Hx, Hy);

% plot magnetic field
imagesc(X,X,H);
colormap(jet); % change the colors of the image
colorbar; % show the color bar (axis)
clim([0 3]); % clamp to a max value of 40

% draw vector field
hold on;
p = streamslice(x,y,Hx,Hy);
set(p,'LineWidth', 1)
set(p,'Color','w');
hold off;
axis equal, axis tight

%% vector field 2 (quiver)
% By default, the quiver function scales the arrow lengths so that they do not overlap
X=-2:0.5:2;
[x,y]=meshgrid(X);
% radius square
r2 = x.^2 + y.^2;

% vector field of H
Hx= -I./(2*pi*r2).*y;
Hy=  I./(2*pi*r2).*x;
quiver(x,y,Hx,Hy)
axis equal, axis tight, grid on

%% Heatmap creates a heatmap from matrix data 
clf
A=rand(9);  % 9x9 random numbers
heatmap(A)

% detect outliers
A(3,7)=3;
heatmap(A)

%% Scatter plot of temperature measured in March 
clear,clf
data = readtable("sim09_Dateien/sim09_MarchTemps.txt")
% size and color of marker can be individually defined (plot cannot)
scatter(data.longitude,data.latitude,[],data.temperature,"filled")
colormap(jet)
colorbar
axis equal
xlabel('longitude')
ylabel('latitude')

% Which country is displayed?
%% more examples for 2D graphics: sim09_example.m