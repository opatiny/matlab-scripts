%% Calculs precision angulaire du robot
clf; clear; clc; close all;

%% variables

d = 0.15; % m
e = 0.1; % m
Dt = 0.04; % m
Db = 0.02; % m
% https://www.galaxus.ch/fr/s5/product/vbs-boules-en-bois-sans-trou-20-mm-fournitures-pour-loisirs-creatifs-39369347?supplier=9252808&utm_source=google&utm_medium=cpc&utm_campaign=PMax:+PROD_CH_SSC_Cluster_5(C)&campaignid=20448046287&adgroupid=&adid=&dgCidg=CjwKCAiA9IC6BhA3EiwAsbltONJ3s6qkDHwKnfvh2evW57FZLWLti91uWqOnwbIE01Qhe5ydXae4hBoCMKEQAvD_BwE&gad_source=1&gclid=CjwKCAiA9IC6BhA3EiwAsbltONJ3s6qkDHwKnfvh2evW57FZLWLti91uWqOnwbIE01Qhe5ydXae4hBoCMKEQAvD_BwE&gclsrc=aw.ds
mb = 0.032; % kg
k_ressort = 1100; % N/m
dx = 0.044; % m

% piston
Vp = pi*0.009^2*0.012; % m^3
rho_brass = 8730; % kg/m^3
mp = Vp*rho_brass; % kg

m = mb + mp;

margin = 0.001; % m

% constants
g = 9.81; % m/s

%% calcul vitesse sortie canon
vA = sqrt(k_ressort/m)*dx % m/s

%% calcul precision angulaire

ymax = (Dt-Db)/2 - margin

y = @(x, theta) x.*tan(theta) - 1/2*g*(x./(vA.*cos(theta))).^2;

theta = -10:0.1:10; 

thetaRad = deg2rad(theta);

yB = y(d, thetaRad);
yC = y(d+e, thetaRad);

validIndices = find(yB > -ymax & yB < ymax & yC > -ymax & yC < ymax);

thetaMin = theta(validIndices(1))
thetaMax = theta(validIndices(end))

% plot height at obstacles
figure();
plot(theta, yB, 'b'); hold on;
plot(theta, yC, 'g');
yline(ymax);
yline(-ymax);
xline(thetaMin, 'r')
xline(thetaMax, 'r')
hold off;
grid on;
xlabel('Initial angle [°]');
ylabel('Height [m]')
legend('yB', 'yC', 'y = ymax', 'y = ymin', 'x = thetaMin', 'x = thetaMax',...
    'Location', 'southeast');

% plot trajectories
x = 0:0.001:d+e+0.02;

trajectoryMin = y(x, deg2rad(thetaMin));
trajectoryMax = y(x, deg2rad(thetaMax));

figure();
plot(x, trajectoryMin, 'g'); hold on;
plot(x, trajectoryMax, 'b');
line([d,d],[-ymax,ymax], 'Color','red', 'LineWidth', 1);
line([d+e,d+e],[-ymax,ymax], 'Color','red', 'LineWidth', 1);
hold off;
grid on;
xlabel('x [m]')
ylabel('y [m]')
legend(['Trajectory with theta = ' num2str(thetaMin)], ['Trajectory with theta = ' num2str(thetaMax)], 'Acceptable shooting range',...
   'Location','southwest');

% final precision
delta = thetaMax; % degrees

%% calcul deformation autorisee de chaque piece

% la deformation angulaire de chaque element doit etre egale
N = 2; % -, nb elements

delta_1piece = delta/N % deg