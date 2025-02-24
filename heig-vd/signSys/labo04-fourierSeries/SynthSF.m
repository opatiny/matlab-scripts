function [xr] = SynthSF (Xjk, F0 , tt)
% SynthSF 
%   Reconstruction selon fourier
% inputs : 
%   Xjk : vecteur contenant les  coeff de la serie de  Fourier  pour k = 0..M
%   f0 : frequence fondamentale
%   tt : vecteur du temps  sur  lequel  la  synthese de  doit  se faire

% outputs : 
%   xr : Signal reconstruit

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