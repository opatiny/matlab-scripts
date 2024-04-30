%% Assignment 6 - Magnetic fields - Problem 1
clear; clc; clf;
% Helmotz coil

%% Variables
mu0=4e-7*pi; % vacuum permeability [H/m]
I=1; % current [A]
R=0.1; % radius [m]
d=2*R; % distance of current loops

%% a) Magnetic field function
syms z;
Hz = @(z) I.*R.^2./(2.*(R.^2 + z.^2).^(2/3));

zLin = linspace(-0.2,0.2,100); % m
H1 = Hz(zLin-d/2);
H2 = Hz(zLin+d/2);
Htot = H1 + H2;

%% plot
figure(1);
hold on;
plot(zLin,H1);
plot(zLin, H2);
plot(zLin, Htot);
hold off;
grid on;
xlabel('z [m]');
ylabel('H(z) [T]');

%% b) Helmotz and Maxwell arrangements
syms d I R z;
% this is how you define a symbolic function
Hz = I*R^2/(2*(R^2 + z^2)^(2/3));
H1 = subs(Hz, z, z-d/2);
H2 = subs(Hz, z, z+d/2);

H_helm = H1 + H2;
H2p = diff(H_helm,z,2);

eqH = subs(H2p,z,0) == 0;
helmotzDistance = vpasolve(eqH, d, 0)

H_maxw = @(z,d) Hz(z-d/2, I) + Hz(z+d/2, -I);
H3p = diff(H_maxw,z,3);

z = 0; % m
eqM = subs(H2p) == 0;
maxwellDistance = solve(eqM, d)

%%
syms x y
z=x+y
subs(z,x,x+1)
z


syms z(x)
z=x+y;
z(3)
