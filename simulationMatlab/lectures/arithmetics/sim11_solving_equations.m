%% sim11 solving equations
%% -------------------------------------------------------------------------

%% -------------------------------------------------------------------------
%% I single equation
%% -------------------------------------------------------------------------

%% polynomial equation: roots
clear 
% p(x) = 4x^5+3x^3-7x^2+11
% q(x) = -x^4+ x^3- x
x=linspace(-1,1,50);
% compact representation of polynomials: coefficients vector
p=[4 0 3 -7 0 11];
q=[-1 1 0 -1 0];
% evaluate coefficient vector
plot(x,polyval(p,x),'r',x,polyval(q,x),'b'), grid on

% find zeros (roots) of polynomial equation (check with data cursor)
np=roots(p)
nq=roots(q)

% inverse function of roots: 
% find the polynomial with given zeros
poly(np)

%% exercise 11.1: quadratic equation
% Find the solution of this equation
% a*x^2 + b*x + c = 0
% with the parameters
a=1; b=2; c=3;

x=linspace(-5,5,50);

p = [1 2 3];
plot(x, polyval(p,x))
np = roots(p)

%% symbolic solution: solve (symbolic toolbox)
syms a b c d x 

pretty(solve(a*x^2+b*x+c==0,x))   % quadratic equation 

% (==0 can be omitted)
s=solve(a*x^3+b*x^2+c*x+d,x)      % cubic equation: 'MaxDegree', 3

% % Rewrite symbolic expression in terms of common subexpressions 
subexpr(s)      % subexpression in variable sigma    

% if a symbolic solution is not available, 
% the equation will be solved numerically (vpasolve)
solve(cos(x)==x)

%% Non-polynomial equations require iterative solution procedures 
% -> fzero() requires starting value

% built in function
x=fzero(@sin,3)     % find sin(x)=0 with start value x=3
x=fzero(@sin,1)     % start value x=1
x=fzero(@cos,[1 2]) % search in intervall

% anonymous function
f=@(x) x^3-2*x-1;
iv=[-1.5,2];        % Intervall
fzero(f,iv)
% string argument will be accepted
fzero('x^3-2*x-1',iv)
% Even if there are several zeros, 
%  fzero always finds only one!
fplot(f,iv), grid on

% comparison: only roots() finds complex ...
roots([1 0 -2 -1])
% ... and double zeros
f=@(x) x.^3-x.^2
fplot(f,[-1,2]), grid on
fzero(f,-1)
roots([1 -1 0 0])

%----------------------------------------------------


% a function with several parameters,
f=@(x,p1,p2) exp(p1*x)-p2*x;
iv=[1,2];        % Intervall
% must be redefined to a function with a single parameter
p1=1;p2=3;
f1=@(x) f(x,p1,p2);  
fzero(f1,iv)
% alternative
fzero(@(x) f(x,p1,p2),iv)
% alternative: fsolve -> see below

% How does fzero work?
% Animation of the basic idea
% https://de.wikipedia.org/wiki/Bisektion#Kontinuierlicher_Fall
clc
options = optimset('Display','iter'); % show iterations
fzero(@(x) cos(x)-x,0,options)

%% exercise 11.2 
% plot f1(x)=cos(x) and f2(x)=x
% Calculate the intersection point and mark it graphically
f1 = @(x) cos(x);
f2 = @(x) x;

f = @(x) f1(x) - f2(x);

solution = fzero(f, 0);

x = linspace(-5,5,100);
plot(x, f1(x)); hold on;
plot(x, f2(x));
plot(solution, f1(solution), 'g.', 'MarkerSize', 10);
hold off;
grid on;

%% -------------------------------------------------------------------------
%% II systems of equations
%% -------------------------------------------------------------------------

%% linear systems of equations: backslash\
% X=A/B resolves the equation X*A=B to X
% X=A\B resolves the equation A*X=B to X
% example
% 10x1 - 7x2       = 7
% -3x1 + 2x2 + 6x3 = 4
%  5x1 -  x2 + 5x3 = 6

M=[10 -7 0;
   -3  2 6; 
    5 -1 5];
y=[7;4;6];
x=M\y
% x=y'/M'   % alternative
M*x         % check that the result is the right side of the equation
%% 

M^-1 * y   % inverse Matrix as alternative to M\

