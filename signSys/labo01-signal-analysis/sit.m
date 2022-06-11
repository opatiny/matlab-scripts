function [x] = sit(temps, T0, rc)
% sir(t, T0, rc) 
%     calcul d'une suite d'impulsions triangulaires SIT 
%     d'amplitude 1, de période T0 et de rapport cyclique rc
%     La SIT demarre lorsque temps = 0
% Parametres:
%     temps = variable 
%     T0 = période 
%     rc = rapport cyclique = 0.5 par defaut
% Exemple d'utilisation:
%      xt = sit(temps, T0, rc);
%   auteur: fmy   
%   date:   4.7.03
%   modif.: 29.01.05

% verification des parametres d'entree
if nargin == 2, rc = 0.5; end % valeur par defaut
if (rc > 1)||(rc < 0)
   error('Le rapport cyclique doit etre compris entre 0 et 1');
end

% creation du signal x = 0
x = zeros(size(temps));
tm = mod(temps,T0);      % rampe comprise entre 0 et T0
% creation des triangles
k1 = find(tm/T0 < rc/2);
x(k1) = tm(k1)/T0;       % rampe positive 0 ... rc/2
k2 = find((tm/T0 >= rc/2)&(tm/T0 < rc));
x(k2) = rc - tm(k2)/T0;  % rampe negative rc/2 ... 0
% normalisation
x = x/max(x);
