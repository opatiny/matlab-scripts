%% Assignment 8 - Exercise 2
clear; clc; clf;

%% Variables
g = 9.81; % m/s^2
v0 = 5; % m/s
h0 = 0:10;

%% Function to minimize

getRange = @(beta, h0) v0*cos(beta)/g.*(v0*sin(beta) + ...
      sqrt((v0*sin(beta)).^2 + 2 * g * h0));
 
  
optBetas = zeros(1,length(h0));

for i = 1: length(h0)
    hi = h0(i);
    % the minus is necessary to find max instead of min
    fun = @(beta) -getRange(beta,hi);
    x0 = pi/4;
    
    optBetas(i) = fminsearch(fun, x0);
end

degBeta = rad2deg(optBetas);

%% Plot

plot(h0, degBeta, 'bo-');
xlabel('h [m]');
ylabel('\beta [°]');
grid on;