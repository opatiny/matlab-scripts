function [Hz, Hr] = Hloop(R,r,z,C)
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