%% sim08: create your own functions

%% search path
% default search path is the current directory (pwd)
% files in other directories will be found by adjusting the search path 
% addpath('C:\directory\') 
% toolstrip - HOME - set path

%% script

% in a script other scripts can be called
sim07a_vectorizing

%% functions
% can be defined locally at the end of a script or as an external file
% Local functions in the current file have precedence over functions in other files. 

% advantage of function compared to script:
% workspace is not changed
% parameters can bidirectionally be exchanged 

% Advantage of local functions
% if you copy your file you always have all functions needed within
% no extra file needs to be generated for few lines of code

% Advantage of external functions
% Local functions cannot be started with F9 or in the command window
% if you need a function in many files it is easier to keep up to date

clear, clc

% example to calculate mean value and standard deviation
[mw, stdabw]=sim08_statistics(1:10)


%% exercise 8.1 circle
% Write a function that calculates circumference and area of a circle
% when passed the radius

R=1;    % Radius
[circumference,area] = sim08_circle(R)

%% exercise 8.2
% The factorial can also be calculated recursively
% find the error in the function sim08_factorialDB.m by debugging
clear
sim08_factorialDB(10)    % factorial: 4!=1*2*3*4

%% Many Matlab functions are readable m-files

% simple example
open cart2pol
% extensive example
open xlsread

%% anonymous Fkt. for short (single line) functions (at-symbol)
myfkt = @(x) x.^2-1-sqrt(x);  
myfkt(2)
myfkt([1 2 3])   
fplot(myfkt)        % -> sim09_graphics2
x=-1:.01:1;plot(x,myfkt(x))

% multiple arguments for functions are possible
mybetrag = @(a,b) sqrt(a^2+b^2);
mybetrag(3,4)
mybetrag(1:3,2:4)  % vector inputs possible?

% predefined parameters can be used by functions
R=1;
fh = @(x,y) sqrt(x.^2 + y.^2) - R;
ezplot(fh)          % -> sim09_graphics2
axis equal

% deal() can be used to return more than one parameter
f = @(x) deal(x.^2,x.^3);
[a,b]=f(2)

% a function can be defined with other functions
f1 = @(x) sin(x);
f2 = @(x) cos(x);
fmax = @(x) max(f1(x),f2(x)); 
x=0:0.01:6;
plot(x,f1(x)), hold all
plot(x,f2(x))
plot(x,fmax(x),'--')

%% exercise 8.3 parallel circuit
% Write an anonymous function that calculates the total resistance when  
% a) two resistances R1, R2 are connected in parallel. 
% b) all resistances in vector R are connected in parallel. 
% https://en.wikipedia.org/wiki/Series_and_parallel_circuits#Resistance_units_2

% a)  
par1 = @(R1, R2) R1*R2/(R1+R2);
par1(40,120)     % 30

% b)  

par2 = @(R) 1/sum(1./R);

par2([40,120])   % 30
par2(1:100)      % 0.1928


%% exercise 8.4 
% define a rectangular function and a one-way rectified sinus function
% Hint: you can use logical operators <,> (-> sim03)
% to define a function section by section

phi = 0:0.01:20;

rectangle = @(phi) sign(sin(phi));

rectSine = @(phi) (sin(phi)>0).*sin(phi)

figure();
plot(phi, rectangle(phi), 'r-');hold on;
plot(phi, rectSine(phi), 'b-');
hold off;


% --------------------------------------------------------
%% at the end of a script local functions can be defined
% --------------------------------------------------------
function [mw,sta] = sim08_statistics(x)

n = length(x);
mw = sum(x)/n;                  % mean value
sta = sqrt(sum((x-mw).^2/n));   % standard deviation

end

