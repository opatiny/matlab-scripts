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
fres_exp = 192e3; % Hz
fres_th = 169e3; % Hz

%% interpolation of Lb and Rb for all x at f_res_exp
% linear interpolation at experimental resonnance freq
fres = fres_th;
% inductance et resistance bobine a la freq de resonnance experimentale
Lb_res = interp1(frequency, Lb, fres);
Rb_res = interp1(frequency, Rb, fres);

save('data_res.mat', 'frequency', 'Rb', 'Lb', 'fres_exp', 'Rb_res', 'Lb_res', 'x');

%% calcul Ro_opt a la frequence de resonance
C = 39e-9; % F

Ro_opt = Lb_res./(Rb_res*C);

%% fonction de Moebius
% Ro_opt = 320; % ohm
w = 2*pi*fres;
Zb_res = Rb_res + 1i*w.*Lb_res;

% linear fit Zb
p = polyfit(real(Zb_res), imag(Zb_res),1);
linModel = polyval(p,real(Zb_res));

% compute moebius transform
H = Zb_res./((1 + 1i*w*C*Ro_opt).*Zb_res + Ro_opt)

% circular fit
[R, xc, yc] = circfit(real(H), imag(H))
% rayon environ 0.25 ohm

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

%% plot Zb on complex plane
figure();
plot(real(Zb_res), imag(Zb_res), 'ro'); hold on;
plot(real(Zb_res), linModel, 'b-');
hold off;
xlabel('Re(Z_b) [\Omega]');
ylabel('Im(Z_b) [\Omega]');
legend('Impédance', 'Régression linéaire', 'Location', 'southwest');
grid on;

%% plot Moebius
figure();
plot(real(H), imag(H), 'ro'); hold on;
circle(xc,yc,R,'b-');
plot([-0.05, 0.55], [0,0], 'g-');
hold off;
xlabel('Re(H) [\Omega]');
ylabel('Im(H) [\Omega]');
legend('H(Z_b)', 'Régression circulaire', 'y = 0', 'Location', 'southwest');
xlim([-0.05, 0.55]);
grid on;
axis equal;
