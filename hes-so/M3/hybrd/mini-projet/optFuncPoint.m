%% optimal functioning point for the ICE: max power for min comsumption
clc; clear; close all;

% to import another .m file that is in the path:
init_hyv

% retrieve useful variables
omega = ICE.Omega_def;
torque = ICE.Torque_def;
conso = ICE.Fuel_consumption;

% 3D plot of consumption
[xx,yy] = meshgrid(omega, torque);

figure(1)
surf(omega,torque,conso)
xlabel("Omega (rad/s)")
ylabel("Torque (Nm)")
zlabel("Consumption (g/s)")


% compute power
P = omega'* torque;

% add legend
nbCurves = size(P,2)

legendDataT = [];
legendDataO = [];

for i=1:nbCurves
    textT = "T = " + round(torque(i)) + " Nm";
    legendDataT = [legendDataT textT];

    textO = "omega = " + round(omega(i)) + " rad/s";
    legendDataO = [legendDataO textO];
end


figure(2)
plot(P, conso, '.-')
grid on
xlabel("Power (W)")
ylabel("Consumption (g/s)")
legend(legendDataT, "Location", "southeast")
title("Fuel consumption curves for constant torques")


% figure(3)
% plot(P', conso, '.-')
% grid on
% xlabel("Power (W)")
% ylabel("Consumption (g/s)")
% legend(legendDataO, "Location", "southeast")
% title("Fuel consumption curves for constant speeds")


%% Compute points with min conso for an array of powers

Plim = 10600; % W

P_ref = (1:43)*1000; % W

% find limit index
index = find(P_ref > Plim, 1);


% under Plim
omega_opt = omega(1); % best yield at lowest speed

omega_ref1 = ones(1, index) * omega_opt;
torque_ref1 = P_ref(1:index)/omega_opt;

% over Plim
T_opt = torque(end); % best yield at highest torque

torque_ref2 = ones(1, length(P_ref)-index)*T_opt;
omega_ref2 = P_ref((index+1):end)/T_opt;


table.P = P_ref;
table.omega = [omega_ref1 omega_ref2];
table.T = [torque_ref1 torque_ref2];

save('power_lookup_table.mat', 'table')

%% check where our points lie in plot

nbPoints = length(table.P);

conso_ref = [];

for i=1:nbPoints
    indexT = find(torque>=table.T(i),1);
    if(isempty(indexT))
        indexT = length(torque);
    end
    indexOmega = find(omega>=table.omega(i),1);
    if(isempty(indexOmega))
        indexOmega = length(omega);
    end
    conso_ref(i) = conso(indexOmega, indexT);
end


figure(2)
plot(P, conso, '.-'); hold on;
plot(P_ref, conso_ref, 'r.-', 'MarkerSize', 15, 'LineWidth', 2);
hold off;
grid on
xlabel("Power (W)")
ylabel("Consumption (g/s)")
legend([legendDataT 'Optimal torque/speed pairs'], "Location", "southeast")
% title("Fuel consumption curves for constant torques")
