function [y] = sinam(temps, T0, tau, Tp);
% sinam(temps, T0, tau, Tp) 
%     calcul d'une suite de sinusoides amorties
%   utilisation:
%      yt = sinam(temps+decal, T0, tau, Tp);
%   auteur:
%   date:
%

tm = mod(temps,T0); % rampe comprise entre 0 et T0
y = exp(-tm/tau).*sin(2*pi*tm/Tp);