%% Computation of the power of a kite
close all; clear; clc;

%% variables

A = 1000; % m^2, kite area
vmax = 75; % km/h, max wind speed
vbat = 35; % km/h, cruising boat speed
rho = 1.228; % kg/m^3, air density at sea level
m = 440; % kg, kite mass
AR = 4.5; % - , aspect ratio
AOA_deg = 20; % deg, angle of attack

g = 9.81; % m/s^2

v = vbat:1:vmax;

% convert to right units

AOA = deg2rad(AOA_deg);

vrel_kmh = v-vbat;

vrel = vrel_kmh/3.6;

%% compute lift and drag coefficients
Cl0 = @(AOA) 2*pi.*AOA;
Cl = @(AOA) Cl0(AOA)./(1 + Cl0(AOA)/(pi*AR));

Cd0 = @(AOA) 1.28.*sin(AOA);
Cd = @(AOA) Cd0(AOA) + Cl(AOA).^2/(0.7*pi*AR);

%% compute forces

% lift
getL = @(vrel, AOA) Cl(AOA).*A*rho.*vrel.^2/2; % N
L = getL(vrel, AOA);
disp(['Maximum lift: ' num2str(L(end), 2) ' N'])

% poids de la voile
Ft = m*g;

% drag
getD = @(vrel, AOA) Cd(AOA).*A*rho.*vrel.^2/2; % N
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

AOA 
getPlloyd = @(vrel, AOA) 1/2*rho*A*Cl(AOA).*(Cl(AOA)./Cd(AOA)).^2.*vrel.^3; % W

Plloyd = getPlloyd(vrel, AOA);

disp(['Maximum power Lloyd formula: ' num2str(Plloyd(end)/1e6, 2) ' MW'])

% plot
figure();
plot(vrel_kmh, Plloyd/1e6);
xlabel('Relative wind speed [km/h]');
ylabel('Lloyd power [MW]');
grid on;

% P = F*v
vbat_ms = vbat/3.6;

getP = @(AOA) vbat_ms * D;

P = getP(AOA);

disp(['Maximum power with P = D*v_boat: ' num2str(P(end)/1e6, 2) ' MW'])

%% influence of angle of attack
v = vrel(end);

AOAdeg = 0:0.1:90; % deg, test various angles
AOA = deg2rad(AOAdeg);

Plloyd = getPlloyd(v, AOA);

i = find(Plloyd == max(Plloyd));
optAOA = AOAdeg(i) % deg


% plot
figure();
plot(AOAdeg, Plloyd/1e6);
xlabel('AOA [°]');
ylabel('Lloyd power [MW]');
grid on;

