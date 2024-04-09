function [t, y] = fsynthesis(a0,fn,an,bn,N)
% that calculates and plots the fourier approximation from the
% given coefficients.
% a0: offset (DC value)
% fn: vector of harmonic frequencies
% an: vector of cos-amplitudes
% bn: vector of sin-amplitudes
t = 0:1/fn/N:1/fn;
wn = 2*pi*fn;
y = a0;
for i=1:length(an)
    i
    y = y + an(i) * cos(i*wn*t) + bn(i) * sin(i*wn*t);
end
end