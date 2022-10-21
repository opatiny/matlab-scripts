%% Small angles approximation
clc; clear; close all;

% we want tan(theta), cos(theta) and sn(theta) to be close enough to theta

theta = linspace(0,89, 10000); % [°]
thetaRad = theta * pi / 180; % [rad]

sinError = abs(thetaRad-sin(thetaRad))./thetaRad * 100; % [%]
cosError = (1 - abs(1 - cos(thetaRad) - thetaRad)./thetaRad) * 100 % [%]
tanError = abs(thetaRad-tan(thetaRad))./thetaRad * 100; % [%]

%% plot
figure();
plot(thetaRad, sinError);
hold on;
plot(thetaRad, cosError);
plot(thetaRad, tanError);
hold off; 
xlabel('\theta [rad]');
ylabel('Relative error [%]');
ylim([0,10]);
legend('sin error', 'cos error', 'tan error');
grid on;

