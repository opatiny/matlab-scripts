%% Verify output beam shape for a spherical dioptre
clc; clear; close all;

%% Dioptre characteristics
nv = 1.34; % [-]
radius = 25; % [mm]
f_mes = 73; % [mm]

%% load experimental data
data = readtable('labo5-dioptreSpherique-data.csv'); % [mm]
x = data.x; % [mm]
h1 = data.d1/2; % [mm]
h2 = data.d2/2; % [mm]

%% compute theoretical beams
beamDiameter = 40
N = beamDiameter + 1;
H = linspace(-beamDiameter/2, beamDiameter/2, N);

h = H/radius;


startX = zeros(1,N);
startY = zeros(1,N);
for i= 1:N
    theta = asin(H(i)/radius);
    startX(i) = -radius * (1 - cos(theta));
    startY(i) = H(i);
end

endX = zeros(1,N);
endY = zeros(1,N);
for i=1:N
    relativeX = nv/(nv*sqrt(1-h(i)^2) - sqrt(1-nv^2*h(i)^2)) -1;
    endX(i) = relativeX * radius;
end

%% plot results
t = linspace(-pi/2,pi/2,1000);

figure(1)
plot(radius*cos(t)-radius,radius*sin(t), 'Color', 'black'); axis equal; hold on;
plot([0, 0], [-radius, radius], 'black'); % vertical line at zero
plot([f_mes, f_mes], [-radius, radius], '--black'); % vertical line at mesured focal length

for i = 1:N
    color = 'black';
    if i == 13 || i == 14 || i == 28 || i == 29
        color = 'red';
    elseif i == 18 || i == 24
        color = 'blue';
    elseif i == beamDiameter/2 + 1
        color = 'green';
    end
    
    plot([-radius, startX(i)],[startY(i), startY(i)], 'Color', color);
    plot([startX(i), endX(i)], [startY(i), endY(i)], 'Color', color);
end

plot(x,h1, 'r.', 'MarkerSize', 10);
plot(x, h2, 'b.', 'MarkerSize', 10);

hold off;
xlim([-radius,80]);
ylim([-radius, radius]);
xlabel('x [mm]');
ylabel('h [mm]');
grid on;