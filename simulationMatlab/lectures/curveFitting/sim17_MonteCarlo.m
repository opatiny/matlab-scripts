%% sim 17 MonteCarlo-Simulation

%% Part 1: Random numbers + statistical parameters
clear,clc, clf

% uniformly distributed random numbers between 0 and 1
rand            % 1x1 Matrix 
rand(3)         % 3x3 Matrix like rand(3,3)
rand(3,2)       % 3x2 Matrix

% random numbers between a and b
a=17;b=23;
a + (b - a) * rand(1,50)

% random integers
randi(10)       % 1-10
randi(10,3)     % 3x3 Matrix 1-10
randi(10,3,2)   % 3x2 Matrix 1-10

% normally (Gauss-) distributed random numbers  
% e.g. Measurement error, manufacturing variation
randn           % Mean zero with standard deviation 1 
                
% compare uniformly and normally distributed random numbers
n=1e5;           % number of samples
y1=randn(n,1);   % normally distributed (mean=0)
y2=rand(n,1);    % uniformly distributed (0-1)
subplot(211),histogram(y1,100), title('normally distributed')
subplot(212),histogram(y2,100), title('uniformly distributed')

% mean m and standard deviation s 
m=5;    % mean  
s=2;    % standard deviation
y = m + s.*randn(n,1);
% verify
[mean(y), std(y)]

% the standard deviation describes the width of the distribution
clf
for i=1:3
    s = 4-i;     
    y = m + s*randn(n,1);
    std(y)  % verify standard deviation
    histogram(y), hold on
    leg(i,:)=['\sigma=',num2str(s)];
end
legend(leg)

%% exercise 17.1
% Assume the salary is normally distributed with an average of 4000€ 
% and a standard deviation of 600€. 
% a) Generate salary data for 100.000 people and plot a histogram
% b) Find the percentage p of people who earn less than x. Plot p(x).

clear,clc,clf
n=1e5;
m=4000; % mean salary €
s=600;  % standard deviation

y = m + s*randn(n,1);
hold on;
yyaxis left;
histogram(y);
ylabel('nb people with this salary');
yyaxis right;
plot(sort(y), (1:n)/n*100);
ylabel('% people');
hold off;

%% Pseudo random numbers
clc
s = rng;    % save settings of random number generator
rand(1,5)
rng(s);     % restore settings for same results
rand(1,5)

% initialize random number generator by random seed (current time) 
rng('shuffle'); 

%% Statistics tool
% show in workspace or 
% figure - tools - data statistics 
clear,clc
n=1e2;y=2*randn(1,n);
close all,plot(1:n,y)

% var, std, mode, median
varianz = sum( (y-mean(y) ).^2)/(n-1) 
var(y)
stdabw = sqrt(varianz)
std(y)

mode([1 2 1 3 2 4 2 4 4 5])    % (minimal) most frequent value

% for uniformly distributed samples: mean=median
median([1 2 3 9 99])           % 50% samples below, 50% above median

%% boxplot
% On each box, the central mark indicates the median, and the bottom and
% top edges of the box indicate the 25th and 75th percentiles,
% respectively. Outliers are not considered (-> isoutlier() )

figure(1),clf
load carsmall.mat
boxplot(MPG,Origin)
title('Miles per Gallon by Vehicle Origin')
xlabel('Country of Origin')
ylabel('Miles per Gallon (MPG)')
figure(2),clf
boxplot(MPG,Model_Year)
title('Miles per Gallon by Vehicle Year')
xlabel('Year')
ylabel('Miles per Gallon (MPG)')

%% Stichprobenvarianz
% warum wird bei der Berechnung der Varianz in Zeile 67 
% durch n-1 geteilt, statt durch n
clear,clc
% N normalverteilte Zufallszahlen X (Mittelwert 0, std=3) 
N=1e4;
X = 3*randn(N,1);
% haben die Varianz der Gesamtmenge V=3^2
V = var(X,1)    % sum( (X-mean(X)).^2)/N

% Untersucht man nur die Stichprobe n<N und berechnet daraus die Varianz
n=30;       % Anzahl der Stichproben aus der Gesamtzahl N
wdh=1e5;    % Wiederholungen des Stichprobenexperiments
x=X(randi(N,n,wdh));
vn1=var(x);   % sum( (x-mean(x)).^2)/(n-1)
vn=var(x,1);  % sum( (x-mean(x)).^2)/n
[mean(vn) mean(vn1)]
% so kommt man mit dem Nenner n-1 im Mittel eine bessere Schätzung für die
% Varianz der Gesamtmenge N

%% put a list in a random order
% e.g. shuffel a card game

n=10;
x=rand(1,n);
[~, liste]=sort(x)

% or (does not allow vector arguments )
randperm(n)

%% Latin Hypercube Design of Experiments (DOE)
% https://www.wikiwand.com/en/Latin_hypercube_sampling
clear,clc
n=7;

