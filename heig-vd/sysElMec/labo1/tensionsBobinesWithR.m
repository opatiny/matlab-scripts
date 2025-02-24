%% Tensions aux bornes des bobines dans négliser la résistance des fils
clear; clc; close all;

%% Variables
x = [2]*1e-3; % m
mu0 = 4* pi * 1e-7;
mur = 400; % -
a = 12e-3; % m
n1 = 500; % -
n2 = 100; % -

R1_40 = 7.41; % ohm

tmax = 0.2; % s
Imax = 0.5; % A
f = 10; % Hz
omega = 2*pi*f;

t = linspace(0, tmax, 51);

i1 = Imax * cos(omega*t);

di = Imax * omega * sin(omega*t);

%% formulas
getLambdaCste = @(x) 5*mu0*mur*a^2./(17*a+2*mur*x);

getL11 = @(x) n1^2*getLambdaCste(x);

getU1 = @(x) R1_40 * i1 + getL11(x) * di;
getU2 = @(x) n2/n1*getU1(x);

%% u1 et u2
u1x2 = getU1(x(1));
u2x2 = getU2(x(1));

%% plot
figure();
plot(t, i1, 'b'); hold on;
plot(t, u1x2, 'r-');
plot(t, u2x2, 'g-');
hold off;
grid on;
xlabel('t [s]');
ylabel('i_1 [A] / u [V]');
legend('i_1', 'u1', 'u2');

