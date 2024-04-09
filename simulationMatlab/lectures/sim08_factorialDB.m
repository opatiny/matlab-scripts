function y = sim08_factorialDB(n)
% example for recursive function call

% n! = n* (n-1)!
if n == 1
    y = 1;
else
    y = n * sim08_factorialDB(n-1);
end
end
