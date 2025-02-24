%% Calcul inductances propres et mutuelles
clear; clc; close all;

%% Variables
Iref = 0.93; % A
x = [2 3]*1e-3; % m
mu0 = 4* pi * 1e-7;
mur = 400; % -
a = 12e-3; % m
n1 = 500; % -
n2 = 100; % -

%% formulas
getLambdaCste = @(x) 5*mu0*mur*a^2./(17*a+2*mur*x);
getLambdaInfty = @(x) 5*mu0*a^2./(2*x);

%% L(x)
x = linspace(0, 3e-3, 61); % m

L11cste = n1^2*getLambdaCste(x);
L11infty = n1^2*getLambdaInfty(x);
L21cste = n1*n2*getLambdaCste(x);
L21infty = n1*n2*getLambdaInfty(x);

%% plot
figure();
plot(x, L11cste, 'b-o'); hold on;
plot(x, L11infty, 'b-x');
plot(x, L21cste, 'r-o');
plot(x, L21infty, 'r-x');
hold off;
grid on;
ylim([0,2]);
xlabel('x [m]');
ylabel('Inductance [H]');
legend('L11, \mu_r = 400', 'L11, \mu_r = \infty', 'L21, \mu_r = 400', 'L21, \mu_r = \infty', 'Location', 'northeast');


%% psi(i1)
x = 2e-3; % m
i1 = linspace(0,1,11);

L11cste = n1^2*getLambdaCste(x);
L11infty = n1^2*getLambdaInfty(x);
psi11cste = L11cste * i1;
psi11infty = L11infty * i1;

L21cste = n1*n2*getLambdaCste(x);
L21infty = n1*n2*getLambdaInfty(x);

psi21cste = L21cste * i1;
psi21infty = L21infty * i1;

%% plot
figure();
plot(i1, psi11cste, 'b-o'); hold on;
plot(i1, psi11infty, 'b-x');
plot(i1, psi21cste, 'r-o');
plot(i1, psi21infty, 'r-x');
hold off;
grid on;
xlabel('I [A]');
ylabel('\psi [wb]');
legend('\mu_r = 400, \psi_{11}', '\mu_r = \infty, \psi_{11}', '\mu_r = 400, \psi_{21}', '\mu_r = \infty, \psi_{21}', 'Location', 'northwest');

