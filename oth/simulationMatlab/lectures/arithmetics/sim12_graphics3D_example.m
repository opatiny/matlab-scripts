% Grafik 3D
% Quelle: Angelika Bosl, "Einführung in Matlab/Simulink", Hanser Verlag 
% Grafikbeispiele im dreidimensionalen Bereich
%
%%
% Definition der verwendeten Vektoren und Matrizen_
x1=linspace(0,10,100);y1=sin(x1);z1=x1.^2;
Z2=peaks(20);
Y3=randi(6,12,5);
x4=randi(10,5,5);y4=randi(10,5,5);z4=randi(10,5,5);c4=randi(10,5,5);
x5=rand(20,1);y5=rand(20,1);z5=rand(20,1);
s5=100*rand(20,1);c5=10*rand(20,1);
%
% Grafische Darstellungen:
%% Grafiken - Teil 1
subplot(3,3,1) % Unterdiagramm Nr.1 von 1/9
plot3(x1,y1,z1),grid on
title('plot3 - dreidimensionale Kurve')
subplot(3,3,2) % Unterdiagramm Nr.2 von 1/9
contour3(Z2,20),grid on
title('contour3 - 3D-Diagramm von Isolinien der Funktion peaks')
subplot(3,3,3) % Unterdiagramm Nr.3 von 1/9
waterfall(Z2),grid on
title('waterfall - "Wasserfalldiagramm der Funktion peaks')
subplot(3,3,4) % Unterdiagramm Nr.4 von 1/9
mesh(Z2),grid on
title('mesh - 3D-Maschengitternetzlinien der Funktion peaks')
subplot(3,3,5) % Unterdiagramm Nr.5 von 1/9
meshc(Z2),grid on
title('meshc - 3D-Maschengitternetzlinien + Isolinien')
subplot(3,3,6) % Unterdiagramm Nr.6 von 1/9
meshz(Z2),grid on
title('meshz - 3D-Maschengitternetzlinien + Schnittebenen')
subplot(3,3,7) % Unterdiagramm Nr.7 von 1/9
bar3(Y3),grid on
title('bar3 - Balkendiagramm (senkrecht) der gewürfelten Zahlen v. 5 Würfeln')
subplot(3,3,8) % Unterdiagramm Nr.8 von 1/9
bar3h(Y3),grid on
title('bar3h - Balkendiagramm (waagrecht) der gewürfelten Zahlen v. 5 Würfeln')
subplot(3,3,9) % Unterdiagramm Nr.9 von 1/9
bar(Y3,'stacked'),grid on
title('bar ("stacked") - Balkendiagramm mit aufsummierten Werten')
%
%% Grafiken - Teil 2
figure % Neues Grafikfenster
subplot(3,3,1) % Unterdiagramm Nr.1 von 2/9
stem3(x1,y1,z1),grid on
title('stem3 - 3D-"Stieldiagramm", gleiche Funktion wie plot3')
subplot(3,3,2) % Unterdiagramm Nr.2 von 2/9
explode=[0 0 0 1 0 0];
pie3([1 2 3 4 5 6],explode),grid on
title('pie3 - 3D-Kuchendiagramm')
subplot(3,3,3) % Unterdiagramm Nr.3 von 2/9
e=randi(2,1,63);
fill3(x4,y4,z4,c4),grid on
title('fill3 - Ausgefüllte Polygone im 3D-Bereich')
subplot(3,3,3) % Unterdiagramm Nr.3 von 2/9
patch(x4,y4,c4),grid on
title('patch - Ausgefüllte Polygone, ähnlich zu fill3')
subplot(3,3,4) % Unterdiagramm Nr.4 von 2/9
cylinder(5),grid on
title('cylinder - Zylinder mit Radius r=5')
subplot(3,3,5) % Unterdiagramm Nr.5 von 2/9
ellipsoid (5,5,5,4,3,2,30),grid on,axis equal
title('ellipsoid - Ellipsoid aus 30x30 Teilflächen')
subplot(3,3,6) % Unterdiagramm Nr.6 von 2/9
sphere(30), axis equal
title('sphere - Kugel aus 30x30 Teilflächen')
subplot(3,3,7) % Unterdiagramm Nr.7 von 2/9
surf(Z2),grid on
title('surf - Oberfläche der Funktion peaks')
subplot(3,3,8) % Unterdiagramm Nr.8 von 2/9
surfl(Z2),grid on
colormap gray,shading interp
% Grautöne, weiche Farbübergänge
title('surfl - Oberfläche mit Lichteffekten')
subplot(3,3,9) % Unterdiagramm Nr.9 von 2/9
surfc(Z2),grid on,shading flat % keine Farbübergänge
colormap hsv
title('surfc - Oberfläche mit darunterliegenden Isolinien')
colormap hsv
%
%% Grafiken - Teil 3
figure % Neues Grafikfenster
subplot(3,3,1) % Unterdiagramm Nr.1 von 3/9
quiver3(x4,y4,z4,x4,y4,z4),grid on,box on,axis tight
title('quiver3 - zufällig verteilte Pfeile im 3D-Bereich')
% Das Unterprogramm Nr.2 von 3/9 ist am Schluß
subplot(3,3,3) % Unterdiagramm Nr.3 von 3/9
scatter3(x5,y5,z5,s5,c5),grid on,box on
title('scatter3 - Darstellung der Verteilung von Zufallszahlen')
subplot(3,3,4) % Unterdiagramm Nr.4 von 3/9
load wind % von MATLAB gespeicherte Winddaten werden geladen
geschwind = sqrt(u.*u + v.*v + w.*w);
daspect([1 1 1]); % Besser erst DataAspectRatio definieren
[A kreuz] = reducepatch(isosurface(x,y,z,geschwind,30),.2);
% Anzahl der Teilflächen A und Kreuzungspunkte kreuz wird reduziert
h=coneplot(x,y,z,u,v,w,kreuz(:,1),kreuz(:,2),kreuz(:,3),2);
grid on, view(3) % 3D-Ansicht des Diagramms wird aktiviert
axis tight; box on
% Achsen werden auf Minmum begrenzt, Kasten um Diagramm
title('coneplot - Kegel, die Windrichtung und -stärke verdeutlichen')
% Tipp: Product Help liefert besseres farbenfrohes Beispiel
subplot(3,3,5) % Unterdiagramm Nr.5 von 3/9
% Voraussetzung: Daten von wind.mat wurden bereits geladen!
[sx,sy,sz] = meshgrid(80,20:10:50,0:5:15);
h = streamline(x,y,z,u,v,w,sx,sy,sz);
grid on, view(3), axis tight, box on
title('streamline - Strömungslinien z. B. von Winddaten')
subplot(3,3,6) % Unterdiagramm Nr.6 von 3/9
daspect([1 1 1]) % Besser erst DataAspectRatio definieren
streamribbon(x,y,z,u,v,w,sx,sy,sz);
view(3) % 3D-Ansicht aktivieren
grid on,box on,axis tight % Achsen begrenzen
shading interp; % Fliessende Farbübergänge
title('streamribbon - Strömungen in Form von Bändern')
subplot(3,3,7) % Unterdiagramm Nr.7 von 3/9
daspect([1 1 1]) % Besser erst DataAspectRatio definieren
streamtube(x,y,z,u,v,w,sx,sy,sz);
view(3) % 3D-Ansicht aktivieren
grid on,box on,axis tight % Achsen begrenzen
shading interp; % Fliessende Farbübergänge
title('streamtube - Strömungen in Form von Röhren')
subplot(3,3,8) % Unterdiagramm Nr.8 von 3/9
daspect([1 1 1]) % Besser erst DataAspectRatio definieren
streamslice(x,y,z,u,v,w,[],[],[5])
axis tight
title('streamslice - Strömungen in Schnittebenen')
% Tipp: Product Help liefert eindrucksvolleres, komplexes Beispiel
% Das Unterdiagramm mit dem comet-Befehl kommt an letzter
% Stelle, da sonst die Kometenbahn überschrieben würde ...
subplot(3,3,2) % Unterdiagramm Nr.2 von 3/9
comet3(x1,y1,z1,0.9); grid
title('comet3 - "Komet" folgt eine Sinus-Kurve')
% Ende