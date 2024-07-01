%% Sample exam - Simulation in matlab
clc; clear; clf;

%% Problem 1 -> ok
data1 = load("data1.txt");
data2 = load("data2.txt");

data = sortrows([data1;data2]);

% polynomial fit

x = data(:,1);
y = data(:,2);

p = polyfit(x,y,5);
fit = polyval(p,x);

% find most distant points
[dist, indices] = sort(abs(fit-y), 'descend');

maxIndices = indices(1:3);

% plot
plot(data1(:,1), data1(:,2), 'ko');
hold on;
plot(data2(:,1), data2(:,2), 'kx');
plot(x,fit, 'k');
plot(x(maxIndices), y(maxIndices), 'ro')
hold off;
grid on;
legend('data1', 'data2', 'fit degree 5', 'Location', 'southeast');

%% Problem 2 -> is it correct?

R = 0.1; % m
d = 2e-3; % m
mu0 = 4*pi*1e-7; % N/A^2

rmin = 0;
rmax = (R-d)/2;

% B = mu0*H

func = @(r) Hloop(R,r,0);

flux = integral(func, rmin, rmax) % wb

%% Problem 3 -> ok

V = 1e-3; % m^3

A = @(r) 2*pi*r.^2 + 2*V./r;

fplot(A)

[rmin, ~] = fminsearch(A,0.05)

hmin = V/(pi*rmin^2)

%% Problem 4 -> ??
l = 5;

x1 = 1;
y1 = 0;
x2 = 2;
y2 = 1;

syms a x0 y0;

eq1 = y1 == a * cosh((x1 - x0)/a) + y0;
eq2 = y2 == a * cosh((x2 - x0)/a) + y0;
eq3 = l == 2*a*sinh((x2-x1)/(2*a));

p0 = [0 0.3 -1.2]; % initial parameters guess

[A, X0, Y0] = vpasolve(eq1,eq2,eq3, a, x0, y0, p0) 

f = @(x) A * cosh((x - X0)/A) + Y0
fplot(f,[-1,2]); 


%% Problem 5 -> ok
[x,y] = meshgrid(-4:0.1:4);

r = sqrt(x.^2 + y.^2);

Hx = - y.^3./r.^5;
Hy = x.^3./r.^5;

% draw vector field
streamslice(x,y,Hx,Hy)
axis equal, axis tight

%% Problem 6 -> ??
syms i U L1 L2 M;

i = i1 + i2;
U = L1*di1dt + M*di2dt
U = L2*di2dt + M*di1dt

U = Le*didt

%% Problem 7

%% a)
N = 1000;
gamma = 0.04;
beta = 0.4;

% coupled system of ODE
% dI/dt =  beta*S*I/N - gamma*I
% dS/dt = -beta*S*I/N
% dR/dt = gamma*I
% initial conditions
% I(0)=3
% S(0)=N
% R(0)=0

% all unknowns must be defined as a single vector
% p(1) = I
% p(2) = S
% p(3) = R
ode=@(t,p) [ beta*p(2)*p(1)/N - gamma * p(1)
             -beta * p(2)*p(1)/N
             gamma*p(1)];

te = [0,100]; % simulation time
pi = [3,1000,0]; % initial conditions

[t,p] = ode45(ode,te,pi);
plot(t,p)
legend('I','S', 'R')
grid on;
xlabel('Day');
ylabel('Nb of people');

%% b)
N = 1000;
gamma = 0.04;
lockDownStart = 15;

odeBeta=@(t,p,beta) [ beta*p(2)*p(1)/N - gamma * p(1)
             -beta * p(2)*p(1)/N
             gamma*p(1)];

te1 = [0,lockDownStart];
pi1 = [3,1000,0]; % initial conditions

ode1 = @(t,p) odeBeta(t,p,0.4);

[t1,p1] = ode45(ode1,te1,pi1);

% simulate lockdown after day 15

te2 = [lockDownStart,100];
pi2 = p1(end,:);

ode2 = @(t,p) odeBeta(t,p,0.04);

[t2,p2] = ode45(ode2,te2,pi2);

t = [t1; t2];
p = [p1; p2];

clf;
plot(t,p)
legend('I','S', 'R')
grid on;
xlabel('Day');
ylabel('Nb of people');
% I know this is not correct because infection rate sinks immediately


%% Problem 8

% capacitor: I = C*dQ/dt
% resistor: U = R*I
% inductor: U = L*di/dt
% all components in series

% it is right that the initial conditions are important

% differential equations are easy to solve in simulink, but chatgpt doesn't
% propose this solutions

% ode45 is the right function to use to solve differential equations
% systems

% it's annoying that it doesn't use the right type of ticks, you can't just
% copy and paste the answer

% the code runs and provides a realistic answer, it's pretty good tbh

% but why does it define y (should only be the current) as an array of 3
% variables?? -> okay got it, its for each of the dx/dt -> dQ/dt, 0, di/dt

% test the code
R = 1;
L = 1;
C = 1;
y0 = [0; 0; 1];
tspan = [0,10];

[t, y] = ode45(@(t, y) diffeq(t, y, R, L, C), tspan, y0);

plot(t, y(:, 1))
xlabel('time');
ylabel('current');


function dy = diffeq(t, y, R, L, C)
I = y(1);
% Q = y(2); % this line is useless
dy= [1/L*(y(3)-R*I); 1/C*I; 0];
end