%% sim13 derivative

%% -------------------------------------------------------------------------
%% I symbolic differentiation
%% -------------------------------------------------------------------------
clear,clc

% derivative
syms x;
f = x^4+2*x^2-3*x+4;
diff(f)

% 2. derivative
diff(f,x,2)

syms t;
diff(t^3,t,2)

%% derivative of polynoms
p = sym2poly(f)     % get polynomial coefficients
dpdx = polyder(p)
poly2sym(dpdx)

%% -------------------------------------------------------------------------
%% II numeric differentiation of discrete data
%% -------------------------------------------------------------------------
% derivative is defined by limit of difference quotient (DQ)
% https://de.wikipedia.org/wiki/Differenzenquotient

n = 12;         % number of grid points
x = linspace(0, pi/2, n);
y = sin(x);
y1 = cos(x);    % analytic solution for comparison
plot(x, y1, 'b-'), hold on

DQ = diff(y)./diff(x);      % DQ
plot(x(1:n-1), DQ, 'kx:')   % forward DQ  (f(x+dx)-f(x))/dx
plot(x(2:n), DQ, 'k+:')     % backward DQ (f(x)-f(x-dx))/dx
dydx = gradient(y, x);      % central DQ  (f(x+dx)-f(x-dx)/(2*dx)

plot(x, dydx, 'ko')
xlabel('x')
ylabel('cos(x)')
legend('analytic', 'forward', 'backward', 'central')

% For the first and last data point the central DQ cannot be calculated 
% and gradient() returns the forward DQ and backward DQ respectively

% increase number of grid points

%% -------------------------------------------------------------------------
%% III numeric differentiation of continous functions
%% -------------------------------------------------------------------------
clear,clc,clf
% derivative is defined by limit of difference quotient (DQ)
% f'(x) = ( f(x+dx)-f(x-dx) )/ 2dx
% http://de.wikipedia.org/wiki/Differenzenquotient#Zentraler_Differenzenquotient
%
% there is no built in function, but you can define yourself
% difference quotient
df=@(f,x,dx) (f(x+dx)-f(x-dx))/2/dx;

% b) compare with analytic solution
clf
x = linspace(-pi, pi);
f=@(x) sin(x.^3); % f(x)
dx=1e-3;          % distance of grid points

dfdx = df(f,x,dx);% numeric differentiation
plot(x,dfdx,'k.'), hold on
% plot analytic solution
fplot(diff(sym(f)),[-pi,pi])

%% exercise 13.1
% a) calculate the derivative of the function f(x) = x*sin(1/x)
% in three ways or under three different conditions
% b) compare the solution graphically in the interval 0.01<x<0.03
clear,clc,clf

% a1) symbolic 

% dfdx_sym=



% a2) continous: x,f() is given
x=linspace(.01,.03);
% f=@(x) 

% dfdx_con=



% a3) discrete: x,y is given (e.g. from experiment)
x=linspace(.01,.03);
y=f(x); clear f

% dfdx_dis=

% compare graphically
fplot(dfdx_sym,[min(x),max(x)]),hold on
plot(x,dfdx_con,'or')
plot(x,dfdx_dis,'k.')
legend('symbolic','continous','discrete')

%% exercise 13.2
% How accurate is our derivative function df(f,x,dx)?
% Calculate the error of the derivative of the function f(x) at the point x0 
% (in comparison to the analytical solution) as a function of the grid spacing dx
% Plot the magnitude of the error (= df(f,x0,dx)-f'(x0) )  
% as a function of the grid distance dx
% dx = 10^-1, 10^-2, ... ,10^-11 
% Due to the range of the data, a double logarithmic representation is recommended
% Interpret the result
clear,clc,clf

% function
f0=@(x) sin(x);
% analytic derivative f'(x) for comparison
f1=@(x) cos(x);
% grid location of derivative
x0=0.5;
% difference quotient
df=@(f,x,dx) (f(x+dx)-f(x-dx))/2./dx;


