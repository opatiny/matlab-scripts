%% Ex 2.6.4
clear; clc; close all;

%% variables
s = tf('s');
tau = 0.1;
zeta = 0.5;
wn = 2000;

%% transfer functions
G1 = 1/(1+s*tau);
G2 = 1/(1+2*zeta/wn*s+s^2 /wn^2);

G = G2*G1;

%% plot
figure();
subplot(3,1,1)
step(G)
grid on;
subplot(3,1,2)
step(G1)
grid on;
subplot(3,1,3)
step(G2)
grid on;

%% frequential response

