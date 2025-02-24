%% sim15 Optimize  

%% function of one parameter

clear,clc
f=@(x) x.^3+4*x.^2-8*x;
x=-6:.1:3;
plot(x,f(x)), grid on, hold on
% Minimum
min1=fminbnd(f, -6, 3)
plot(min1,f(min1),'o')
% Maximum von f = Minimum von -f
mf=@(x) -f(x);
xmx=fminbnd(mf, -6, 3)
plot(xmx,f(xmx),'ro')

% alternatives for polynoms
roots(polyder([1 4 -8 0]))

%% function of one or more parameters
% https://en.wikipedia.org/wiki/Rosenbrock_function
% Bananafunction f(x,y)= 100*(y-x^2)^2+(a-x)^2

clear,clc,clf
a=sqrt(2);
% plot
x=-3:.02:3;
y=x;
[X,Y]=meshgrid(x,y);    % oder meshgrid(x), da x=y
Z=100*(Y-X.^2).^2+(a-X).^2;
mesh(X,Y,Z)

% fminsearch needs a single argument f(x)
% several parameters e.g. x,y must be  replaced by e.g. x(1), x(2)  
hold on
banana = @(x)100*(x(2)-x(1).^2).^2+(a-x(1)).^2;
x01 = [0,0];     % initial value
min1=fminsearch(banana,x01)
plot3(min1(1),min1(2),banana(min1),'ro')
% zlim([0, 1])

%% find best value in data (discrete values)
% example from above

% alternative 1
mn=min(min(Z));             % value of minimum
[row col]=find(Z==mn);      % find location of minimum
[x(col) y(row)]         
% or
[X(row,col) Y(row,col)]

% alternative 2: 
[mn,idx]=min(Z,[],'all');   % value and index of minimum
[X(idx) Y(idx)]          


%% exercise 15.1
% calculate and mark the minimum of this function
clear, clf, clc
ezmesh('X*Y*exp(-X^2-Y^2)'); hold on;
% zlim([-.2 .2])  % solution might be invisible

f = @(x) x(1)*x(2)*exp(-x(1)^2-x(2)^2);
min1=fminsearch(f,[1,-1])
plot3(min1(1),min1(2),f(min1),'ro')
min2=fminsearch(f,[-1,1])
plot3(min2(1),min2(2),f(min2),'ro')
hold off;
zlim([-.2 .2])  % solution might be invisible without this (graphics bug)

%% find local minima (discrete)
clear,clc
x = 1:100;
A = (1-cos(2*pi*0.01*x)).*sin(2*pi*0.15*x);
mx = islocalmax(A);
mn = islocalmin(A);
plot(x,A,x(mx),A(mx),'r*',x(mn),A(mn),'ro')

%% find minima with constraints with fmincon ------------------------

%% I) within a rectangular boundary

clear, clf, clc
% plot function
ezmesh('X*Y*exp(-X^2-Y^2)'),hold on 

% plot rectangular boundary
rx=0.5; % half width in x
ry=1;   % half width in y
x=-rx:.1:rx;
y=-ry:.1:ry;
X=[x, rx*ones(size(y)), fliplr(x), -rx*ones(size(y))];
Y=[-ry*ones(size(x)), y, ry*ones(size(x)),fliplr(y)];
plot3(X,Y,X.*Y.*exp(-X.^2-Y.^2),'k')

% define function
% for fmincon all unknown parameters must be defined in a single vector
f=@(x) x(1).*x(2).*exp(-x(1).^2 - x(2).^2);


% fmincon -------------------------------
% f = @(x) with x: [n x 1]-Vector of unknown parameters
a0=[0;0.1];         % initial value  [n x 1]
% NB 1: m inequality constraints A*x<=b
A = [];             % [m x n] Matrix          
b = [];             % [m x 1] Vektor 
% NB 2: m equality constraints Aeq*x=beq
Aeq = [];           % [m x n] Matrix     
beq = [];           % [m x 1] Vektor 
% NB 3: bound constraints  
lb=[-rx,-ry];       % lower bound [n x 1]
ub=[ rx, ry];       % upper bound [n x 1]
% NB 4: function handle to nonlinear constraints
nlc=[];             % [inequality, equality]
mn=fmincon(f,a0,A,b,Aeq,beq,lb,ub,nlc)
%-----------------------------------------

% check solution graphically
plot3(mn(1),mn(2),f(mn),'r*'); % Überprüfen

%% II) linear (in)equality constraints 

