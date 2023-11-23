%% Freq de resonnance theorique pour x = 0.7mm
clear; clc; close all;
dirName = 'impedance-scan-frequence';

x = linspace(50,90,9)*1e-5;

fileNames = ["50", "55", "60", "65", "70", "75", "80", "85", "90"];

%% read data from csv files
fileName = join([fileNames(1), ".csv"], "");
filePath = join([dirName, fileName], "/");
firstData = readtable(filePath);

frequency = firstData.Frequency_Hz_(1:end-1);
arrayLength = length(frequency);

Rb = zeros(arrayLength,length(fileNames));
Lb = zeros(arrayLength,length(fileNames));

for i = 1:length(fileNames)
    fileName = join([fileNames(i), ".csv"], "");
    filePath = join([dirName, fileName], "/");
    
    currentData = readtable(filePath);
    
    Rb(:,i) = currentData.Rs_Ohm__data(1:end-1);
    Lb(:,i) = currentData.Ls_H__data(1:end-1);
end

%% experimental resonnance frequency
f_res_exp = 192e3; % Hz

%% interpolation of Lb and Rb for all x at f_res_exp
% linear interpolation at experimental resonnance freq
fres_exp = 192e3; % Hz
% inductance et resistance bobine -> prob not really useful but oh well
Lb_res = interp1(frequency, Lb, fres_exp)
Rb_res = interp1(frequency, Rb, fres_exp)

save('data_res.mat', 'frequency', 'Rb', 'Lb', 'fres_exp', 'Rb_res', 'Lb_res', 'x');

%% calcul Ro_opt a la frequence de resonnance
C = 39e-9; % F

Ro_opt = Lb_res./(Rb_res*C)

%% plot R and L depending on x for f_res_exp
% figure();
% hold off;
% plot(x, Rb_res, 'o');
% xlabel('x [m]');
% ylabel('R_b interpolée [\Omega]');
% grid on;
% 
% figure();
% hold off;
% plot(x, Lb_res, 'o');
% xlabel('x [m]');
% ylabel('L_b interpolée [\Omega]');
% grid on;

%% plot R0_opt
% figure();
% hold off;
% plot(x, Ro_opt, 'o');
% xlabel('x [m]');
% ylabel('R_{o,opt} [\Omega]');
% grid on;
