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
P = omega'* torque

P_vec = reshape(P,1,[]);
conso_vec = reshape(conso,1,[]);

% add legend
nbCurves = size(P,2)

legendDataT = [];
legendDataO = [];

for i=1:nbCurves
    textT = "T = " + round(torque(i)) + " Nm"
    legendDataT = [legendDataT textT]

    textO = "omega = " + round(omega(i)) + " rad/s"
    legendDataO = [legendDataO textO]
end


figure(2)
plot(P, conso, '.-')
grid on
xlabel("Power (W)")
ylabel("Consumption (g/s)")
legend(legendDataT, "Location", "southeast")
title("Fuel consumption curves for constant torques")


figure(3)
plot(P', conso, '.-')
grid on
xlabel("Power (W)")
ylabel("Consumption (g/s)")
legend(legendDataO, "Location", "southeast")
title("Fuel consumption curves for constant speeds")



% define optimum
index = 1;
ICE.Omega_opt = ICE.Omega_def(index);
ICE.Torque_opt = ICE.Torque_def(index);