%% Ex9 - Simulation of a damped mass-spring system
% 2021.09.01

clc; clear; close all;

%% Parameters
N = 1000; % [-]
m = 1;    % [kg]
Cv = 0.11; % [N/(m/s)]
k = 0.5;  % [N/m]
tt = linspace(0,100,N); % [s]

w1 = 1; % [rad/s]

%% Transfer functions
% First possibility
s = tf('s');
H = 1/(m*s^2+Cv*s+k);

% Second possibility
num = 1;
den = [m Cv k];

H2 = tf(num, den);

%% Caracteristic frequencies
w0 = sqrt(k/m);

%% Bode
% bode(H);

%% Simulation
A = 2;
input1 = A * ones(length(tt), 1);
input1(1:N/10) = 0;
output1 = lsim(H, input1, tt);

input2 = sin(w1*tt);
output2 = lsim(H, input2, tt);

input3 = exp(10*tt/N)-1;
output3 = lsim(H, input3, tt);

%% Plots
figure;
sgtitle('Simulation of a damped mass-spring system');
subplot(3,1,1);
    plot(tt, input1, tt, output1);
    title('response to an input jump');
    legend('F_{ext}(t) [N]', 'x(t) [m]');
    grid on;
subplot(3,1,2);
    plot(tt, input2, tt, output2);
    title('response to a sine');
    legend('F_{ext}(t) [N]', 'x(t) [m]');
    grid on;
subplot(3,1,3);
    plot(tt, input3, tt, output3);
    title('response to an exponential');
    grid on;
    legend('F_{ext}(t) [N]', 'x(t) [m]');

