%% HES d'été Matlab - Exo 5 - Exemple de traitement de données
% Date : 2021.08.30

clc; clear; close all;
%% Données
% Elongation d'un ressort: valeurs mesurees
longueur = [4.2 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0 13.0 14.0];  % [cm]
force = [0.0 1.1 2.0 3.2 3.9 4.6 5.8 7.0 8.1 9.0 9.5];   % [N]

%% Régression linéaire
fit1 = polyfit(longueur, force, 1);
fit3 = polyfit(longueur, force, 3);

x = linspace(4 ,14, 15);
y1 = polyval(fit1, x);
y3 = polyval(fit3, x);

%% Ecart-type
model1 = polyval(fit1, longueur);
model3 = polyval(fit3, longueur);

diff1 = model1-force;
diff3 = model3-force;

[~,N] = size(longueur); % permet de récupérer que une propriété
% or use length!!
% N = length(longueur);
sd1 = sqrt(sum(diff1.^2)/N);
sd3 = sqrt(sum(diff3.^2)/N);

trueSd1 = std(diff1,1); % the 1 precises that we divide by N and not N-1
trueSd3 = std(diff3,1);

% this is a custom function!!
mySd1 = stdev(longueur, force, fit1);
mySd3 = stdev(longueur, force, fit3);

% stdev(longueur, force(3:end), fit1) % testing the error message

% debug
[sd1, trueSd1, mySd1];
[sd3, trueSd3, mySd3];

%% Affichages
figure('Name','ex5-plot'); % name figure
err = 0.5*ones(size(force));
h = errorbar(longueur, force, err, 'o','MarkerSize',3,'MarkerFaceColor', 'b');
% that's how to change marker size and to fill it
hold on;
plot(x, y1, 'g', x, y3, 'r');
hold off;
title('Longueur du ressort en fonction de la force appliquée');
xlabel('Longueur [cm]');
ylabel('Force [N]');
legend('Mesures', ['Régression premier ordre, 1\sigma = ',...
        num2str(round(sd1,3))], strcat('Régression troisième ordre, 1\sigma = ',...
        num2str(round(sd3,4)))); % 2 ways to concatenate
        % round is super shitty if the last digit is a 0
legend('Location','southeast');
