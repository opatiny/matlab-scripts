%% Verify output beam shape for a spherical dioptre
clc; clear; close all;

%% Dioptre characteristics
nv = 1.34; % [-]
radius = 25; % [mm]

%% load experimental data
data = readtable('labo5-dioptreSpherique-data.csv'); % [mm]
x = data.x; % [mm]
h1 = data.d1/2; % [mm]
h2 = data.d2/2; % [mm]

%% compute theoretical beams

y0 = [1e-3,1,2,3,4,5,6,7.5,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]; % coo-y points de d´epart

nbBeams = length(y0);

x0 = zeros(1,nbBeams)-50; % coo-x points de depart
y1 = y0; % coo-y points sur le dioptre
x1 = -sqrt(radius^2-y0.^2); % coo-x points sur le dioptre
a1g = -atan(y1./x1); % angle d’incidence (gauche du dioptre)
a1d = asin(sin(a1g)/nv); % angle de r´efraction (droite du dioptre)
beta = pi/2-a1d+a1g; % angle interne
y2 = sin(a1d)./sin(beta)*radius; % coo-y point sur dioptre de sortie
x2 = zeros(1,nbBeams); % coo-x point sur dioptre de sortie, par choix
a2g = beta-pi/2; % angle d’incidence (gauche du dioptre de sortie)
a2d = asin(nv*sin(a2g)); % angle de r´efraction (droite du dioptre de sortie)
y3 = zeros(1,nbBeams); % coo-y sur axe optique, 0 par construction
x3 = y2./tan(a2d); % coo-x sur axe optique
md = (y3-y2)./(x3-x2); % pentes des rayons
pd = y2-md.*x2; % ordonn´ee `a l’origine des rayons
mg = (y1-y0)./(x1-x0);
pg = y0-mg.*x0;
xint = (pd-pg)./(mg-md);
yint = mg.*xint+pg;

t = linspace(pi/2,3*pi/2,1000);
figure(1)
plot(radius*cos(t),radius*sin(t), 'Color', 'black'); axis equal;
hold on
plot([0,0],[-50,50], 'Color', 'black')
for i = 1:nbBeams
    color = 'black';
    if i == 4 || i == 8 
        color = 'red';
    end
plot([x0(i),x1(i),x2(i),x3(i)],[y0(i),y1(i),y2(i),y3(i)], 'Color', color);
plot([x1(i),xint(i)],[y1(i),yint(i)], 'Color', color);
plot([xint(i),x2(i)],[yint(i),y2(i)], 'Color', color);
plot(xint,yint, 'Color', color)
end

plot(x,h1, '.');
plot(x, h2, '.');
grid on;
hold off

