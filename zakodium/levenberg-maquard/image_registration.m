%% Image registration example
% match a set of points from one space to another
% code comes from: https://stackoverflow.com/questions/28687872/how-can-i-use-lsqcurvefit-for-image-registration
clear; clc; close all;

%% create random points in 2D
% 20 random points in x and y between 0 and 100
% row of ones pads out third dimension
pointsList = [100*rand(2, 20); ones(1, 20)];

%% transform points by rotation and translation (and add noise)
rotateTheta = pi*rand(1); % add rotation, in radians
translateVector = 10*rand(1,2); % add translation, up to 10 units here

% 2D transformation matrix
% last row pads out third dimension
inputTransMatrix = [cos(rotateTheta), -sin(rotateTheta), translateVector(1);
                    sin(rotateTheta), cos(rotateTheta), translateVector(2);
                    0 0 1];
                
% Transform starting points by this matrix to make an array of shifted
% points.  
% For point-wise registration, pointsList represents points from one image,
% shiftedPoints points from the other image
shiftedPoints = inputTransMatrix*pointsList;
% Add some random noise
% Remove this line if you want the registration to be exact
shiftedPoints = shiftedPoints + rand(size(shiftedPoints, 1), size(shiftedPoints, 2));

%% Plot starting sets of points
figure(1)
plot(pointsList(1,:), pointsList(2,:), 'ro');
hold on
plot(shiftedPoints(1,:), shiftedPoints(2,:), 'bx');
hold off
grid on;

%% Find best fit parameters from source to destination
% Make some initial, random guesses
initialFitTheta = pi*rand(1);
initialFitTranslate = [2, 2];

guessTransMatrix = [cos(initialFitTheta), -sin(initialFitTheta), initialFitTranslate(1);
                    sin(initialFitTheta), cos(initialFitTheta), initialFitTranslate(2);
                    0 0 1];

% fit = lsqcurvefit(@fcn, initialGuess, shiftedPoints, referencePoints)             
fitTransMatrix = lsqcurvefit(@TransformPoints, guessTransMatrix, pointsList, shiftedPoints);


%% Un-shift second set of points by fit values to match sourc data
fitShiftPoints = fitTransMatrix\shiftedPoints;

% Plot
figure(1)
hold on
plot(fitShiftPoints(1,:), fitShiftPoints(2,:), 'k*');
hold off
legend('Original points', 'Shifted points', 'Unshifted points');

% Display start transformation and result fit
disp(inputTransMatrix)
disp(fitTransMatrix)

