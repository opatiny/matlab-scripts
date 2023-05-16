%% Image registration example
% match a set of points from one space to another
% code comes from: https://stackoverflow.com/questions/28687872/how-can-i-use-lsqcurvefit-for-image-registration
clear; clc; close all;

%% use Levenberg-Marquardt in lsqcurvefit
options = optimoptions('lsqcurvefit', 'Algorithm', 'levenberg-marquardt');
lb = [];
ub = [];

%% create random points in 2D
% 20 random points in x and y between 0 and 100
% row of ones pads out third dimension
 points = [1,2,3,4;
              5,6,7,8;
              1,1,1,1;]
         
%% transform points by rotation and translation (and add noise)
rotateTheta = 0;
translateVector = [0,0];

% 2D transformation matrix
% last row pads out third dimension
inputTransMatrix = [cos(rotateTheta), -sin(rotateTheta), translateVector(1);
                    sin(rotateTheta), cos(rotateTheta), translateVector(2);
                    0 0 1];
                
% Transform starting points by this matrix to make an array of shifted
% points.  
% For point-wise registration, pointsList represents points from one image,
% shiftedPoints points from the other image
shiftedPoints = TransformPointParams([0,0,0,1], points)

%% Plot starting sets of points
figure(1)
plot(points(1,:), points(2,:), 'ro');
hold on
plot(shiftedPoints(1,:), shiftedPoints(2,:), 'bx');
hold off
grid on;

%% Find best fit parameters from source to destination
% Make some initial, random guesses
initialParams = [0,0,0,2];
       
[X, resnorm, residual] = lsqcurvefit(@TransformPointParams, initialParams, points, shiftedPoints, lb, ub, options);
disp('resnorm')
disp(resnorm);
disp(residual);
