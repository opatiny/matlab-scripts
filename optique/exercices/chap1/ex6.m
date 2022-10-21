%% Compute efficiency of tungstene lamp
% Compute efficiency of tungstene lamp in the visible spectrum 400-700nm

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
figure();
plot(lambda*1e9, I_CN); 
hold on;
plot([min, min], [0,6e11], 'r');
plot([max, max], [0,6e11], 'r');
hold off;
xlabel('\lambda [nm]');
ylabel('Emittance [W/m^2/m]');
grid on;

%% compute integral
% use a delta lambda of 1 nm
delta_x = 1e-9; % [m]
startIndex = 400; % [-]
endIndex = 700; % [-]

I_visible = 0;
for i=startIndex:endIndex
   I_visible = I_visible + I_CN(i)*delta_x;
end

I_total = 0;
for i=1:N
   I_total = I_total + I_CN(i)*delta_x;
end
I_total
percentsVisible = I_visible/I_total*100;

fprintf('Percentage of energy in visible spectrum: %.2f%%\n', percentsVisible);
