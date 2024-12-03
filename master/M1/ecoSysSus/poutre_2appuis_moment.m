%% Poutre sur deux appuis soumise à un moment pur
clf; clear; clc; close all;

%% Variables

L = 0.166; % m, longueur bati
w = 0.2; % m, largeur bati
h = 0.001; % m, epaisseur bati
a = 0.1; % m

% modules d'Young
E_al = 69e9; % Pa
E_ac = 200e9; % Pa

E = E_al;

I = w*h^3/12;

%% calcul moment M

Lm = 0.065; % m
Fmax = 48.4; % N

M = Lm*Fmax % Nm

%% formules deformee
% x < a
getY1 = @(x) -M/(6*E*I*L)*(6*a.*x*L - 3*a^2.*x - 2*L^2.*x - x.^3);

y1_a = getY1(a)

% x >= a
getY2 = @(x) -M/(6*E*I*L)*(3*a^2*L + 3.*x.^2*L - 3*a^2.*x - 2*L^2.*x - x.^3);

%% calculs deformee

x1 = 0:0.001:a;
y1 = getY1(x1);

x2 = a:0.001:L;
y2 = getY2(x2);


x = [x1 x2];
y = [y1 y2];

%% plot
figure();
plot(x,y);
xlabel('x [m]')
ylabel('y [m]')
xline(a);
grid on;


%% calculs de l'angle en a

% estimation

i = find(x>=a,1)

dx = x(i) - x(i-1); 
dy = y(i) - y(i-1);

ypa_est = dy/dx

% valeur exacte

ypa = -M/(6*E*I*L)*(6*a*L - 2*L^2 - 6*a^2)

