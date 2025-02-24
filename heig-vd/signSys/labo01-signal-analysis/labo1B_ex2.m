%% Labo1B - exercice 2 - reponse impulsionnelle
clc; clear; close all;

%% Variables
N = 6; % number signals
h1n = [1 1 1 1 1] ; 
h2n = [5 4 3 2 1] ; 
h3n = [1 2 3 4 5 4 3 2 1] ; 
h4n = [1 2 3 4 5 -5 -4 -3 -2 -1] ; 
h5n = zeros(1,10);
h6n = zeros(1,11);
h6n(1) = 3.27;
for n=1:10
    h5n(n) = 0.7^n ; % n = 0...10 ; 
    h6n(n+1) = -0.7^n ; % n = 0...10 ; 
end
hxn = {h1n, h2n, h3n, h4n, h5n, h6n};

%% Plot h[n]
auto_subplots(hxn);

%% Compute y[n]

xn = [0,ones(1,20),zeros(1,20)];
yxn = cell(1,N);
for i=1:N
    yxn{i} = conv(hxn{i}, xn);
    % normalise gain -> only allowed when sum of h[n] not zero
    yxn{i} = yxn{i}/sum(hxn{i});
end

%% Plot y[n]
index = 1;
figure();
for i=1:2
    for j=1:3
        subplot(3,2,index);
        nn = 0:length(yxn{index})-1;
        plot(nn,yxn{index},'*');
        xlabel('n [-]');
        title(strcat('y', string(index), '[n]'));
        grid on;
        index = index+1;
    end
end

