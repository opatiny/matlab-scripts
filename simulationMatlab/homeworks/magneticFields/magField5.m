%% Assignment 7 - Magnetic fields - Problem 5
clear; clc; clf;

%% Test Hloop function
% should give → Hz = 0.0768 (A/m), Hr = 0.091 (A/m)
[Hz,Hr] = Hloop(1,1,1)

%% Plot magnetic field
% plot grid
N = 100;

r=linspace(0,0.04,N);
z = linspace(-0.02,0.02,N);
[R,Z]=meshgrid(r,z);

% calculate vector field on grid
Rloop = 0.02; % m
[Hz,Hr]=Hloop(Rloop,R,Z);

H = (Hr.^2 + Hz.^2).^0.5;

% plot vectorfield
imagesc(r,z,H);
colormap(jet);
colorbar;
hold on;
p = streamslice(R,Z,Hr,Hz);
set(p,'LineWidth', 1)
set(p,'Color','w');
hold off;
axis equal, axis tight
xlabel('r'),ylabel('z')

%% Function Hloop
function [Hz, Hr] = Hloop(R,r,z)
% Magnetic field of a current loop at point P
%   R: radius of the loop [m]
%   r: radius of P in polar coordinate 
%   z: z of P in polar coordinate 
% returns:
%   Hz: z component of mag field [A/m]
%   Hr: radial component of the mag field [A/m]

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