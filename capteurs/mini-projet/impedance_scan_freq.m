%% Impedance en fonction de la frequence et de la position
clear; clc; close all;

dirName = 'impedance-scan-frequence';

x = linspace(50,90,9)*1e-5;

fileNames = ["50", "55", "60", "65", "70", "75", "80", "85", "90"];

%% read first data to know dimensions
fileName = join([fileNames(1), ".csv"], "");
filePath = join([dirName, fileName], "/");
firstData = readtable(filePath);

frequency = firstData.Frequency_Hz_;
arrayLength = length(frequency);

R = zeros(arrayLength,length(fileNames));
L = zeros(arrayLength,length(fileNames));

for i = 1:length(fileNames)
    fileName = join([fileNames(i), ".csv"], "");
    filePath = join([dirName, fileName], "/");
    
    currentData = readtable(filePath);
    
    R(:,i) = currentData.Rs_Ohm__data;
    L(:,i) = currentData.Ls_H__data;
end



%% compute Zb
Zb = R + 1i*2*pi*frequency.*L

%% find sensibility at x = 0.7 and compute resonnance frequency

index65 = find(fileNames == "65");
index75 = find(fileNames == "75");

vecteur_sensi= abs(Zb(:,index75)-Zb(:,index65))/(0.75-0.65);
sensi_max = max(vecteur_sensi);
freqIndex = find(vecteur_sensi==sensi_max);
freq_res = frequency(freqIndex) % freq de resonnance en x = 0.7 mm

%% plot L and R
% figure();
% loglog(frequency, R); hold on;
% loglog([freq_res, freq_res], [0,1e4]);
% hold off;
% grid on;
% xlabel('Fréquence [Hz]');
% ylabel('Résistance [\Omega]');
% legend(fileNames, 'Location', 'northwest')
% 
% figure();
% plot(frequency, L); hold on;
% plot([freq_res, freq_res], [-1e-4,1e-4], 'r');
% hold off;
% grid on;
% xlabel('Fréquence [Hz]');
% ylabel('Inductance [H]');
% legend(fileNames, 'Location', 'southwest')

%% compute linear models
f150 = 150e3; % Hz
f150Index = find(frequency == f150);

f250 = 250e3; % Hz
f250Index = find(frequency == f250);

a = [x;x;x;x;real(Zb(f150Index,:)); real(Zb(f250Index,:))];
b = [R(f150Index,:); R(f250Index,:); L(f150Index,:); L(f250Index,:); imag(Zb(f150Index,:)); imag(Zb(f250Index,:))];
linModels = [];

for i = 1:6
    p = polyfit(a(i,:), b(i,:),1);
    model = polyval(p,a(i,:));
    linModels = [linModels; model];
end


%% plot R and L depending on x for 150kHz and 250kHz
% figure();
% hold off;
% plot(x, R(f150Index,:), 'ro'); hold on;
% plot(x, R(f250Index,:), 'bo');
% plot(x, linModels(1,:), 'r-');
% plot(x, linModels(2,:), 'b-');
% xlabel('Distance x [m]');
% ylabel('Résistance [\Omega]');
% legend('f = 150kHz', 'f = 250kHz');
% grid on;
% 
% figure();
% plot(x, L(f150Index,:), 'ro'); hold on;
% plot(x, L(f250Index,:), 'bo');
% plot(x, linModels(3,:), 'r-');
% plot(x, linModels(4,:), 'b-');
% xlabel('Distance x [m]');
% ylabel('Inductance [H]');
% legend('f = 150kHz', 'f = 250kHz','Location', 'southeast');
% grid on;

figure();
plot(real(Zb(f150Index,:)), imag(Zb(f150Index,:)), 'ro'); hold on;
plot(real(Zb(f250Index,:)), imag(Zb(f250Index,:)), 'bo');
plot(real(Zb(f150Index,:)), linModels(5,:), 'r-');
plot(real(Zb(f250Index,:)), linModels(6,:), 'b-');
xlabel('\Re(Z_b) [\Omega]');
ylabel('\Im(Z_b) [\Omega]');
legend('f = 150kHz', 'f = 250kHz','Location', 'southeast');
grid on;
