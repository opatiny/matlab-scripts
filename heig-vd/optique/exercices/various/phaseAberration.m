%% An illustration of phase aberration
clc; clear; close all;

%% Variables
no = 1;
ni = 1.5;
R = 100; % mm
K = 10; % constante conique
V = (ni-no)/R;
f = 1/V
D = 20; % diametre lentille en mm
lambda = 0.55e-3; % mm

po = -400; % mm -> position de l'objet (on est en mode 4F)
ho = 10; % mm -> hauteur de l'objet
thetao = atan(ho/po); % rad
pi = 1/(V+1/po);
hi = ho*pi/po;
thetai = atan(hi/pi);

% definition de la pupille
[x,y] = meshgrid(-200:200, -200:200);
x = x/200*D/2;
y = y/200*D/2;
pupille = sqrt(x.^2+y.^2) < 10;

% aberration d'astigmatie
A1 = no*thetao^2/4*(0.5/R*(1/ni-1/no) + 1/(no*po)-1/(ni*pi))
A1p = no*thetao^2/4/R*(1/ni-1/no)

W1 = (A1*y.^2 + A1p*x.^2).*pupille; % aberration du front d'onde

% aberration de coma
A2 = no^2*thetao*(1/po-1/R)*(1/(ni*pi)-1/(no*po))
W2 = A2*(y.^3 + x.^2.*y).*pupille;

% aberration spherique
sphericAberration = @(K) -K/(8*R^3)*(ni-no) - no^2/8*(1/po-1/R)^2*(1/(ni*pi)-1/(no*po))

Kmin = fminsearch(sphericAberration, 50)
% la valeur pour laquelle l'aberrration spherique est minimale tend vers 
% moins l'infini??

A3 = sphericAberration(Kmin)

W3 = A3*(x.^2+y.^2).^2;

W = W1 + W2 + W3;
phase = 2*pi/lambda*W;
phaseur = pupille.*exp(-1i*phase);
largePhaseur = zeros(800, 800);
largePhaseur(1:401, 1:401) = phaseur;

psf = fftshift(abs(fft2(phaseur)).^2);

% plot data
figure();
surf(x,y,W1); axis square;
title('Aberration astigmatisme');
colormap(jet);
axis square;

figure();
surf(x,y,W2); axis square;

title('Aberration coma');
colormap(jet);
axis square;

figure();
surf(x,y,W3); axis square;
title('Aberration spherique');
colormap(jet);
axis square;

figure();
imagesc(psf);
title('Aberration totale');
axis square;

