%% Get direct geometric model from Denavit-Hartenberg table
clear; clc; close all;


%% data
% DH: for each joint a_i, alpha_i, d_i, theta_i -> N*4
dhTable = [0 0 3 0
           1 0 0 1
           1 0 0 1];
% vectors corresponding to z axis of each joint
zAxes = [0 0 0 
        0 0 0 
        1 1 1];
% joint types can be roitoid 'R' or prismatic 'P'
jointTypes = ['R' 'R' 'R'];

nbJoints = length(dhTable(:,1));

%% check data
if(nbJoints ~= length(zAxes) || nbJoints ~= length(jointTypes))
    error('dhTable, zAxes and jointTypes shouls all have the same length');
end
  
%% MGD: modele geometrique direct
[dgm, transforms] = getDgmFromDh(dhTable);

disp(transforms)
[x,y,z] = get3Dpoints(transforms);

points = [x;y;z]

%% Jacobien geometrique

J = getGeometricJacobian(points, zAxes, jointTypes)

%% plot results
figure();
plot(x,y, '-o');hold on;
axis equal;
hold off;
grid on;
xlabel('x [m]');
ylabel('y [m]');
ylim([-5, 5]);
ylim([-5,5]);

