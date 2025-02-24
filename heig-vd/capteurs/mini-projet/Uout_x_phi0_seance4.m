%% Tension finale en fonction du mesurande x pour signal en phase (phi=0)
clear; clc; close all;

data = [0.50	0.800
        0.55	0.860
        0.60	0.912
        0.65	0.949
        0.70	0.976
        0.75	0.988
        0.80	0.992
        0.85	0.989
        0.90	0.979];
  
x = data(:,1);
Uout = data(:,2);

%% cosine fit
% b: amplitude, pulsation, offset
cosFit = @(b,x) b(1)*sin(b(2)*x) + b(3);

leastSquare = @(b) sum((cosFit(b,x) - Uout).^2); 
initParams = [0.4; 1.2; 0.8];

model = fminsearch(leastSquare, initParams)

xth = 0.5:0.01:0.9;

Uout_th = cosFit(model, xth);


%% plot
figure();
plot(x, Uout, 'o'); hold on;
plot(xth, Uout_th, '-');
hold off;
grid on;
xlabel('x [mm]');
ylabel('U_{out} [V]');
legend('Mesures', 'Fit sinusoidal', 'Location', 'southeast');