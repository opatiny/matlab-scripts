%% Event demo: jumping ball
clear,clc
figure(1),clf
tg=[];
yg=[];
teg=[];

t0=0;       % initial time
h0=10;      % initial height
v0=0;       % initial velocity
is=1e-3;    % initial time step
y0=[h0;v0]; % initial values ODE

for i=1:4
    options = odeset('Events',@events,'InitialStep',is,'MaxStep',1e-1);
    [t,y,te,ye,ie] = ode45(@f,[t0 20],y0,options);
    % te times of events
    % ye solution at event times
    % ie are indices into the vector returned by the events function.

    % velocity: switch sign and some damping 
    y0=-0.9*ye;

    % new initial conditions for ode45
    t0=te;
    is=t(end)-t(end-1);
    
    % save for plot
    tg=[tg;t];
    yg=[yg;y(:,1)];
    teg=[teg,te];
end

plot(tg,yg)
grid on

%% functions

% free falling ball: y''=-g
function dydt = f(t,y)
g=-9.81;
dydt = [y(2); g];
end

function [value,isterminal,direction] = events(t,y)
% Locate the time when height passes through zero in a decreasing direction
% and stop integration.
value = y(1);       % detect y(1) = 0
isterminal = 1;     % 1=stop the integration
direction =-1;      % 0=every direction, -1 = negative direction
end