%% Titre
% Date :
clc; clear; close all;

%% Variables
N = 100;                    % nombre de points
time1 = linspace(0, 100, 15);
time2 = linspace(0,100, N);
A1 = 1;
A2 = 2;
omega1 = 0.1;
omega2 = 0.2;

randomArray = rand([1,N]);

%% Fonction
sin1 = A1*sin(time1*omega1);
sin2 = A2*sin(time2*omega2);

%% Affichages
figure;
plot(time1, sin1, '-og', time2, sin2, '-om');
legend('first sinus \omega', 'second sinus');
grid on;
title(['Two harmonic oscillations with freq ', num2str(omega1), ' and ', num2str(omega2)],'This is a subtitle');
xlabel('Time [s]');
ylabel('Amplitude [Hz]');
axis([-5 105 -2.5 2.5]) % scaling the plot
text(0,-1,'$\displaystyle\frac{W}{h}$', 'interpreter', 'latex');

% set(get(gca,'title'),'Position',[0,0]) %move text anywhere
% axis equal; % to have same scale on both axis

figure;
plot(time2, randomArray);
