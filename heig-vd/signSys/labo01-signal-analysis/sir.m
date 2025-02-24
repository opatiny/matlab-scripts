function [x] = sir(temps, T0, rc)
% sir(temps, T0, rc) 
%     calcul d'une suite d'impulsions rectangulaires SIR 
%     d'amplitude 1 et de rapport cyclique rc
%     La SIR demarre lorsque temps = 0
%  Parametres:
%     temps = variable temporelle
%     rc = rapport cyclique = 0.5 par defaut
%   exemple d'utilisation:
%      xt = sir((temps+decalage),T0, rc);
%   auteur: fmy   
%   date: 4.7.03
%   modif.:

% valeurs par defaut
if nargin == 2,  rc = 0.5; end

tm = mod(temps,T0); % rampe comprise entre 0 et T0
x = tm/T0 < rc;     % x = 1 ou 0
