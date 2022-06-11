function [Xjk] = ASF (xT, tT, M)
% AnalseSF 
% Analyse de Fourier d'un signal discret périodique des M+1 coefficients
% Input : 
% xT : vecteur du signal d'une période numérique
% tT : vecteur du temps
% M : Nombre de coefficients fréquentiels à calculer (caution M<N)
% Output : 
% Xjk : Vecteur comprenant les coefficients de la série de Fourier Xjk[1]
% est la composante continue


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