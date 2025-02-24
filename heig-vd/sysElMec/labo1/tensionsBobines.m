%% Tensions aux bornes des bobines
clear; clc; close all;

%% Variables
x = [0 2]*1e-3; % m
mu0 = 4* pi * 1e-7;
mur = 400; % -
a = 12e-3; % m
n1 = 500; % -
n2 = 100; % -

tmax = 0.2; % s
Imax = 0.5; % A
f = 10; % Hz
omega = 2*pi*f;

t = linspace(0, tmax, 51);

i = Imax * cos(omega*t)

di = Imax * omega * sin(omega*t)

%% formulas
getLambdaCste = @(x) 5*mu0*mur*a^2./(17*a+2*mur*x);

getL11 = @(x) n1^2*getLambdaCste(x);

getU1 = @(x) getL11(x) * di;
getU2 = @(x) n2/n1*getU1(x);

%% u1 et u2
u1x0 = getU1(x(1));
u1x2 = getU1(x(2));
u2x0 = getU2(x(1));
u2x2 = getU2(x(2));

%% plot
figure();
plot(t, i, 'b'); hold on;
plot(t, u1x0, 'r-x');
plot(t, u1x2, 'r-');
plot(t, u2x0, 'g-x');
plot(t, u2x2, 'g-');
hold off;
grid on;
xlabel('t [s]');
ylabel('i_1 [A] / u [V]');
legend('i_1', 'u1(x = 0mm)', 'u1(x = 2mm)', 'u2(x = 0mm)', 'u2(x = 2mm)');

