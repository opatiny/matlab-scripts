%% Calculs de rentabilite
clf; clear; close all;

n = 8; % an
It = [9e4 0 0 0 0 0 0 0 0]; % chf
Ct = [0 2e4 2e4 2e4 2e4 1e4 2e4 2e4 2e4]; % chf
i = 0.05; % [-]

t = 0:n;

%% Valeur actuelle nette (VAN)

updates = (Ct-It).*(1+i).^(-t); % chf

VAN = cumsum(updates)

% the VAN must be positive for the project to be profitable

%% Annuites

% facteur de recouvrement
Fr = i./(1-(1+i)^(-n)) % -

A = VAN * Fr % chf