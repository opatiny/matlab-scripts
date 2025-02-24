function stats = ParamSignal(xn)
% ParamSignal() 
%     Computes energy, power and rms of the given signal.
%   input:
%       xt : signal
%   output:
%       Xdc : Valeur moyenne du signal
%       Xac : Valeur efficace du signal
%       Px : Puissance normalisée du signal

% Only works if a whole number of periods is passed
Xdc = sum(xn)/length(xn);
Px = sum(xn.^2)/length(xn);
Pac = Px - Xdc.^2;
Xac = sqrt(Pac);

stats.Px = Px;
stats.Xdc = Xdc;
stats.Xac = Xac;
end