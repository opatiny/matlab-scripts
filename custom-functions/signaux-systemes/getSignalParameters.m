function stats = getSignalParameters(xn)
% getSignalParameters() 
%     Computes energy, power and rms of the given discrete signal.
%   input:
%       xt : signal
%   output:
%       average : Valeur moyenne du signal
%       energy: energy of the signal
%       power : power of the signal
%       rms : rms value of the signal

% Only works if a whole number of periods is passed
average = sum(xn)/length(xn);
energy = sum(xn.^2);
power = energy/length(xn);
Pac = power - average.^2;
rms = sqrt(Pac);

stats.average = average;
stats.energy = energy;
stats.power = power;
stats.rms = rms;
end