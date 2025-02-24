%% sim 10 arithmetics 2

%% I polynomials
%% -------------------------------------------------------------------------
clear 
% p(x) = 4x^5+3x^3-7x^2+11
% q(x) = -x^4+ x^3- x
x=linspace(-1,1,50);
p1=4*x.^5+3*x.^3-7*x.^2+11;
q1=-x.^4+x.^3-x;
plot(x,p1,'r',x,q1,'b')
hold on
% coefficient vector is a compact description of a polynomial
p=[4 0 3 -7 0 11];
q=[-1 1 0 -1 0];
% polyval evaluates the polynomial p at each point in x
plot(x,polyval(p,x),'g--',x,polyval(q,x),'y--')

% biggest power to smallest power!

%% Multiplication (conv)

% (x-a)(x+a)=x^2-a^2     for a=2
p1=conv([1 -2],[1 2])
% (x-a)(x-a)=x^2-2ax+a^2 for a=3
p2=conv([1,-3],[1,-3])

% division
% (x^2-4)/(x-2) = x+2 without rest
[x,r]=deconv(p1,[1,-2])

%% exercise 10.1 
% Check with conv the binomial formula
% (a^2*x^2 + sqrt(2)*a*x +1) * (a^2*x^2 - sqrt(2)*a*x +1) = (a*x)^4 + 1
a=3;

p1 = [a^2 sqrt(2)*a 1];
p2 = [a^2 -sqrt(2)*a 1];

left = conv(p1,p2)
right = [a^4 0 0 0 1]

%% Partial fraction decomposition 
% (e.g. tables of integrals or laplace transforms)
clear,clc,clf
format compact
% (x^3 + 2x^2 -25x + 28) / (x^3 -7x^2 + 14x -8)
z=[1 2 -25 28];   % nominator polynomial
n=[1 -7 14 -8];   % denominator polynomial

% finds the residues, poles, and direct term of a Partial Fraction 
% Expansion of the ratio of two polynomials
[r,p,k]=residue(z,n)
% p: poles (denominator) -> valeurs qui annulent les termes en bas
% r: residues (nominator)
% k: direct term (rest)
% = 1 + 4/(x-4) + 3/(x-2) + 2/(x-1)

% converts the partial fraction expansion back to the ratio of two 
% polynomials and returns the coefficients in b and a
[z,n]=residue(r,p,k)

% compare both results graphically
x=linspace(0,5,99);
plot(x,polyval(z,x)./polyval(n,x)), hold on
y=k;
for i=1:length(r)
    y=y+r(i)./(x-p(i));
end
plot(x,y,'r--')
legend('ratio of two polynomials','partial fraction expansion')

%% exercise 10.2
% Find the partial fraction expansion of (x^3+16)/(x^3-4x^2+8x) 
% https://en.wikipedia.org/wiki/Partial_fraction_decomposition#Example_2
p1 = [1 0 0 16];
p2 = [1 -4 8 0];
[r, p, k] = residue(p1, p2)


%% II complex numbers
%% -------------------------------------------------------------------------
clear, clc

sqrt(-1)
% i and j represent the basic imaginary unit
1+i
% better 1i oder 1j (i,j can also obe variables)
z=(1-i)*(2+1j)

% important functions
real (z)    % Realteil
imag(z)     % Imaginärteil
abs(z)      % Betrag
angle(z)    % Phase [rad]

% Complex conjugate
(1+1i)'
% Watch out: ' also transposes a matrix! 
x=[-4 -1 1 4];
sqrt(x)
sqrt(x)'    % transposed and complex conjugated
sqrt(x')    % transposed only
% to avoid confusion use transpose() und conj() instead of '

%% plot with two (complex) arguments
% ignores imaginary part of an argument
x=-3:0.1:10;
plot(x,sqrt(x))


%% plot with a single complex argument 
% plot(z) = plot(real(z), imag(z))

% example: nyquist plot of impedance (R+L) || C
% real coil taking into account resistance and capacitance of winding
clf
f=logspace(0,9,1000);   % log. spaced frequencies from 10^0 to 10^9 Hz 
L=2.5e-3;       % inductance [H]
C=20e-9;        % capacitance [F]
R=250;          % resistance [Ohm]

w=2*pi*f;       % angular frequency [rad/s]
ZL=1j*w*L;      % coil impedance
ZC=1./(1j*w*C); % capacitor impedance
par=@(a,b) a.*b./(a+b);   % parallel connection
Z=par(ZL+R,ZC);  % parallel circuit of ZL and R
plot(Z)
axis equal, grid on
xlabel('real part (resistance)')
ylabel('imaginary part (reactance)')
title('Nyquist plot: impedance of real coil')
hold on
idx=find(f==10000)
plot(Z(idx),'o')

%% exercise 10.3: PT2-element  (LCR resonator, spring-mass-damper-system)
%    http://de.wikipedia.org/wiki/PT2-Glied
% todo: this exercice is false!!

clf
K=1;        % Verstärkungsfaktor / gain
d=0.1;      % Dämpfungsgrad / damping ratio D
T = 1;      % time constant = 1/w0, w0 -> resonnance

% PT2 transfer function
% s = tf('s');
pt2=@(s) 1./(1 + 2*d*T*s + (s*T).^2)

% a) draw a nyquist plot G(s) of PT2-element
%    in the frequency range from 0.01 to 100 rad/s and mark
%    the frequencies w = 0.5, 0.99, 1, 1.1, 2 rad/s

w=logspace(-2,2,5000);
s=1j*w;     % complex frequency

pt2Points = pt2(s);

wHighlight = [0.5 0.99 1 1.1 2];

pt2Highlight = pt2(wHighlight);

plot(pt2Points); hold on;
plot(pt2Highlight, 'ro')
hold off;
axis equal;
grid on;
xlabel('real part (resistance)')
ylabel('imaginary part (reactance)')
title('Nyquist plot PT2')


% b) draw a bode plot of PT2 element
%    in the frequency range from 0.01 to 100 rad/s
% https://en.wikipedia.org/wiki/Bode_plot
H = tf([1], [1 2 1]);
bode(H);
grid on;


%% III calendar functions 
%% -------------------------------------------------------------------------
clear,clc
% calendar
c=clock; % date and time
fprintf('year = %4d, month = %2d, day = %2d: %2d hour %2d min %3.2f sec\n',c)

x=datenum(2011,8,2)   % date -> matlab day number  
datestr(x)            % daynumber -> date
datestr(now)
datestr(0)            % day 0 in matlab 

calendar(1848,3)      % calendar from march 1848

[d,w]=weekday(now)    % weekday

% useful reserved words: now (date and time) and today (only the day)

%% exercise 10.4: how many days to christmas eve?

nbDays = floor(datenum(2024,12,25) - now)






  