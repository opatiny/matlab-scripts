%% Assignment 8 - Magnetic fields - Problem 5
clear; clc; clf;

%% Test Hloop function
[Hz,Hr] = Hcoil(100, 0.005, 0.01, 0.003, 0.005)

%% Compute magnetic field with mesh grid
% plot grid
gridRes = 100;

r=linspace(0,0.04,gridRes);
z = linspace(-0.05,0.05,gridRes);
[R,Z]=meshgrid(r,z);

% calculate vector field on grid
Rloop = 0.01; % m
L = 0.04;
N = 31831;
N = 1000
% this is really slow....
[Hz,Hr]=Hcoil(N,Rloop,L,R,Z);

%% From H to B
mu0 = 4*pi*1e-7; % N/A^2

Bz = Hz*mu0;
Br = Hr*mu0;

getNorm = @(Hr,Hz) (Hr.^2 + Hz.^2).^0.5;

B = getNorm(Br,Bz)

% mag field on Z axis
Bz_r0 = Bz(:,1);

%% Plot vectorfield
subplot(1,3,1:2);
imagesc(r,z,B);
colormap(jet);
colorbar;
hold on;
p = streamslice(R,Z,Br,Bz);
set(p,'LineWidth', 1)
set(p,'Color','w');
hold off;
axis equal, axis tight
xlabel('r [m]'),ylabel('z [m]');

subplot(1,3,3);
plot(z,Bz_r0,'-');
xlabel('z [m]');
ylabel('B_z [T]');
grid on;    