%% symbolic: solve
% equivalent to the above example for a=0

syms x1 x2 x3 a
eq1 = 10*x1 - 7*x2 + a*x3 == 7;
eq2 = -3*x1 + 2*x2 + 6*x3 == 4;
eq3 = 5*x1 -   x2 + 5*x3 == 6;
[X1, X2, X3] = solve(eq1,eq2,eq3,x1,x2,x3) 
% for comparisons: evaluate a=0
subs([X1,X2,X3],a,0)

% transform a system of equations to matrix form
[A,b]=equationsToMatrix([eq1,eq2,eq3],[x1,x2,x3])

%% exercise 11.3
% The coordinates of three points are given. 
% Find the parabola through these points by solving the three equations 
clear, clc, clf

x=[-1;4;7];
y=[ 2;6;5];
plot(x,y,'o');hold on; grid on

% Hint
% equation: y = a1*x^2 + a2*x^1 + a3 
% Find the unknown vector a=(a1,a2,a3) from the 
% matrix of coordinates X=[x.^2, x.^1, x.^0] and the vector y
X =[x.^2, x.^1, x.^0];

% we need to solve X * a = y for a
a = X\y

x = linspace(-5,10,100);
y = a(1)*x.^2 + a(2)*x + a(3);

plot(x,y);
hold off;

%% nonlinear systems of equations: fsolve
% n equations for n unknowns must be given
% n unknowns must be defined as a single vector 

% example from above
% avoid spaces!
f=@(x)[10*x(1) - 7*x(2)-7;          % =0     
       -3*x(1) + 2*x(2)+6*x(3)-4;   % =0
        5*x(1) -   x(2)+5*x(3)-6];  % =0  

x0=[0,0,0]; % starting value
x=fsolve(f,x0)

% alternative: define function as m-file or local function (line 215)
x=fsolve(@fsolveFkt,x0)
% application see problem "terminal velocity"
% Hint: local functions can not be used with F9 (use ctrl-return)

%% vpasolve
% is the most flexible numeric equation solver
% like solve() 
% a) allows symbolic definition of equation
% b) for single and systems of equations
% like fzero() und fsolve() 
% allows to supply the starting value

% example: system of equations from above 
clear,clc
syms x1 x2 x3 
eq1 = 10*x1 - 7*x2 + sin(x3) == 7;
eq2 = -3*x1 + 2*x2 + 6*x3 == 4;
eq3 = 5*x1 -   x2 + 5*x3 == 6;
x0=[0,0,0];     % starting values x1=x2=x3=0
[X1, X2, X3] = vpasolve(eq1,eq2,eq3,x1,x2,x3,x0) 


% example with verification plot 
clear,clc,clf
syms x
f=x^3-2*x-1
x=vpasolve(f)   % alternative: solve 
fplot(f,[-1.5,2]); 
grid on, hold on
plot(eval(x),eval(f),'o')

% alternative: convert to nonysmbolic matlab
figure(2)
F=matlabFunction(f);    % symbolic function -> anonymous function
lsg=eval(x)             % symbolic value -> numeric value
xx=linspace(-1.5,2);
plot(xx,F(xx))
grid on, hold on
plot(lsg,F(lsg),'o')


%% exercise 11.4
% Find all solutions of these two equations
% x1^2 - x2 + 1=0
% x1 - cos(pi/2*x2) = 0
clear, clc, clf

syms x1 x2
eq1 = x1^2 - x2 + 1 == 0;
eq2 = x1 - cos(pi/2*x2) == 0;

[sol11, sol12] = vpasolve(eq1, eq2, x1, x2, [0 0])
[sol21, sol22] = vpasolve(eq1, eq2, x1, x2, [-1 1.5])
[sol31, sol32] = vpasolve(eq1, eq2, x1, x2, [-1 2])

% graph
% fimplicit only works with 2d, fimplicit3 also exists for 3D
fimplicit(eq1); hold on;
fimplicit(eq2);
hold off;
grid on;
axis([-2 2 0.5 2.5]);

%% -------------------------------------------------------------------
%% local function for fsolve
function f=fsolveFkt(x)
% avoid spaces since could be interpreted as column separation
f=[10*x(1)-7*x(2)-7;      
   -3*x(1)+2*x(2)+6*x(3)-4;
    5*x(1)-x(2)+5*x(3)-6];  
end