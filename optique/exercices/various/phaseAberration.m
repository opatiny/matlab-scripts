%% An illustration of phase aberration
clc; clear; close all;

%% Variables
no = 1;
ni = 1.5;
R = 100; % mm
K = 0; % constante conique
V = (ni-no)/R;
f = 1/V
D = 20; % diametre lentille en mm
lambda = 0.55e-3; % mm

po = -400; % mm -> position de l'objet
ho = 10; % mm -> hauteur de l'objet
thetao = atan(ho/po); % rad
pi = 1/(V+1/po);
hi = ho*pi/po;
thetai = atan(hi/pi);

% calcul coefficients aberrations astigmatie

A1 = no*thetao^2/4*(0.5/R*(1/ni-1/no) + 1/(no*po)-1/(ni*pi))
A1p = no*thetao^2/4/R*(1/ni-1/no)

[x,y] = meshgrid(-200:200, -200:200);
x = x/200*D/2;
y = y/200*D/2;
pupille = sqrt(x.^2+y.^2) < 10;

W = (A1*y.^2 + A1p*x^2).*pupille; % aberration du front d'onde
phase = 2*pi/lambda*W;
phaseur = pupille.*exp(-1i*phase);
largePhaseur = zeros(800, 800);
largePhaseur(1:401, 1:401) = phaseur;

psf = fftshift(abs(fft2(phaseur)).^2);

% plot data
figure();
surf(x,y,W); axis square;
colormap(jet);
