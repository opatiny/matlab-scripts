%% SIM21 ordinary differential equations (ode)
% 
%% 1. order
% dx/dt = -a*x
% x(0) = 1      % initial condition
clear,clc,clf

% symbolic: dsolve
syms x(t) a
lsg_oA = dsolve(diff(x) == -a*x)         % without initial condition
lsg_mA = dsolve(diff(x) == -a*x,x(0)==1) % with initial condition

% numeric: ode  
a=5;
dxdt = @(t,x) -a*x;     % define ODE in this way: dx/dt = f(t,x)
te = [0 2];             % simulation time 0 < t < 2
x0=1;                   % initial condition x(t=0)=1
[t,xout]=ode45(dxdt,te,x0);

% compare graphically: 
plot(t,xout,'bo',t,eval(lsg_mA),'r')
legend('numeric','symbolic')


% alternative: return structure
sol = ode45(dxdt,te,x0);
% evaluate with deval()
t0=0.5;
deval(sol,t0)

%% exercise 21.1
% DC switch-on behavior of a real coil (R+L series connection) 
% ODE: U = R*i + L*di/dt
clear,clc,clf
i0=0;           % initial condition i(t=0)=0

% alternative 1: symbolic
syms U R i_t(t) L
iSym = dsolve(U == R*i_t + L*diff(i_t), i_t(0) == 0)

% Parameter 
U=1;            % voltage
L=1e-3;         % inductance
R=1;            % resistance
te= [0 5*L/R];       % simulation time: te=5*tau

% alternative 2: numeric
didt = @(t, i)(U-R*i)/L;

[t,iNum] = ode45(didt, te, i0);

% compare graphically: 
plot(t,iNum,'bo',t,eval(iSym),'r')
legend('numeric','symbolic')


% alternative 3: Simulink
% scope parameters - logging -  log data to workspace
% save format: array
sim('./simulink/si3b_coilDC');hold on;
plot(ScopeData(:,1),ScopeData(:,2),'k.')
hold off;
legend('ode45','symbolic','simulink')

%% SIMULINK: GUI for (complex) systems of ODE (continous and discrete time)

% start
simulink    % oder toolstrip: HOME-Simulink

% example: 
% 
% a) plot time signal on scope
% matlab workspace can be used in simulink
te=5;       % simulation time

% b) plot sin(w*t) on scope
f=1;        % frequency [Hz]

% c) plot A*sin(w*t+phi) on scope
A=2;        % amplitude
phi=pi/4;   % phase

% d) integrate sinus signal 



%% exercise 21.2
% AC switch-on behavior of a real coil (R+L series connection) 
% ODE: U*sin(w*t) = R*I + L*dI/dt 
clear,clc,clf;

% Parameter
U=230*sqrt(2);  % voltage amplitude
L=1;            % inductance
R=10;           % resistance
w=2*pi*50;      % angular frequency
te=0.5;         % simulation time
i0=0;           % initial condition

% alternative 1: ode

didt = @(t,i) (U*sin(w*t) - R*i)/L

[t,iout]=ode45(didt,[0,te],i0);

plot(t,iout);
grid on;

% alternative 2: Simulink

% Simulation parameter: max. step size 0.01->0.001
% scope parameters - logging -  log data to workspace
% save format: Dataset
sim('./simulink/si3b_coilAC');hold on
plot(ScopeData{1}.Values.Time,ScopeData{1}.Values.Data,'--');
hold off;
legend('ode45','simulink')

%% stiff ODE
% Stiffness is an efficiency issue. If we weren't concerned with how much time 
% a computation takes, we wouldn't be concerned about stiffness.  
% Nonstiff methods can solve stiff problems; they just take a long time to do it.
% http://de.mathworks.com/company/newsletters/articles/stiff-differential-equations.html

delta = 1e-5;   % 1e-5
df = @(t,y) y^2 - y^3;
ode45(df,[0 2/delta],delta);
% zoom
ylim([.99,1.01])

% alternative solver for stiff ODE
ode23s(df,[0 2/delta],delta);
% zoom
ylim([.99,1.01])



%% ----------------------------------------------------------------------- 
%% systems of ODE


% coupled system of ODE
% dx/dt = -4x-2y+2
% dy/dt =  2x+ y-1
% initial conditions
% x(0)=-1
% y(0)=0

