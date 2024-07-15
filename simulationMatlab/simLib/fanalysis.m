function [a0,fn,an,bn] = fanalysis(t,y,m)
% Compute Fourier coefficients for harmonics from 1 to m.
%   t: time vector (1 period)
%   y: y vector (1 period)
%   m: desired nb of harmonics
% returns
%   a0: offset
%   fn: harmonics frequencies
%   an: cosine coefficients
%   bn: sine coefficients

T = t(end)-t(1);
f0 = 1/T; % fundamental frequency

a0 = 1/T*trapz(t,y);

fn = zeros(1,m);
an = zeros(1,m);
bn = zeros(1,m);

for i=1:m
    fi = i*f0;
    fn(i) = fi;

    an(i) = 2/T*trapz(t, y.*cos(2*pi*fi*t));
    bn(i) = 2/T*trapz(t, y.*sin(2*pi*fi*t));
end
end

