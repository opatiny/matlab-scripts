%% Induction en fonction du courant et de l'entrefer
clear; clc; close all;

%% Variables
Iref = 0.93; % A
x = [2 3]*1e-3; % m
mu0 = 4* pi * 1e-7;
mur = 400; % -
a = 12e-3; % m
n1 = 500; % -

%% formulas
getBcste = @(I, x) mu0*mur*n1*I./(17*a+2*mur*x);

getBinfty = @(I, x) mu0*n1*I./(2*x);

%% B(I)
I = linspace(0,1,11);

BIcste2 = getBcste(I, x(1));
BIcste3 = getBcste(I, x(2));

BIinfty2 = getBinfty(I, x(1));
BIinfty3 = getBinfty(I, x(2));

%% B(x)
x = linspace(0, 3e-3, 301) % m

Bxcste = getBcste(Iref, x)
Bxinfty = getBinfty(Iref, x)



%% plots
figure();
plot(I, BIcste2, 'b-o'); hold on;
plot(I, BIcste3, 'b-x');
plot(I, BIinfty2, 'r-o');
plot(I, BIinfty3, 'r-x');
hold off;
grid on;
xlabel('I [A]');
ylabel('B [T]');
legend('\mu_r = 400, x = 2mm', '\mu_r = 400, x = 3mm', '\mu_r = \infty, x = 2mm', '\mu_r = \infty, x = 3mm', 'Location', 'southeast');

figure();
plot(x, Bxcste, 'b-'); hold on;
plot(x, Bxinfty, 'r-');
hold off;
grid on;
ylim([0, 0.4]);
xlabel('x [m]');
ylabel('B [T]');
legend('\mu_r = 400', '\mu_r = \infty', 'Location', 'southeast');
