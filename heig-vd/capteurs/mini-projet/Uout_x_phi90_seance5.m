%% Tension finale en fonction du mesurande x pour signal en phase (phi=0)
clear; clc; close all;

data = [0.50	0.335	0.250
        0.55	0.288	0.193
        0.60	0.224	0.140
        0.65	0.160	0.068
        0.70	0.098	0.006
        0.75	0.034	-0.068
        0.80	-0.026	-0.130
        0.85	-0.088	-0.185
        0.90	-0.143	-0.245];
  
x = data(:,1);
Uout90 = data(:,2);
Uout96 = data(:,3);

%% linear fit

p90 = polyfit(x, Uout90, 1)
xth = 0.5:0.01:0.9;
Uout90_th = polyval(p90, xth);

p96 = polyfit(x, Uout96, 1)
xth = 0.5:0.01:0.9;
Uout96_th = polyval(p96, xth);


errors = max(abs(Uout96 - polyval(p96, x)))

%% plot
figure();
plot(x, Uout90, 'ro'); hold on;
plot(xth, Uout90_th, 'r-');
plot(x, Uout96, 'bo');
plot(xth, Uout96_th, 'b-');
hold off;
grid on;
xlabel('x [mm]');
ylabel('U_{out} [V]');
legend('Mesures pour \phi = 90°', 'y = -1.22x + 0.95',...
    'Mesures pour \phi = 96°', 'y = -1.26x + 0.89', 'Location', 'southwest');