function [x] = sie(temps, T0, tau);
% sie(temps, T0, tau) 
%     calcul d'une suite périodique d'impulsions exponentielles
%     d'amplitude 1 et de constante de temps tau
%     La SIE demarre lorsque temps = 0
% Parametres:
%     temps = variable temporelle
%     T0  = periode
%     tau = constante de temps 
% Exemple d'utilisation:
%      xt = sie(temps+decal, T0, tau);
%   auteur: fmy   
%   date: 4.7.03
%   modif.:


tm = mod(temps,T0); % rampe comprise entre 0 et T0
x = exp(-tm/tau);