% 2D
x=lhsdesign(n,2,'smooth','off')*n;
figure(1)
plot(x(:,1),x(:,2),'x')
grid on, xticks(0:n)
axis([0 n 0 n]) 
axis square

% 3D
x=lhsdesign(n,3,'smooth','off')*n;
figure(2)
plot3(x(:,1),x(:,2),x(:,3),'x')
grid on 
xticks(0:n), yticks(0:n), zticks(0:n)
axis([0 n 0 n 0 n]) 
axis square




%% Part 2: Monte-Carlo-Simulation
% http://de.wikipedia.org/wiki/Monte-Carlo-Simulation
% Monte Carlo methods are a broad class of computational algorithms that 
% rely on repeated random sampling to obtain numerical results. 
% The underlying concept is to use randomness to solve problems that 
% might be deterministic in principle.


%% example 1: calculation of pi
% You can determine the area of a circle by randomly choosing n points in
% a square and checking whether they are inside or outside the
% circle. The higher the number of random points, the better 
% is the estimation of pi

clear,clc, clf
format compact
for i=2:6
    n=10^i;
    x=rand(1,n);
    y=rand(1,n);
    idx = (x.^2+y.^2)<=1;
    plot(x,y,'b.'), hold on
    plot(x(idx),y(idx),'r.'),axis equal tight
    mypi = 4*sum(idx)/n;
    sprintf('Pi = %f (error: %3.2f%%)',mypi,(mypi-pi)/pi*100)
    pause
end

%% example 2: probabilities at game of dice
% sum of dots with two dice
clear,clc,clf
n=1e4;                  % number of throws

x=randi(6,n,2);         % mit zwei Würfeln n mal würfeln
xs=sum(x,2);            % sum of dots
% a) absolute frequency
subplot(211), histogram(xs)
xlabel('sum of dots')
ylabel('absolute frequency')
axis tight

% b) realtive frequency
subplot(212), histogram(xs,'Normalization','probability')
ylabel('relative frequency [%]')
axis tight


%% example 3: Manufacturing variation
% Material and geometry parameters of components have tolerances
% From this, the distribution of the target specification can be calculated
% and the most influencing parameters can be determined
% Example: round beam, clamped on one end, normal force (5% tolerance) on 
% the other end. Calculate the variation of deflection if 
% geometry and material parameters are normally distributed. 

clear,clc,clf
n=10000;            % number of samples

% Parameter
F=600;              % force 
R=0.02;             % beam radius  
Emod=185e9;         % E-Modul
l=1;                % beam length

I=pi*R.^4/4;        % area moment of inertia
% calculate deflection without tolerances
dy0 = F.*l.^3./(3*Emod.*I);

% taking tolerances into account
tol=0.05;   % force tolerance: +/- 5%
F = F*(1-tol + 2*tol*rand(n,1));
%  standard deviation of R, Emod, l is 5%
s=0.05;  
R=R*(1+s*randn(n,1));       
Emod=Emod*(1+s*randn(n,1)); 
l=l*(1+s*randn(n,1));       

I=pi*R.^4/4;             
dy = F.*l.^3./(3*Emod.*I);
histogram(dy), hold on
plot([1 1]*dy0,[0 700])
plot([1.2 1.2]*dy0,[0 700],'r')
plot([0.8 0.8]*dy0,[0 700],'r')
xlabel('displacement')



%% exercise 17.2 card game
% I draw 13 cards from a french card game with 4·13=52 cards.
% 2,3,4,5,6,7,8,9,jack,queen,king,ace
% 
% a) What is the probability that I have got at least two aces? 
% 
clear,clc
n=1e5;  % number of games
ak=52;  % number of cards
gk=13;  % drawn cards
nAss=4; % number of aces (ace if x = 1-4)

% shuffel n games
[~,x] = sort(rand(ak,n));   
% at least two aces
aa=sum(x(1:gk,:)<=nAss);        % number of aces drawn
n2=sum(aa>=2);                  % at least two aces?
p=n2/n                          % probability p: good games/all games

% Does p change if I admit to have
% b) at least one ace
% c) at least ace of hearts



%% Denkfalle bedingte Wahrscheinlichkeit

% Inzidenz 1000: (1% sind erkrankt)
% Sensitivität Schnelltest
% 97% mit der Infizierten werden erkannt
% 97% der Gesunden werden erkannt
% Sie werden positiv getestet. 
% Mit welcher Wahrscheinlichkeit sind Sie infiziert?

%% Monty Hall Problem

% Hinter einem von drei Toren steht ein Auto
% In der Hoffnung, das Auto zu gewinnen, wählt der Kandidat Tor 1. 
% Der Showmaster öffnet daraufhin Tor 3, das leer ist, 
% und bietet dem Kandidaten an, das Tor zu wechseln. 
% Ist es vorteilhaft für den Kandidaten, seine erste Wahl zu ändern 
% und sich für Tor 2 zu entscheiden? 
% https://en.wikipedia.org/wiki/Monty_Hall_problem
