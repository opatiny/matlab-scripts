%% Labo1B - exercice 3 - equations aux differences
clc; clear; close all;

%% Variables
N = 6; % number of filters

xn = [0, ones(1,50)];

a = [1,-1.4,0.45];
a1 = [1,-1.4,0.7];
a2 = [1, -1.4, 0.9];
a3 = [1, -1,4, 0.45];
a4 = [1, -1.4, 0.7];
a5 = [1, -0.7, 0];

b = [1,2,1];
b1 = [1,2,1];
b2 = [1,2,-1];
b3 = [1,-2,1];
b4 = [1,-2,1];
b5 = [1,0,0];

aCell = {a, a1, a2, a3, a4, a5};
bCell = {b, b1, b2, b3, b4, b5};

%% Compute y[n] for all filters
yCell = cell(1,N);
for i = 1:N
    yCell{i} = filtre_ed2(aCell{i},bCell{i},xn)
end

%% plot

nn1 = 1:length(xn);
for i = 1:N
    nn2 = 1:length(yCell{i});

    figure();
    plot(nn1, xn, 'o', nn2, yCell{i}, 'o-');
end