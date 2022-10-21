%% Spectrum of object illuminated by tungstene lamp

clc; clear; close all;

%% constants
h = 6.626e-34; % [Js]
c = 3e8; % [m/s]
kB = 1.3801e-23; % [J/K]

%% use Plank's formula to generate BBS
T = 2673; % [K]
min = 400; % [nm]
max = 700; % [nm]

N = 3000; % [-]
lambda = linspace(1, N, N) * 10^(-9); % [m]

I_CN = zeros(1,N);

for i=1:N
  I_CN(i) = 2*h*c^2/lambda(i)^5/(exp(h*c/(lambda(i)*kB*T))-1);
end

%% plot emittance
% figure();
% plot(lambda*1e9, I_CN); 
% hold on;
% plot([min, min], [0,6e11], 'r');
% plot([max, max], [0,6e11], 'r');
% hold off;
% xlabel('\lambda [nm]');
% ylabel('Emittance [W/m^2/m]');
% grid on;

%% compute surface reflexion function
lambdaUm = lambda*10^(6); % [um]

reflexionFactor = 0.9* exp(-40*(lambdaUm - 0.4).^2) + 0.5*exp(-5*(lambdaUm-1.25).^2);


%% compute detector response function

detectorFactor = exp(-100*(lambdaUm - 0.5).^6);

%% final spectrum

result = I_CN .* reflexionFactor .* detectorFactor;

%% plot results
figure();
subplot(4,1,1);
plot(lambda*1e9, I_CN); 
xlabel('\lambda [nm]');
ylabel('Emittance [W/m^2/m]');
grid on;

subplot(4,1,2);
plot(lambdaUm, reflexionFactor);
xlabel('\lambda [um]');
ylabel('Reflection function [-]');
grid on;

subplot(4,1,3);
plot(lambdaUm, detectorFactor);
xlabel('\lambda [um]');
ylabel('Detector response [-]');
grid on;

subplot(4,1,4);
plot(lambda*1e9, result);
xlabel('\lambda [nm]');
ylabel('Final spectrum [W/m^2]');
grid on;