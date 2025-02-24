%% Thermistance et conditionneurs
clear; clc; close all;

%% data
T = linspace(-20, 100, 7);

R = [684 815 961 1122 1299 1490 1696];

%% Point 1: lin and second order models
p1 = polyfit(T, R, 1);
R_sim1 = polyval(p1, T);

p2 = polyfit(T, R, 2);
R_sim2 = polyval(p2, T);

% figure();
% plot(T, R, 'o'); hold on;
% plot(T, R_sim1, '-')
%plot(T, R_sim2, '-')
% hold off;
% grid on;
% xlabel('Temperature [°C]');
% ylabel('Resistance [\Omega]');
% legend('Data', 'y = 8.43 x + 815', 'y = 0.0188 x^2 + 6.93 x + 815', 'Location', 'southeast');


%% Point 2: non-linearity 
% pour le conditionneur avec source de courant
NL1 = getNL(R, R_sim1); % non-linearity in percents: 3.7


%% Point 3: sensibility
I = 1e-3; % A

S_therm = polyder(p1); % sensibility: 8.43 Ohm/°C

S_tot = S_therm*I; % global sensibility: 8.4 mV/°C


%% Point 4
I_max_th = 1.5e-3; % A
U0 = 3; % V
% valeur idéale R0 à 40°C: R0 = R
R0 = 1122; % Ohm

% check I_max
I_max = U0/(R0 + min(R)) % 1.7mA -> pas ok, risque d'echauffement

R0 = U0/I_max_th-min(R) % 1316 Ohm

NL2 = getLinErr(T, R, R0, U0) % 5.72%


%% Point 5: optimisation linearite
% trouver la valeur optimale de R0 -> syntaxe juste mais la fonction
% getLinErr est fausse
R0_opt = fminsearch(@(R0) getLinErr(T, R, R0, U0), R0)
% good answer: 2617 Ohm
% deux non-linearites qui se compensent quand on a la bonne valeur de R0
% NL du capteur compense la NL du conditionneur

%% Fonctions
% tension sortie conditionneur pont resistif
function U = getU(R, R0, U0)
    U = R./(R+R0).*U0;
end

% non-linearity in percents
function NL = getNL(data, model)
    NL = max(abs(data-model))/(data(end)-data(1))*100;
end

function err = getLinErr(T, R, R0, U0)
    % c'était pas ça qu'il fallait faire, mais comparer la fonction au
    % modele d'ordre 1 passant le mieux par Um
    p1 = polyfit(T, R, 1);
    R_sim1 = polyval(p1, T);

    Um = getU(R, R0, U0);
    Um_th = getU(R_sim1, R0, U0);

    err = getNL(Um, Um_th);
end