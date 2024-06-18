%% SIM21 ode

%% exercise 21.1
% DC switch-on behavior of a real coil (R+L series connection) 
% U = R*I + L*dI/dt
clear,clc,clf
i0=0;           % initial condition i(t=0)=0

% alternative 1: symbolic
syms   R L U i(t)
isym = dsolve(U == R*i + L*diff(i), i(0)==0)     

% Parameter 
U=1;            % voltage
L=1e-3;         % inductance
R=1;            % resistance
te=5*L/R;       % simulation time: te=5*tau

% alternative 2: ode
didt=@(t,i) -R/L*i + U/L;   % DGL
[t,i]=ode45(didt,[0 te],i0);

% Plot
plot(t,i)                      
hold on, grid on
plot(t,eval(isym),'--')

% alternative 3: Simulink
% scope parameters - logging -  log data to workspace
% save format: array
s=sim('./simulink/si3a_coilDC'); 
plot(s.ScopeData(:,1),s.ScopeData(:,2),'k.')

legend('ode45','symbolic','simulink')

%% exercise 21.2
% AC switch-on behavior of a real coil (R+L series connection) 
% U*sin(w*t) = R*I + L*dI/dt 
clear,clc,clf;

U=230*sqrt(2);  % voltage amplitude
L=1;            % inductance
R=10;           % resistance
w=2*pi*50;      % angular frequency
te=0.5;         % simulation time
i0=0;           % initial condition

% Alternative 1: ode
didt=@(t,i) -R/L*i + U*sin(w*t)/L;
% reduce max. step size
opts = odeset('MaxStep',1e-3);
[t,i]=ode45(didt,[0 te],i0,opts);
plot(t,i)                        	
hold on, grid on

% alternative 2: Simulink
% Simulation parameter: Modeling-config parameter-solver-solver details
% max. step size 0.01 -> 0.001
% scope parameters - logging -  log data to workspace
% save format: Dataset (default)
s=sim('./simulink/si3b_coilAC');
plot(s.ScopeData{1}.Values.Time,s.ScopeData{1}.Values.Data,'--.');
legend('ode45','simulink')


%% exercise 21.4 parameter study free oscillator: damping constant
% ODE: m*x'' + c*x' + k*x = 0
% mass m, damping constant c, spring stiffness k
% initial conditions: x(0)=1, v(0)=x'(0)=0
clear,clc,clf

k=3;                % spring constant
m=3;                % mass
te=50;              % simulation time
x0=[1 0];           % initial conditions x(1)=x(t) und x(2)=x'(t)

c=[.5, 2, 5];      % damping constants     

for i=1:3
    dxdt=@(t,x) [0, 1; -k/m, -c(i)/m]*x ;
    [tout,xout]=ode45(dxdt,[0 te],x0);
    plot(tout,xout(:,1));hold on
end
legend(num2str(c'))
grid on

% Alternative: start Simulink 
% all damping variants will be solved in parallel

%% exercise 21.5 parameter study forced oscillator: drive frequency
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

% alternative 1: ode as anonymous function
for i=1:length(w)
    dxdt=@(t,x) [0, 1; -k/m, -c/m]*x + [0; F/m]*sin(w(i)*t);
    [tout,xout]=ode45(dxdt,[0 te],x0);
    subplot(3,1,i),plot(tout,xout(:,1),'--',tout,F*sin(w(i)*tout),'--');
    hold on
    title(['\omega =',num2str(w(i)),' \omega_0']);
end
legend('displacement','force')
xlabel('time')

%% alternative 2: ode as matlab function

i=2;subplot(3,1,i)  % Fall2: w=w0
[tout,xout]=ode45(@forcedoscillator,[0 te],x0,[],k,c,m,F,w(i));
set(gca,'ColorOrderIndex',1);    % reset color index
plot(tout,xout(:,1),tout,F*sin(w(i)*tout));


%% alternative 3: Simulink 
s=sim('./simulink/si4_forcedspringmassdamper');
for i=1:3
    subplot(3,1,i)
    set(gca,'ColorOrderIndex',1);    % reset color index
    plot(s.ScopeData{1}.Values.Time,s.ScopeData{1}.Values.Data(:,i),'.')
    plot(s.ScopeData{2}.Values.Time,s.ScopeData{2}.Values.Data(:,i),'.')
end

%% ------------------------------------------------------------
function xdot=forcedoscillator(t,x,k,c,m,F,w)
% ODE of unforced spring-mass-damper
% m*x'' + c*x' + k*x = 0
% two coupled first order ODE
% k spring constant, c damping constant, m mass
% x(1) amplitude, 
% x(2) = dx(1)/dt velocity

xdot=zeros(2,1);
xdot(1) = x(2);                                 % x1'  = x2
xdot(2)= -k/m*x(1) -c/m*x(2) + F/m*sin(w*t) ;   % x1'' = x2' = -k/m*x -c/m*x'
end




