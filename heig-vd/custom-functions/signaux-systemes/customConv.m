%% 
function [yn] = customConv(hn,xn)
% customConv() 
%   Compute the convolution product of hn and xn
%   inputs:
%       hn : first discrete signal
%       xn : second discrete signal
%   outputs:
%       yn : Convolution of hn and xn

    
% need a loop on n -> the entry signal x[n]
yn = zeros(1, length(hn)+length(xn)-1);
    for k=1:length(xn)
        padStart = k-1;
        padEnd = length(yn)-length(hn)-k+1;
        padStartArray = zeros(1,padStart);
        padEndArray = zeros(1, padEnd);
    
        pn = [padStartArray, xn(k)*hn(:)', padEndArray];
        yn = pn + yn;
    end
end