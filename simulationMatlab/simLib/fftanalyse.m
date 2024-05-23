function [A0,fn,An] = fftanalyse( data,ts)
% Fourier analysis (fft) of one period t= 0 to T-dt 
% input
% data 
% ts:   sampling time 
% output
% A0:  mean signal 
% fn:  frequencies of harmonics
% An:  amplitudes of harmonics
% Author: Robert Sattler

n = length(data);           % number of sampling points
y=fft(data)/n;              % FFT
A0 = y(1);                  % mean

% due to the symmetry of the complex spectrum 
% you can consider the positive frequencies only, but with factor 2
f1 = 1/n/ts;                % min. frequency
n2 = floor(n/2);            % n/2 (floor cause of A0)
fn = f1*(1:n2);             % frequencies of harmonics
An = 2*abs(y(2:n2+1));
% if n is even then the highest harmonic is listed only once in y, so you
% have to undo the factor of two.
An(end)=An(end)-An(end)/2*(~mod(n,2));
end