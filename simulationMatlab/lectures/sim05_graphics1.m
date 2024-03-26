%% SIM05 elementary graphics

% remember
% ctrl-return runs section %% ... %% aus

%% plot triangle
clear,clc,clf  % clear workspace, command window and figure
plot([0 2 1 0],[0 1 2 0])
%     x-coord   y-coord

%% plot Sinus
x=0:6;
plot(x,sin(x))      % blue line default

plot(x,sin(x),'--d')  % LineSpec

% doc plot - Input Arguments - LineSpec
% or quickref.pdf

%% Add plots
clear, clc, clf
x=1:0.1:6;

figure(1)  % direct next plot to figure 1
plot(x,sin(x),'ro-')
hold on    % retain current plot when adding new plot 
plot(x,cos(x),'b*-')   
hold off    % overwrite current plot when adding new plot

% or
figure(2)   
plot(x,sin(x),'.',x,cos(x),'g--')


%% labeling

grid on              
xlabel('x-Werte')    
ylabel('y-Werte')
title('Testplot')
text(pi,0,'\leftarrow Nullstelle','FontSize',14)
legend('sin','cos')   

%% set axis limits

xlim([2 5]);
ylim([-1 0]);
% combined
axis([3 4 -1 -0.5])    % xmin, xmax,  ymin, ymax

axis manual     % do not update axis limits in next plot
axis auto       % update axis limits in next plot (default)

% zoom, pan, data cursor in figure window

%% more details
clear, clc, clf
x=linspace(-pi,pi,20);
plot(x,sin(x),'ro-', ...
                'LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',4)
set(gca,'XTick',-pi:pi/2:pi)
set(gca,'XTickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})
grid on

% Achsen durch den Ursprung
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')

% Toolstrip-figure-propertyeditor

% more
help graph2d
help graphics

%% Export

% File - save as
% Edit - copy figure

%% exercise 5.1
% plot this function 
%
%         / 2    \0.01   /                                        7 \
% f(x) = (-x + 4 |      | sqrt(|x|) + cos(200 x) sqrt(cos(x)) -  -- |
%         \      /       \                                       10 /

x=-2:.001:2;

f = (-x.^2 + 4).^0.01.*(sqrt(abs(x)) + cos(200*x) .* sqrt(cos(x)) - 7/10);

plot(x, f);

%% exercise 5.2: plot the given coordinates
X = [-6 -6 -7 0 7 6 6 -3 -3 0 0 -6;     % x-Koord.
     -7 2 1 8 1 2 -7 -7 -2 -2 -7 -7];   % y-Koord.
 
plot(X(1,:), X(2, :))
 
%% exercise 5.3: plot a triangle
% Three cartesian coordinates define a triangle
% Draw the triangle and mark the centroid with *
% https://en.wikipedia.org/wiki/Centroid#Of_a_triangle

x=[2 1 0];
y=[2 4 1];

xCent = sum(x)/length(x)
yCent = sum(y)/length(y)

x = [x x(1)];
y = [y y(1)];

plot(x,y); hold on;
plot(xCent, yCent, 'r.', 'MarkerSize', 10);
hold off;

%% exercise 5.4: plot a circle 
% Draw a circle around P=(x,y) with Radius R
% Hint: calculate the coordinates of the circle line and use plot

x0=3;    % center
y0=2;
R=1.5;  % radius

angle = 0:2*pi/1000:2*pi;
x = x0 + R*cos(angle);
y = y0 + R*sin(angle);

fill(x,y, 'g');
axis equal;

%% exercise 5.5: Rotation matrix
% https://en.wikipedia.org/wiki/Rotation_matrix
% Draw vector v and rotate it by angle phi

v=[2;1];    % vector
phiDeg=120;    % angle of rotation in °

phi = deg2rad(phiDeg);

R = [cos(phi) -sin(phi);
     sin(phi) cos(phi)];
 
vRot = R*v;

plot([0 v(1)], [0, v(2)]); hold on;
plot([0 vRot(1)], [0, vRot(2)]);
hold off;
axis([-5 5 -5 5]);
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')



























   
   