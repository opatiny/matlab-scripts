%% Lois de Fresnel: Determination de l'indice d'une lame parralele
clc; clear; close all;

%% load data

data = readtable('./data.csv');

alpha = deg2rad(data.alpha)
eclairementS = data.eclairementS;
eclairementP = data.eclairementP;

theta_i = alpha/2;

%% angle brewster approximatif
ni = 1; % air
thetaB = 60; % °
thetaB = deg2rad(thetaB)
% theta_B = atan(nt/ni) ->
nt = tan(thetaB)*ni

% de plus il faut un facteur pour passer de la reflexion a l'eclairement
facteur = 15; % approximation du facteur

%% calcul angle refracte
theta_t = asin(ni/nt*sin(theta_i));

Rp = (tan(theta_i-theta_t)./tan(theta_i+theta_t)).^2;

Rs = (sin(theta_i-theta_t)./sin(theta_i+theta_t)).^2;

eclairementP_th = facteur*Rp;
eclairementS_th = facteur*Rs;

%% minimisation fonction
theta_t_fun = @(nt) asin(ni/nt*sin(theta_i));
Rp_fun = @(nt)(tan(theta_i-theta_t_fun(nt))./tan(theta_i+theta_t_fun(nt))).^2;
Rs_fun = @(nt)(sin(theta_i-theta_t_fun(nt))./sin(theta_i+theta_t_fun(nt))).^2;

% params contains [factor, nt]
errorFun = @(params) rms(params(1) * Rs_fun(params(2)) - eclairementS); %  + rms(params(1) * Rs_fun(params(2)) - eclairementS)

% approximate parameters
nt = 1.7; % [-]
factor = 15; % [lux]

approximateParams = [factor, nt];

% compute best fit
theta_i
params = fminsearch(errorFun,approximateParams)

factor = params(1);
nt = params(2);
eclairementP_th = factor*Rp_fun(nt);
eclairementS_th = factor*Rs_fun(nt);

test = errorFun(params)

%% plot
theta_i = rad2deg(theta_i);
figure();
plot(theta_i, eclairementS, '.'); hold on;
plot(theta_i, eclairementP, '.');
plot(theta_i, eclairementS_th)
plot(theta_i, eclairementP_th)
hold off;
grid on;
xlabel('\theta_i [°]');
ylabel('\epsilon [lux]');
legend('Onde S', 'Onde P');