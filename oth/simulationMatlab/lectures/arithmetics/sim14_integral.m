%% SIM14 Integral

%% -------------------------------------------------------------------------
%% I symbolic
%% -------------------------------------------------------------------------
clear,clc

% indefinite integral
syms x t
int(x/(1 + t^2), t)

% definite integral
syms x a
sol = int(x*log(1 + x), x, 0, a)

% replace parameter a with value 1
a=1;eval(sol)


% integral of polynomials 
polyval(polyint([1 0 0]),2) - polyval(polyint([1 0 0]),0)
% or
int(x^2,0,2)

%% -------------------------------------------------------------------------
%% II numeric integration of functions
%% -------------------------------------------------------------------------
% since matlab2012: quad -> integral
clear,clf,clc

% anonymous functions
f1 = @(x)1./(x.^3 - 2*x-5);
defInt = integral(f1,0,2)

% built in functions
integral(@sin,0,pi)


% functions with parameters must be passed unparameterized
f1=@(x,a,b,c) a*x.^2 + b*x + c
a=1;b=2;c=3;
f1=@(x) f1(x,a,b,c);
integral(f1,0,1)
% or compact
integral(@(x) f1(x,a,b,c),0,1)

% vector valued functions need ('ArrayValued',true)
w=linspace(1,5,9);
fun = @(x)sin(w*x);
q = integral(fun,0,1,'ArrayValued',true)


%% exercise 14.1 elliptic integrals  
% are not only needed to calculate the circumference of an ellipse, but
% also for the calculation of the magnetic field of a conductor loop.
% The function is defined by an integral, which you find with
doc ellipke   % More about

clear,clc
% a) Calculate the elliptic integral of the first (and second) kind using 
% integral() command for  
m=0.3;
f1 = @(t)((1-t.^2).*(1-m*t.^2)).^(-1/2);
ellipseArea1 = integral(f1,0,1)

% verify your result with ellipke
[K,E]=ellipke(m);

fprintf('Result correct? %i\n', abs(K - ellipseArea1) < 1e-5);

% b) Write your own function myellipke(m) for the elliptic integral of 
% the fist kind, which can handle vector valued arguments
m = .1:.1:.9;
f = @(t,m)((1-t.^2).*(1-m*t.^2)).^(-1/2);
myEllipke = @(m) integral(@(t) f(t,m), 0, 1, 'ArrayValued',true);

myEllipke(m)
...
% verify your result with ellipke
K=ellipke(m)



%% -------------------------------------------------------------------------
%% III numeric integration of data 
%% -------------------------------------------------------------------------
% The integral can be calculated approximately if the area under  
% the curve is approximated by trapezoids or rectangles
% http://de.wikipedia.org/wiki/Trapezregel
% the narrower the area the better the approximation
clear,clc

n=90;                   % number of sampling points
x = linspace(0,2,n);
f1 = @(x) 3.^(3*x-1);
y = f1(x);

trapz(x,y)              % approximation by trapezoids
sum(y)*(x(2)-x(1))      % approximation by rectangles
% for reference
integral(f1,x(1),x(end)) % numerische Integration of analytical function

%% Convergence of the integral calculation
clf,clc
nv = 10:1000;           % number of sampling points
for i=1:length(nv)
    n=nv(i);
    x = linspace(0,2,n);
    f1 = @(x) 3.^(3*x-1);
    y = f1(x);
    t(i) = trapz(x,y);              % approximation by trapezoids
    s(i) = sum(y)*(x(2)-x(1));      % approximation by rectangles
end
semilogx(nv,[t;s])
xlabel('number of sampling points')
title('\int_0^2 3^{3x-1} dx')
legend('trapz','sum')

%% cumulative integral (Stammfunktion)
% e.g. area enclosed by sin(x)
clear,clc,clf

dx=0.25;    % number of sampling points 
x = 0:dx:2*pi;
f1 = @(x) sin(x);

% a) most simple solution: cumsum, cumtrapz
plot(x,cumtrapz(x,f1(x))), hold on
plot(x,cumsum(f1(x))*dx,'--')   


% b) integrate() does not allow vector valued limits
% you need a loop or arrayfun()
% loop 
for i=1:length(x)
    F(i)=integral(f1,0,x(i));
end
% arrayfun (Apply function to each element of array)
F = arrayfun(@(x) integral(f1,0,x),x);
plot(x,F,'k.')

% c) verify with analytic solution: F(x)-F(x(0)) and F(x)=-cos(x)
syms x
F = int(sin(x),x)
Fc = F-subs(F,x,0)
h=fplot(Fc,[0,2*pi]);
set(h,'LineStyle','--');
legend('cumtrapz','cumsum','arrayfun','analytical')


%% exercise 14.2: numeric integration
% Current I(t)=1µA*sin(w*t)^3 flows through capacitance C=1µF. 
% plot a diagram of voltage [mV] and current [µA] through the capacitor 
% over one period. U(t=0)=0.
% current-voltage relation of C: I=C*dU/dt 

clear,clf,clc
I_amp=1e-6; % current amplitude
C=4e-6; % capacitance
f=50;   % frequency
U0 = 0; % V
n = 1000;

Ifun = @(t) I_amp .* sin(2*pi*f.*t).^3;

t = linspace(0,1/f,n);
I = Ifun(t);

U = cumtrapz(t,I)/C + U0;
yyaxis left;
plot(t,I); hold on;
yyaxis right;
plot(t,U);
hold off;
grid on;





%% Integration 2d/3d 
% since matlab2012: quad2d -> integral2
clear,clc,clf

% example: area under 2d function
syms x y real
f1=x*sin(x)*cos(y);
fsurf(f1,[0,pi,-pi/2,pi/2])

% symbolic
int(int(f1,x,0,pi),y,-pi/2,pi/2)

% numeric
fn=matlabFunction(f1)
integral2(fn,0,pi,-pi/2,pi/2)

%% How to consider non-Cartesian integration limits
clear,clc,clf

% example: area under 2d function bounded by elliptic curve
syms x y real
f1=sin(x+pi/2)*cos(y);
fsurf(f1,[-pi,pi,-pi,pi],'ShowContours','on')
hold on

% define integration boundary: ellipse
% x^2/a + y^2/b = 1
a=2;
b=1.5;
p=linspace(0,2*pi);
plot3(a*cos(p),b*sin(p),-p.^0)

% option 1) use functional relation between limits in x and y
f1=matlabFunction(f1)            % symbolic to anonymous
ymx=@(x) b*sqrt(1-x.^2/a^2);    % integration limit y depends on x
% factor 4 due to symmetry
4*integral2(f1,0,a,0,ymx)       % integration limits x[0,a] and y[0,ymax]

% option 2) limit function f1 with logical operators
% modify original function to define bounds
f2=@(x,y) f1(x,y).*((x.^2/a^2+y.^2/b^2)<=1);
integral2(f2,-a,a,-b,b)        % integration limits x[0,R] and y[0,R]

%% exercise 14.3
% -> sim14a_integral.mlx














