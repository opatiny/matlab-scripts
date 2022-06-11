%% Labo 1A - Ex2: Audio signal
clc; clear; close all;

%% Variables
fe = 8000; % in Hz
tmin = 0; % [s]
tmax = 1; % [s]
A = 1; % [-]

Te = 1/fe;

tt = tmin:Te:tmax-Te;
length(tt)

%% Generate, plot and play sounds

for k=1:9
    f0 = k*800;
    xt = A*sin(2*pi*k*f0*tt);
    subplot(3,3,k);
    plot(tt(1:80), xt(1:80), '.-');
    ylabel([num2str(f0), 'Hz']);
    xlabel('time [s]');
    
    soundsc(xt,fe);
    pause(2);
end

%% Comments
% g: grave, a: aigu, -: bizarre
% that's the observed pattern: g a g a - a g a g
