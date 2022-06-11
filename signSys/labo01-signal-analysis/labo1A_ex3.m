%% Labo 1A - Ex3: Periodic signals (energy and power)
clc; clear; close all;

%% Get periodic functions
[sin,sit,sie,sir,sinam,tt] = signaux_a();

%% Theoretical power
% sinus
thStatsSin.Px = 0.5; % always the case for a sinus
thStatsSin.Xdc = 0;
thStatsSin.Xac = sqrt(thStatsSin.Px);

% rectangular signal: Xdc = A*rc et P_th = A^2*rc
A = 2;
rc = 1/5;

thStatsSir.Px = A^2*rc;
thStatsSir.Xdc = A*rc;
thStatsSir.Xac = sqrt(thStatsSir.Px - thStatsSir.Xdc^2);

% triangular signal
A = 4;
T0 = 5;
rc = 1;
thStatsSit.Px = 2/3*A^2*rc;
thStatsSit.Xdc = A*(rc-0.5);
thStatsSit.Xac = sqrt(thStatsSit.Px - thStatsSit.Xdc^2);

% exponetielle décroissante: P_th=A^2/2*tau/T_0
A = 2;
T0 = 5;
tau = 1;

thStatsSie.Px = A^2/2*tau/T0;

%% Practical power
practStatsSin = ParamSignal(sin);
practStatsSit = ParamSignal(sit);
practStatsSie = ParamSignal(sie);
practStatsSir = ParamSignal(sir);
practStatsSinam = ParamSignal(sinam);

%% Print results
thStatsSin
practStatsSin

thStatsSir
practStatsSir

% factor 2 between th and pract power!
thStatsSit
practStatsSit

thStatsSie
practStatsSie 
%% Plot the functions
figure();
subplot(5,1,1);
plot(tt, sin);
xlabel('time [s]');
ylabel('x_1(t)');

subplot(5,1,2);
plot(tt, sit);
xlabel('time [s]');
ylabel('x_2(t)');

subplot(5,1,3);
plot(tt, sie);
xlabel('time [s]');
ylabel('x_3(t)');

subplot(5,1,4);
plot(tt, sir);
xlabel('time [s]');
ylabel('x_4(t)');

subplot(5,1,5);
plot(tt, sinam);
xlabel('time [s]');
ylabel('x_5(t)');
