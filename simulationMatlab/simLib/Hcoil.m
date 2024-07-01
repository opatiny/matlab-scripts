function [Hz, Hr] = Hcoil(N,R,L,r,z)
% Magnetic field of a coil at point P. Current through the coil is 1A.
%   N: number of turns of the coil
%   R: radius of the coil [m]
%   L: length of the coil [m]
%   r: radius of P in polar coordinates 
%   z: z of P in polar coordinates
% returns:
%   Hz: z component of mag field [A/m]
%   Hr: radial component of the mag field [A/m]
dz = L/(N-1);

% compute center of the loops
half = (N-1)/2;
Cz = (-half:half)*dz;

C = [zeros(N,1) Cz'];

Hz = 0;
Hr = 0;

for i=1:N
    % i % for debug
    [Hzi, Hri] = Hloop(R,r,z,C(i,:));
    Hz = Hz + Hzi;
    Hr = Hr + Hri;
end
end