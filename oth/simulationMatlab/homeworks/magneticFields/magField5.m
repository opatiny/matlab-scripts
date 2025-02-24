%% Assignment 7 - Magnetic fields - Problem 5
clear; clc; clf;

%% Test Hloop function
% should give → Hz = 0.0768 (A/m), Hr = 0.091 (A/m)
[Hz,Hr] = Hloop(1,1,1)

%% Compute magnetic field with mesh grid
% plot grid
N = 100;

r=linspace(0,0.04,N);
z = linspace(-0.02,0.02,N);
[R,Z]=meshgrid(r,z);

% calculate vector field on grid
Rloop = 0.02; % m
[Hz,Hr]=Hloop(Rloop,R,Z);

getH = @(Hr,Hz) (Hr.^2 + Hz.^2).^0.5;

H = getH(Hr,Hz);

% Superimpose field of two loops
% calculate vector field on grid
Rloop = 0.02; % m
[Hz1,Hr1]=Hloop(Rloop,R,Z, [0,-0.01]);
[Hz2,Hr2]=Hloop(Rloop,R,Z, [0,0.01]);

Hr = Hr1 + Hr2;
Hz = Hz1 + Hz2;

H = getH(Hr,Hz);

%% Magnetic field on axis
Hz_r0 = Hz(:,1);

%% Plot vectorfield
subplot(1,3,1:2);
imagesc(r,z,H);
colormap(jet);
colorbar;
caxis([0 40]); % clamp to a max value of 40
hold on;
p = streamslice(R,Z,Hr,Hz);
set(p,'LineWidth', 1)
set(p,'Color','w');
hold off;
axis equal, axis tight
xlabel('r [m]'),ylabel('z [m]');

subplot(1,3,3);
plot(z,Hz_r0,'-');
xlabel('z [m]');
ylabel('H_z [A/m]');
grid on;    

%% Function Hloop
function [Hz, Hr] = Hloop(R,r,z, C)
% Magnetic field of a current loop at point P
%   R: radius of the loop [m]
%   r: radius of P in polar coordinate 
%   z: z of P in polar coordinate
%   C (opt): center of the loop as an [r,z] point, default [0,0]
% returns:
%   Hz: z component of mag field [A/m]
%   Hr: radial component of the mag field [A/m]

if ~exist('C','var')
    C = [0,0];
end

r = r-C(1);
z = z-C(2);

I = 1; % A
mu0 = 4*pi*1e-7; % N/A^2

Rpp = (R+r).^2 + z.^2;
Rmp = (R-r).^2 + z.^2;

k2 = 4*R*r./Rpp;

[K, E] = ellipke(k2);

a = I*mu0./(2*pi)./sqrt(Rpp);

Br = a.*z./r.*((R.^2 + r.^2 + z.^2)./Rmp.*E - K);

Bz = a.*((R.^2 - r.^2 - z.^2)./Rmp.*E + K);

% B = mu * H
Hr = Br/mu0;
Hz = Bz/mu0;
end