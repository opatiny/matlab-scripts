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
syms d;
Hz = @(z, I) I.*R.^2./(2.*(R.^2 + z.^2).^(2/3));

H_helm = @(z,d) Hz(z-d/2, I) + Hz(z+d/2, I);
H2p = diff(H_helm,z,2)

z = 0; % m
eq = subs(H2p) == 0
helmotzDistance = vpasolve(eq,d, 0)

