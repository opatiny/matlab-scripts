%% Computation of the power of a kite
close all; clear; clc;

%% variables

A = 1000; % m^2, kite area
vmax = 75; % km/h, max wind speed
vbat = 35; % km/h, cruising boat speed
rho = 1.228; % kg/m^3, air density at sea level
m = 440; % kg, kite mass
AR = 4.5; % - , aspect ratio
AOA = 20; % deg, angle of attack

g = 9.81; % m/s^2

v = vbat:1:vmax

% convert to right units

AOA = deg2rad(AOA);

vrel_kmh = v-vbat;

vrel = vrel_kmh/3.6

%% compute lift and drag coefficients
Cl0 = @(AOA) 2*pi.*AOA;
Cl = @(AOA) Cl0(AOA)./(1 + Cl0(AOA)/(pi*AR));

Cd0 = @(AOA) 1.28.*sin(AOA);
Cd = @(AOA) Cd0(AOA) + Cl(AOA).^2/(0.7*pi*AR);

%% compute forces

% lift
getL = @(vrel, AOA) Cl(AOA)*A*rho.*vrel.^2/2; % N
L = getL(vrel, AOA);
disp(['Maximum lift: ' num2str(L(end), 2) ' N'])

% poids de la voile
Ft = m*g;

% drag
getD = @(vrel, AOA) Cd(AOA)*A*rho.*vrel.^2/2; % N
D = getD(vrel, AOA);
disp(['Maximum drag: ' num2str(D(end), 2) ' N'])

% plot
figure();
plot(vrel_kmh, L); hold on;
plot(vrel_kmh, D);
yline(Ft);
hold off;
xlabel('Relative wind speed [km/h]');
ylabel('Force [N]');
legend('lift', 'drag', 'kite weight', 'Location', 'northwest');
grid on;

%% max kite power

getP = @(vrel, AOA) 1/2*rho*Cl(AOA)*(Cl(AOA)/Cd(AOA))^2.*vrel.^3; % W

P = getP(vrel_kmh, AOA);

disp(['Maximum power: ' num2str(P(end)/1e6, 2) ' MW'])

%% influence of angle of attack
v = vmax;

AOAdeg = 0:1:45; % deg, test various angles
AOA = deg2rad(AOAdeg);


