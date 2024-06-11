%% Homework 10 - Exercise 2
% Linear regressions
clc; clear; clf;

%% load data
data = readtable('hw10_cars.xlsx');

y = data.MilesPerGallon; % consumption [mpg]
x1 = data.Weight; % [kg]
x2 = data.Horsepower; % [PS]

m = length(x1);

x0 = ones(m,1);

%% a)
X = [x0 x1 x2];

beta_a = X\y

ya = X*beta_a;

cost_a = getCost(y,ya)

% plot
[X1, X2] = meshgrid(x1,x2);
% dont like this approach...
Ya = beta_a(1) + beta_a(2)*X1 + beta_a(3)*X2;

scatter3(x1,x2,y);
hold on;
surf(x1,x2,Ya, 'EdgeColor','interp', 'FaceColor','none');
hold off;
xlabel('weight [kg]');
ylabel('horsepower [PS]');
zlabel('consumption [mpg]');

%% b)
X = [x0 x1 x2 x1.*x2];

beta_b = X\y

yb = X*beta_b;

cost_b = getCost(y,yb)

% plot
[X1, X2] = meshgrid(x1,x2);
Yb = beta_b(1) + beta_b(2)*X1 + beta_b(3)*X2 + beta_b(4)*X1.*X2;

scatter3(x1,x2,y);
hold on;
surf(x1,x2,Yb, 'EdgeColor','interp', 'FaceColor','none');
hold off;
xlabel('weight [kg]');
ylabel('horsepower [PS]');
zlabel('consumption [mpg]');

%% cost function
function C = getCost(y,yhat)
m = length(y);
C = sqrt(1/m*sum((y-yhat).^2));
end