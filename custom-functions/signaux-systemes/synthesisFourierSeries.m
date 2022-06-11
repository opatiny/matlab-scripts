function [xr] = synthesisFourierSeries(Xjk, F0 , tt)
% synthesisFourierSeries 
%   Reconstruct a signal using the Fourier coefficients Xjk.
% inputs : 
%   Xjk : Vector with the Fourier coefficients k = 0..M
%   f0 : Fundamental frequency
%   tt : Time vector on which to base the synthesis
% outputs : 
%   xr : Reconstructed signal

xr=zeros(1, length(tt));

for i=0:(length(Xjk)-1)/2
    % we only use the positive complex coefficients
    XjkIndex = (length(Xjk)+1)/2 + i;
    if(i==0)
        A = abs(Xjk(XjkIndex));
    else
        A = 2*abs(Xjk(XjkIndex));
    end
    % on prend le conjugue de l'angle
    phi = angle(Xjk(XjkIndex));
    xr = xr + A*cos(2*pi*F0*i*tt+phi);
end

end