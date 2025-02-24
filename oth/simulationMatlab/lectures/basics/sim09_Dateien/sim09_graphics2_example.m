% Grafik 2D
% source: Angelika Bosl, "Einführung in Matlab/Simulink", Hanser Verlag 
% Grafikbeispiele im zweidimensionalen Bereich
% aufgeteilt in 4 Abschnitte (Sections): Definition, 1., 2. und 3. Grafikfenster

%% 
% Definition der verwendeten Vektoren und Matrizen
w=logspace(-1,1,100); % logarithmische Verteilung
t=0:0.1:2*pi; % lineare Verteilung von 0 bis 2Pi
y1=exp(w); % Exponentialfunktion
y2=sin(t); % Sinusfunktion
y3=peaks(10); % peaks-Funktion (Gauss’sche Verteilung)
Y4=randi(6,12,3); % Zufallsverteilung 3 Würfel à 12 Würfe
e=randi(2,63,1); % Vektor der Fehlerabschätzung
x5=randi(6,6,1);y5=randi(6,6,1);c5=randi(6,6,1);
% Vektoren mit je 6 Zufallszahlen von 1 bis 6
Y6=randi(10,20,20);
% Quadratische Matrix von Zufallszahlen von 1 bis 10
x7=rand(100,1);y7=rand(100,1);
s7=rand(100,1)*100;c7=rand(100,1)*10;
Y8=round(rand(20,20));
%
% Grafische Darstellungen:
%% 
% Teil 1:
subplot(3,3,1) % Unterdiagramm Nr.1 von 1/9
loglog(w,y1),grid on
title('loglog-Diagramm, beide Achsen logarithmisch')
legend('Exponentialfunktion')
subplot(3,3,2) % Unterdiagramm Nr.2 von 1/9
semilogx(w,y1),grid on
title('semilogx-Diagramm, x-Achse logarithmisch')
legend('Exponentialfunktion')
subplot(3,3,3) % Unterdiagramm Nr.3 von 1/9
semilogy(w,y1),grid on
title('semilogy-Diagramm, y-Achse logarithmisch')
legend('Exponentialfunktion')
subplot(3,3,4) % Unterdiagramm Nr.4 von 1/9
stairs(t,y2),grid on, legend('Sinus')
title('stairs - Sinusfunktion als Stufendiagramm')
subplot(3,3,5) % Unterdiagramm Nr.5 von 1/9
contour(y3,10),grid on
title('contour - Isolinien der Funktion peaks')
subplot(3,3,6) % Unterdiagramm Nr.6 von 1/9
ezcontour('sqrt(x^2 + y^2)+sin(x)+sin(y)')
legend('"ez"-Funktion ezcontour')
subplot(3,3,7) % Unterdiagramm Nr.7 von 1/9
bar(Y4),grid on
legend('Würfel 1', 'Würfel 2', 'Würfel 3')
title('Balkendiagramm (senkrecht) der gewürfelten Zahlen 3er Würfel')
subplot(3,3,8) % Unterdiagramm Nr.8 von 1/9
barh(Y4),grid on
legend('Würfel 1', 'Würfel 2', 'Würfel 3')
title('Balkendiagramm (waagrecht) der gewürfelten Zahlen 3er Würfel')
subplot(3,3,9) % Unterdiagramm Nr.9 von 1/9
bar(Y4,'stacked'),grid on,
legend('Würfel 1','Würfel 2','Würfel 3')
title('Balkendiagramm mit aufsummierten Werten')
%% 
% Teil 2:
figure % Neues Grafikfenster
subplot(3,3,1) % Unterdiagramm Nr.1 von 2/9
hist(Y4),grid on,legend('Würfel 1','Würfel 2','Würfel 3')
title('hist - Histogramm der Würfelzahlenverteilung')
subplot(3,3,2) % Unterdiagramm Nr.2 von 2/9
pareto(Y4(:,1)),grid on
title('pareto - sortiertes Balkendiagramm')
legend('Würfelergebnisse')
subplot(3,3,3) % Unterdiagramm Nr.3 von 2/9
e=randi(2,1,63);
errorbar(y2,e),grid on
title('errorbar - Fehlerbalken markieren Konfidenzintervalle')
subplot(3,3,3) % Unterdiagramm Nr.3 von 2/9
stem(Y4(:,1),'fill'),grid on
title('stem - "Stamm mit Blatt" markiert die Würfelzahlen')
subplot(3,3,4) % Unterdiagramm Nr.4 von 2/9
area(Y4),grid on, legend('Würfel 1','Würfel 2','Würfel 3')
title('area - plot-Befehl mit ausgefüllten Flächen unter den Kurven')
subplot(3,3,5) % Unterdiagramm Nr.5 von 2/9
explode=[0 0 0 1 0 0];
pie([1 2 3 4 5 6],explode),grid on
title('pie - Kuchendiagramm mit herausgeschnittenem Stück')
subplot(3,3,6) % Unterdiagramm Nr.6 von 2/9
fill(x5,y5,c5),grid on
title('fill - farbig ausgefüllte Polygone')
subplot(3,3,7) % Unterdiagramm Nr.7 von 2/9
contourf(y3,10),grid on
title('contourf - Isolinien mit ausgefüllten Flächen der Funktion peaks')
subplot(3,3,8) % Unterdiagramm Nr.8 von 2/9
foto=imread('sim09_Katze.bmp');
% Einlesen eines Fotos, unbedingt Semikolon!
image(foto)
title('image - farbige Wiedergabe einer Matrix, z. B. eines Fotos')
subplot(3,3,9) % Unterdiagramm Nr.9 von 2/9
pcolor(Y6),grid on,
colormap bone % Grautöne mit Blaustich
shading flat % Keine schwarzen Linien zwischen Feldern
% Tipp:
% shading interp ausprobieren, d. h. fließende Farbübergänge
title('pcolor - Schachbrettmuster der Daten einer 20x20-Matrix')
colormap hsv
%% 
%Teil 3:
figure % Neues Grafikfenster
subplot(3,3,1) % Unterdiagramm Nr.1 von 3/9
feather(t,y2);grid on
title('feather - Sinusfunktion durch Richtungspfeile dargestellt')
subplot(3,3,2) % Unterdiagramm Nr.2 von 3/9
quiver(t,y2,y2,y2,0);grid on
title('quiver - 3-fach enthaltene Sinusfunktion mit Richtungspfeilen')
% Unterdiagramm Nr.3 von 3/9 folgt am Ende
subplot(3,3,4) % Unterdiagramm Nr.4 von 3/9
polar(t,y2)
title('polar - Sinus in Polarkoordinaten')
subplot(3,3,5) % Unterdiagramm Nr.5 von 3/9
rose(Y4(:,1))
title('rose - Würfelwerte als Winkel ihrer Häufigkeit')
subplot(3,3,6) % Unterdiagramm Nr.6 von 3/9
compass(Y4(:,1),Y4(:,2))
title('compass - Polarkoordinatensystem')
subplot(3,3,7) % Unterdiagramm Nr.7 von 3/9
scatter(x7,y7,s7,c7),grid on
title('scatter - Darstellung der Verteilung von Zufallszahlenpaaren in der x-y-Ebene')
subplot(3,3,8) % Unterdiagramm Nr.8 von 3/9
Y8=round(rand(20,20));
spy(Y8)
title('spy - Darstellung dünnbesetzter Matrizen')
subplot(3,3,9) % Unterdiagramm Nr.9 von 3/9
X9=randi(10,4,3);Y9=randi(10,4,3);
plotmatrix(X9,Y9)
title('plotmatrix - Zufallsverteilung')
% Das Unterdiagramm mit dem comet-Befehl kommt an letzter
% Stelle, da sonst die Kometenbahn überschrieben würde ...
subplot(3,3,3) % Unterdiagramm Nr.3 von 3/9
comet(y2);grid on
title('comet - "Komet" folgt einer Sinuskurve')
% Ende