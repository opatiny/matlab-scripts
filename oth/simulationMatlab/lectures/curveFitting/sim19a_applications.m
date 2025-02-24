%% applications 1: image processing (low pass = blur = Weichzeichnen)

clear,clc,clf
B = imread( 'sim09_Katze.bmp' );
sz = size(B);   % get image size
% plot image
subplot(1,2,1);  image( B );  axis image

% transform to spectral domain
Bf = fft2( double(B) ); % 2-dim. Fourier-Transformation
Bf = fftshift(Bf);      % shift low frequencies to center

fak=0.4;      % 40% of all frequencies
% mask vectors
z=round(sz(1)/2*(1-fak/2) : sz(1)/2*(1+fak/2));
s=round(sz(2)/2*(1-fak/2) : sz(2)/2*(1+fak/2));
% buffer masked frequencies
Xf=Bf( z,s,:);
Bf=zeros(sz);   % initialize
Bf( z, s,:)=Xf; % keep only low frequencies

% back transformation
Bf= ifftshift(Bf);
B1 = ifft2( Bf );          

% plot  
subplot(122);image(uint8(abs(B1)));axis image

% alternative: high pass for edge detection
% compression methods like .mp3 or .jpg work similar

%% application 2: optical diffraction (Beugung)
% Fraunhofer diffraction = Fourier transformation 
% http://de.wikipedia.org/wiki/Beugung_%28Physik%29

% 1D-diffraction at (double-)slit
clear,clc,clf

% image of slit
n=2^12;
x = linspace(-1,1,n);
y = (x<0.1).*(x>0.05);
y=y+fliplr(y);          % comment to switch between double and single slit
subplot(411),plot(x,y) 
title('slit geometry')
ylabel('brightness')
axis ([-1 1 -1 2] )
% grey scale image
subplot(412),imagesc(y), colormap gray

% diffraction image
ts=x(2)-x(1);
ws=2*pi/ts;             % Sample frequency
w=ws/n*(-n/2:n/2-1);    % frequency axis
c = fftshift(fft(y))*ts;
idx=abs(w)<1000;
subplot(413),plot(w(idx),abs(c(idx)))
title('diffraction image')
ylabel('brightness')
% grey scale image
subplot(414),imagesc(abs(c(idx))) 

%%  2D-diffraction at square apperture
% http://www.piart-plus.de/foto/vorles/fotos/cbb_3.jpg

clear,clf
n=1000;     % number of pixels
fak=1;      % brightness
B=zeros(n);

% apperture
l=25;       % aperture size
B(n/2-l:n/2+l, n/2-l:n/2+l)=1;  % Loch
subplot(211),imagesc(B)
title('square hole'),axis image, colormap gray

% diffraction image
Bft=fftshift(fft2(B));
subplot(212),image(abs(Bft)*fak)
title('diffraction image'),axis image, colormap gray


%%  2D-diffraction at grid
% http://psi.physik.kit.edu/img/Gitter_Interferenz.jpg
clear,clf
n=1000;     % number of pixels
fak=1;      % brightness
B=zeros(n);

% grid
b=8;
w=8;
for i1=1:b+w:n
    for i2=1:b+w:n
        B(i1:(i1+w-1),i2:(i2+w-1))=1;
    end
end
imagesc(B),axis image
subplot(211),imagesc(B)
title('grid'),axis image, colormap gray

% diffraction image
Bft=fftshift(fft2(B));
subplot(212),image(abs(Bft)*fak)
title('diffraction image'),axis image, colormap gray