clear, clf, clc
% plot function
ezmesh('X*Y*exp(-X^2-Y^2)'),hold on 
f=@(x) x(1).*x(2).*exp(-x(1).^2 - x(2).^2);

% plot linear constraint: plane b1*x+b2*y=b0
b1=1;
b2=-2;
b0=1;
g=@(x,y) b1*x+b2*y-b0;
fimplicit3(g,'k','FaceAlpha',.3')

% equality constraint: minimum must be on plane
% inequality constraint: minimum must be left or right of plane

% fmincon -------------------------------
% f = @(x) with x: [n x 1]-Vector of unknown parameters
a0=[0;0.1];         % initial value  [n x 1]
% NB 1: m inequality constraints A*x<=b
A = [];             % [m x n] Matrix          
b = [];             % [m x 1] Vektor 
% NB 2: m equality constraints Aeq*x=beq
Aeq = [b1,b2];      % [m x n] Matrix     
beq = b0;           % [m x 1] Vektor 
% NB 3: bound constraints  
lb=[];              % lower bound [n x 1]
ub=[];              % upper bound [n x 1]
% NB 4: function handle to nonlinear constraints
nlc=[];             % [inequality, equality]
mn=fmincon(f,a0,A,b,Aeq,beq,lb,ub,nlc)
%-----------------------------------------

% check solution graphically
plot3(mn(1),mn(2),f(mn),'ro')

%% III) nonlinear constraints 

clear, clf, clc
% plot function
ezmesh('X*Y*exp(-X^2-Y^2)'),hold on 
f=@(x) x(1).*x(2).*exp(-x(1).^2 - x(2).^2);

% plot nonlinear constraint: circle with radius r
r=1.5;
g=@(x,y) x.^2+y.^2-r^2;
fimplicit3(g,'k','FaceAlpha',.3')


% fmincon -------------------------------
% f = @(x) with x: [n x 1]-Vector of unknown parameters
a0=[0;-0.1];         % initial value  [n x 1]
% NB 1: m inequality constraints A*x<=b
A = [];             % [m x n] Matrix          
b = [];             % [m x 1] Vektor 
% NB 2: m equality constraints Aeq*x=beq
Aeq = [];           % [m x n] Matrix     
beq = [];           % [m x 1] Vektor 
% NB 3: bound constraints  
lb=[];              % lower bound [n x 1]
ub=[];              % upper bound [n x 1]
% NB 4: function handle to nonlinear constraints
nlc=@(x) deal([],x(1).^2+x(2).^2-r^2);  % [inequality, equality]
mn=fmincon(f,a0,A,b,Aeq,beq,lb,ub,nlc)
%-----------------------------------------

% check solution graphically
plot3(mn(1),mn(2),f(mn),'ro','LineWidth',3)


%% alternative to fmincon for last example
% if a constraint is a (non)linear equation it might be easier 
% to integrate the constraint equation into the function to be minimized  
% each constraint equation reduces the number of unknown parameters

clear
% plot function
ezmesh('X*Y*exp(-X^2-Y^2)'),hold on 

% plot nonlinear constraint: circle with radius r
r=1.5;
g=@(x,y) x.^2+y.^2-r^2;
fimplicit3(g,'k','FaceAlpha',.3')

% constraint equation: circle with radius r
y=@(x) sqrt(r^2-x.^2); % Kreisgleichung (ggf. Vorzeichen wechseln)
% f(x,y) -> f(x)
f=@(x) x.*y(x).*exp(-x.^2 - y(x).^2);
x01=0;     % initial value
[min1, fxmn]=fminsearch(f,x01)

% check solution graphically
plot3(min1,y(min1),fxmn,'ms','LineWidth',3); % Überprüfen



%% exercise 15.2 
% https://preview.redd.it/x7v16bfnanm51.png?width=712&format=png&auto=webp&s=72679dfce47c511d163df1a458f7e18eda1fccdc
% The border of a stadium consists of a rectangle and two semicircles. 
% Determine the dimension of the rectangular soccer field within the 
% stadium, so that the soccer field area is maximum and the perimeter 
% of the stadium is equal to 400m. 
syms a r;
P = 400; % m
% P = 2*pi*r + 2*a
% A = 2*a*r

a = @(r) P/2-pi*r;
A = @(r) 2*a(r)*r;

% don't forget to inverse the function!!!
% -> we want the max but fminsearch gives the min
f = @(r) 1/A(r);

x0 = 10;
[min, f_min] = fminsearch(f, x0);

a_opt = a(min)
r_opt = min
