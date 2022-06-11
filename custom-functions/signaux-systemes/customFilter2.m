function [yn] = customFilter2(a,b,xn)
% customFilter2() 
%     Compute the response of an order 2 filter based on the coefficients of the differencel equation.
%   inputs:
%       a: Coefficients vectors of y
%       b: Coefficients vector of x
%       xn: Signal to process
%   outputs:
%       yn: Response of the filter to xn

N = length(xn);
yn = zeros(1,N);

xPrev = 0;
xPrevPrev = 0;
yPrev = 0;
yPrevPrev = 0;

for i=1:N
    yn(i) = (b(1)*xn(i) + b(2)*yPrev + b(3)*yPrevPrev...
        - a(2)*xPrev - a(3)*xPrevPrev)/a(1);

    xPrev = xn(i);
    xPrevPrev = xPrev;
    yPrev = yn(i);
    yPrevPrev = yPrev;
end
end