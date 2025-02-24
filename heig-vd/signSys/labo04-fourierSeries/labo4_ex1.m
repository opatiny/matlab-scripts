%% Labo4 - Ex1
clc; clear; close all;

%% load data
 data = load('enreg_signaux2.mat');
 xtt = data.xtt;
 tt = data.tt;
 xT = data.xT;
 tT = data.tT;
 T0 = data.T0;
 Te = data.Te;
 
 N = length(tt);
 F0 = 1/T0;
 M = 100;
 
 %% energy, power, average and rms
 average = mean(xT)
 energy = sum(xT.^2)
 power = energy/(T0/Te)
 rms = sqrt(power)
 
 %% complex coefficients
 Xjk = ASF(xT,tT, M);
 
 % use parseval to compute power
 parsevalPower = sum(abs(Xjk).^2)
 
 %% reconstruct with M=10
 module = abs(Xjk);
 phase = angle(Xjk);
 
 xr = SynthSF(Xjk, F0, tT);

 %% plots
 M_vector = -M:M;
 
 figure();
 subplot(4,1,1);
 plot(tT,xT, '.')
 title('1 period: xT');
 xlabel('Time [s]');
 
 subplot(4,1,2);
 stem(M_vector,module, '.')
 title("Module of fourier series with M = " + M);
 xlabel('k [-]');
 
 subplot(4,1,3);
 stem(M_vector,phase, '.')
 title("Phase of fourier series with M = " + M);
 ylabel('phase [rad]');
 xlabel('k [-]');
 
 subplot(4,1,4);
 plot(tT,xr, '.', tT, xT, '-');
 title("Reconstructed signal with M = " + M);
 xlabel('Time [s]');