clear,clc
% all unknowns must be defined as a single vector
% p(1) = x
% p(2) = y
ode=@(t,p) [ -4*p(1)-2*p(2)+2; 
              2*p(1)+  p(2)-1];
[t,p] = ode45(ode,[0 2],[-1,0]);
plot(t,p)
legend('x(t)','y(t)')


%% second order differential equations  
% example: spring-mass-damper system
% m*x'' + c*x' + k*x = 0
% mass m, damping constant c, spring stiffness k
% initial conditions: x(0)=1, v(0)=x'(0)=0
clear,clc,clf

% Parameter
k=3;                % spring stiffness
m=3;                % mass
c=.25*sqrt(4*k*m);  % damping constant 
te=50;              % simulation time
x0=[1 0];           % initial conditions for x(1)=x(t) and x(2)=x'(t)

% Matlab can only solve differential equations of 1st order, but 
% any differential equation of nth order can be described in terms of 
% a system of n differential equations of 1st order  
% How to generate a 1st order system from a 2nd order ODE?

% Alternative 1: define ODE as a function
[t,xode]=ode45(@unforcedoscillator,[0 te],x0,[],k,c,m);
plot(t,xode)
hold on, grid on
legend('displacement x','velocity dxdt','AutoUpdate','off')

%% alternative 2: define ODE as an anonymous function

% single line (matrix-vector product) version of function unforcedoscillator
dxdt=@(t,x) [0, 1; -k/m, -c/m]*x ;
[tout,xout]=ode45(dxdt,[0 te],x0);
plot(tout,xout,'w--') 

% Hint: matlabFunction(odeToVectorField())
% matlab can reduce a higher order symbolic ODE to a system of first order ODEs
syms m0 c0 k0 x(t)
eqn = m0*diff(x,t,2)+c0*diff(x,t)+k0*x;
V = matlabFunction(odeToVectorField(eqn));

[tout,xout]=ode45(@(t,Y) V(Y,c,k,m),[0 te],x0);
ax = gca;ax.ColorOrderIndex = 1;    % reset color index
plot(tout,xout,'.') 


%% alternative 3: Simulink

% The model 'si4_springmass.slx' solves the ODE
% m*x'' + k*x = 0
% mass m, spring stiffness k

%% exercise 21.3
% damping constant c and the initial conditions x(0)=1, v(0)=x'(0)=0
% must be supplemented in the model si4_springmass.slx
sim('./simulink/si4_springmassdamper.slx');
% scope - save data to workspace - structure (with time)
set(gca,'ColorOrderIndex',1);    % reset color index
plot(ScopeData{1}.Values.Time,ScopeData{1}.Values.Data,'o')
plot(ScopeData{2}.Values.Time,ScopeData{2}.Values.Data,'o')

%% exercise 21.4 unforced oscillator: parameter study with damping constant
% ODE: m*x'' + c*x' + k*x = 0
% mass m, damping constant c, spring stiffness k
% initial conditions: x(0)=1, v(0)=x'(0)=0
clear,clc,clf

% parameter
c=[.5, 2, 5];      % damping constants     
k=3;                % spring constant
m=3;                % mass
te=50;              % simulation time
x0=[1 0];           % initial conditions x(1)=x(t) and x(2)=x'(t)

%% exercise 21.5 forced oscillator: parameter study with drive frequency
% Calculate the deflection for 3 drive frequencies
% ODE: m*x'' + c*x' + k*x = F*sin(w*t)
% initial conditions: x(0)=0, x'(0)=0
clear,clc,clf

% parameters
w=[0.5 1 2];        % drive frequencies
k=3;                % spring constant
m=3;                % mass
c=1;                % damping constant 
F=1;                % force amplitude
te=50;              % simulation time
x0=[0 0];           % initial conditions x(1)=x(t) and x(2)=x'(t)


%% -------------------------------------------------------------------
function xdot=unforcedoscillator(t,x,k,c,m)
% ODE of unforced spring-mass-damper
% m*x'' + c*x' + k*x = 0
% two coupled first order ODE
% k spring constant, c damping constant, m mass
% x(1) amplitude, 
% x(2) = dx(1)/dt velocity

xdot=zeros(2,1);
xdot(1) = x(2);                   % x1'  = x2
xdot(2)= -k/m*x(1) -c/m*x(2);     % x1'' = x2' = -k/m*x -c/m*x'
end
