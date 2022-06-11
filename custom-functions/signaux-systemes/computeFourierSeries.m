function [Xjk] = computeFourierSeries(xT, tT, M)
% computeFourierSeries 
%   Compute the M+1 coefficients of the Fourier series of xT
% inputs : 
%   xT : Esactly one period of a signal
%   tT : Time vector
%   M : Number of coefficients to compute (caution M<N)
% outputs : 
%   Xjk : Vector with the Fourier coefficients, Xjk[1]
%        is the continuous component

N = length(tT);

Te = tT(2)-tT(1);

T = N*Te;
F0 = 1/T;
n = 0:(N-1);
k = -M:M;

Xjk = zeros(1, 2*M+1);

  for i=1:length(Xjk)
    % complex  exponential vector
    wk = exp(2*pi*1i*F0*k(i)*n*Te);

    % dot product
    Xjk(i) = dot(wk,xT)/N;
  end

end