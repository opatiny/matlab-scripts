%% sim12 3D graphics and animation
%% -------------------------------------------------------------------------
%% I 3D graphics

%% parametric plot
clear,clf
t=0:pi/50:10*pi;
plot3(t.*sin(t),t.*cos(t),t)


%% function with two arguments: f(x,y)
clear,clc,clf
fsurf(@(x,y) sin(sqrt(x.^2+y.^2))./sqrt(x.^2+y.^2))

x=-10:.5:10;
y=-5:.5:5;
[X, Y]=meshgrid(x,y);
R=sqrt(X.^2+Y.^2) + eps;
Z=sin(R)./R;
subplot(2,2,1),surfl(X,Y,Z), title('surfl')
subplot(2,2,2),mesh(X,Y,Z), title('mesh')
subplot(2,2,3),surfc(X,Y,Z), title('surfc')
subplot(2,2,4),surf(X,Y,Z), title('surf')

%% sphere and cylinder
clear,clf
[x,y,z] = sphere;                       % calculates sphere coordinates
surf(x-2,y,z), hold on
mesh(x-2,y,z+3,zeros(size(x)))          % additionally specifies the color of the edges

[x,y,z] = cylinder(.5);                 % radius 0.5 
surf(x+2,y,3*z-1)                       % height 3
[x,y,z] = cylinder(1);                  % radius 1
surf(x+2,y,z,'FaceAlpha',.5)            % 50% transparent                      
colorbar, axis equal


%% Varianten des surf-Befehls
clear, clf, clc
t = 0:pi/10:2*pi;                    
[X,Y,Z] = cylinder(2+cos(t));       % calculates cylinder coordinates

subplot(2,2,1)                      % MeshStyle row
surfc(X,Y,Z,'MeshStyle','row')
title('one dimensional grid')
subplot(2,2,2)                      
surf(X,Y,Z,0.7*ones(size(Z)))       % plain color
caxis([0 1]);
colorbar
title('monochrome')
subplot(2,2,3)                      % gray area
surf(X,Y,Z,'EdgeColor','interp','FaceColor',[0.7 0.7 0.7])
title('color grid edges only')
subplot(2,2,4)                       
surf(X,Y,Z,'FaceLighting','phong',...
    'EdgeColor','none','AmbientStrength',0.25)
caxis([-1 1.25]); colorbar          % change color scaling
light('Position',[-2,2,10])          
title('Lighting effects')

% colormap hot   
% colormap cool  

%% Plot toolbar
% select variables (x,y,z) in workspace
% select plot or view code

% more graphics commandse
help graph3d

% more examples 
sim12_graphics3D_example


%% function with three arguments: f(x,y,z)
clear,clf,clc
[x,y,z]=meshgrid(-1:0.1:1);
f=x.^2 + y.^2 + z.^2;

% slice
clf   % slices at x=-0.5 and x=+0.5, y=0, z=1
slice(x,y,z,f,[-.5,.5],0,1)
colorbar, axis equal 
xlabel('x'), ylabel('y'), zlabel('z')

% contourslice
clf  % slices at x=-1, x=1 and z=0 with 10 contour levels
contourslice(x, y, z, f, [-1 1], [], 0, 10)
colorbar, view(3), axis equal

% isosurface (equivalent to contour() in 3D)
clf
isosurface(x,y,z,f,1.4)
colorbar, hold on, axis equal
isosurface(x,y,z,f,0.7)


%% -------------------------------------------------------------------------
%% II Animation
%% -------------------------------------------------------------------------

%% comet plot
clear,clf
t=0:pi/10:10*pi;
subplot(121)
title('Comet')
comet(t,t.*sin(t),.01)
subplot(122)
title('Comet3')
comet3(t.*sin(t),t.*cos(t),t)

%% slow down plot command -> that's so cool
clear,clc,clf

Z = peaks; % 3D-Plot Data
surf(Z); 
axis tight
axis manual 
set(gca,'nextplot','replacechildren')
for k = 1:20 
   surf(sin(2*pi*k/20)*Z)
   pause(0.2)
end

%% AVI -> export animations
clear,clc,clf

Z = peaks;
surf(Z); 
axis tight 
axis manual 
set(gca,'nextplot','replacechildren'); 

v = VideoWriter('peaks.avi');
open(v);
for k = 1:20 
   surf(sin(2*pi*k/20)*Z,Z)
   frame = getframe;
   writeVideo(v,frame);
end
close(v);

% open system video player
winopen('peaks.avi')

%% Animated gif
clear,clc,clf

Z = peaks;
surf(Z); 
axis tight 
axis manual 
set(gca,'nextplot','replacechildren');

filename = 'peaks.gif';
for k = 1:20
    surf(cos(2*pi*k/20)*Z)
    frame = getframe(1);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,256);
    if k == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',.1);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',.1);
    end
end

%% exercise 12.1 plane wave
% https://de.wikipedia.org/wiki/Ebene_Welle
% A harmonic plane wave is described by the function f=A*sin(kx-wt)
% Animate the wave motion over time
clear,clc,clf
A=1;        % amplitude
T=1;        % period (1/f) 
lambda=1;   % wavelength
w=2*pi/T;       % angular frequency
k=2*pi/lambda;  % wave number
x=linspace(0,3*lambda);

for t = linspace(0, 3*T)
   plot(x, A*sin(k*x-w*t));
   pause(0.2);
end
