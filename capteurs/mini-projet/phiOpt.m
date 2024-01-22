%% Resolution dephasage miniminsant non-linearite
clear; clc; close all;

%% data
phi = [0,15,30,45,60,75,90,105];
data = csvread('./data/U-x.csv');
x = data(:,1);

%% compute non-linearity for each dephasage
for i=2:length(data)
    x = data(:,1);
    y = data(:,i);
    p = polyfit(x, y, 1);
    linReg = polyval(p, x);
    linRegs(:,i-1) = linReg;
    
    maxErr = max(abs(y-linReg));
    yDiff = max(y)-min(y);
    
    NL(i-1) = 100 * maxErr/yDiff;
end


%% fit order 2 for NL
phi_fit = 0:1:110;
p = polyfit(phi(2:end), NL(2:end), 2)
fit = polyval(p, phi_fit);

[~, index]= min(fit);
optimalPhi = phi_fit(index)

%% plot
% figure();
% plot(x, data(:, 2:end), 'o'); hold on;
% plot(x, linRegs, '-');
% hold off;
% grid on;
% xlabel('x [mm] [°]');
% ylabel('U [V]');

figure();
plot(phi, NL, 'ro'); hold on;
plot(phi_fit, fit, 'b-');
hold off;
grid on;
xlabel('\phi [°]');
ylabel('NL [%]');
legend('Mesures', 'y = 0.008x^2 - 1.37x + 63.4');