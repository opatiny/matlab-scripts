function result = df(f,x,dx) 
% compute the derivative of a function f at the given points x
% f should be a matlab function, eg: f = @(x) x.*sin(1./x);
% choice of dx is very important otherwise results will be bad for steep
% functions (take 1e-6 for example)
% careful: if dx is too small, the error will be bigger
result = (f(x+dx)-f(x-dx))/2/dx;
end
