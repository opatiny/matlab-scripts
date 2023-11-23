%% Homogenous transforms
clear; clc; close all;

XYZrotate = [90,180,0];
XYZtransl = [1,0,0];

% Compute homogeneous transform
Rx = rotm2tform(rotx(XYZrotate(1)));
Ry = rotm2tform(roty(XYZrotate(2)))
Rz = rotm2tform(rotz(XYZrotate(3)))
K = trvec2tform([XYZtransl(1),XYZtransl(2),XYZtransl(3)]);

% Transformation in current frame/ mobile frame
M = Rx*Ry*Rz*K %Rx ->Ry ->Rz ->t

% Transformation in fixed frame
F = K*Rz*Ry*Rx %Rx ->Ry ->Rz ->t


% pick transformation
T = F;
lims = max(max (K))*[ -1, 1]+[ -1, 1];
axs = axes ; view(3); daspect([1 1 1]);
grid minor;
xlabel('X'); ylabel('Y'); zlabel('Z');
xlim(lims); ylim(lims); zlim(lims);
xline(0, 'k--'); yline(0, 'k--');
hold(gca ,'on');
h = hgtransform('Parent',gca);
kids (1) = plot3([0 ,1] ,[0 ,0] ,[0 ,0] , 'Color' ,[1 ,0 ,0] , 'Tag','X- Axis','Parent',h);
kids (2) = plot3([0 ,0] ,[0 ,1] ,[0 ,0] , 'Color' ,[0 ,1 ,0] , 'Tag','Y- Axis','Parent',h);
kids (3) = plot3([0 ,0] ,[0 ,0] ,[0 ,1] , 'Color' ,[0 ,0 ,1] , 'Tag','Z- Axis','Parent',h);
set(kids, 'LineWidth' ,3);
set(h,'matrix',T);

if norm([ XYZrotate XYZtransl ]) > 0
  % Name the frame O' only if a transformation has happened ...
  title( sprintf('O''x''y''z'' = [%d;%d;%d]',T(1:3 ,4) ));
else
  % otherwise , name it just O...
  title( sprintf('Oxyz = [%d;%d;%d]',T(1:3 ,4) ));
end
