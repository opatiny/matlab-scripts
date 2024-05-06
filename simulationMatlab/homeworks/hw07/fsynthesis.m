function [t, y] = fsynthesis(a0,fn,an,bn,N)
% Calculate the fourier approximation from the given coefficients.
%   a0: offset (DC value)
%   fn: vector of harmonic frequencies
%   an: vector of cos-amplitudes
%   bn: vector of sin-amplitudes
%   N: number of points

T = 1/fn(1);
t = linspace(0,T,N);
y = a0;
for i=1:length(an)
    wn = 2*pi*fn(i);
    y = y + an(i) * cos(i*wn*t) + bn(i) * sin(i*wn*t);
end
end