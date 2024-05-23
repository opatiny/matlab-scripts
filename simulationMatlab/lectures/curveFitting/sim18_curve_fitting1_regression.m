%% Curve fitting 
% to adjust parameters to measured data
% to find intermediate data points
% to find a simple analytic expression

% rule of thumb
% data basis uncertain -> Regression
% data basis certain -> Interpolation

%% Regression
% curve approximates data points

%% Polynomial fit

clear, clc, clf
% Noisy measured values
x=0:0.5:5;
y=[ 0.63 0.05 0.76 1.82 2.19  4.15 6.32 7.90 9.91 9.57 6.4568];
plot(x,y,'ro');hold on

% Polynomial fit nth degree
n=3;                % degree
p=polyfit(x,y,n)    % find fit function
% plot with more sample points
x1=0:0.01:5;   
plot(x1,polyval(p,x1),'b')

%% exercise 18.1 approximate sinus
% a) Draw a polynomial fit of 2nd-5th degree for the sinus fct. (=original).
% and draw in another plot the deviation: original-approximation
% b) Calculate for each fit the mean and the maximum deviation
% and with norm() the root mean square value (RMS) of the deviation
%    http://de.wikipedia.org/wiki/Quadratisches_Mittel

clear, clf
x=linspace(0,pi/2,99);
y=sin(x);

degs = 2:5;

regs = [];
errors = [];

for deg=degs
    p = polyfit(x,y,deg);
    reg = polyval(p,x);
    regs = [regs; reg];
    error = abs(y - reg);
    errors = [errors; error];
    
    minimum = min(error);
    maximum = max(error);
    rms = sqrt(sum(error.^2)/length(error));
    
    fprintf('Polynom degree %i: min %f, max %f, rms %f\n', i, minimum, maximum, rms);
end

subplot(1,2,1);
plot(x,[y; regs]);
subplot(1,2,2);
semilogy(x, errors);
legend('2','3','4','5');


%% The error norm alone is not informative! 
clear,clc,clf
% https://de.wikipedia.org/wiki/Anscombe-Quartett
% all data sets have the same compensation line and 
% the same error norm

data = [ 
% x1    y1      x2      y2      x3      y3      x4      y4
10.0 	8.04 	10.0 	9.14 	10.0 	7.46 	8.0 	6.58;
8.0 	6.95 	8.0 	8.14 	8.0 	6.77 	8.0 	5.76;
13.0 	7.58 	13.0 	8.74 	13.0 	12.74 	8.0 	7.71;
9.0 	8.81 	9.0 	8.77 	9.0 	7.11 	8.0 	8.84;
11.0 	8.33 	11.0 	9.26 	11.0 	7.81 	8.0 	8.47;
14.0 	9.96 	14.0 	8.10 	14.0 	8.84 	8.0 	7.04;
6.0 	7.24 	6.0 	6.13 	6.0 	6.08 	8.0 	5.25;
4.0 	4.26 	4.0 	3.10 	4.0 	5.39 	19.0 	12.50;
12.0 	10.84 	12.0 	9.13 	12.0 	8.15 	8.0 	5.56;
7.0 	4.82 	7.0 	7.26 	7.0 	6.42 	8.0 	7.91;
5.0 	5.68 	5.0 	4.74 	5.0 	5.73 	8.0 	6.89];

for i=1:4
    x=data(:,2*i-1);
    y=data(:,2*i);
    subplot(2,2,i)
    [p, S]=polyfit(x,y,1);
    plot(x,polyval(p,x)), title(S.normr), hold on
    legend(sprintf('y = %3.1f*x + %1.0f',p(1),p(2)),'Location','NorthWest')
    plot(x,y,'*')
end



%%  Polynomial is badly conditioned
clear, clf, clc
t = 1920:10:1990; % year
% US population in millions
% http://en.wikipedia.org/wiki/Demographics_of_the_United_States
pop = [106.02 123.20 132.17 151.33 179.32 203.21 226.55 248.71];
plot(t,pop,'ok'),hold on

% plot with more time samples
tt=linspace(t(1),t(end));  

pg=7;           % degree of polynomial
[p, S] = polyfit(t,pop,pg);
plot(tt,polyval(p,tt),'b')


% Warning: system of equation is badly conditioned.
% -> Normalize and center the sample points
% f=@(x) (x - mean(x))/std(x);    % norming
% p = polyfit(f(t),pop,pg);       
% -> doc polyfit 
[p,S,mu] = polyfit(t,pop,pg);
plot(tt,polyval(p,tt,[],mu),'r.');

% makes very little difference in this case

%% exercise 18.2 Extrapolation
% Draw the 2nd-5th degree polynomial fit for the population data t,pop
% and extrapolate to the period from 1910 to 2000.
% Which polynomial degree seems realistic?

tt=1910:2000
for i=2:5
    p = polyfit(t,pop,i);
    hold on;
    plot(tt,polyval(p,tt));
    hold off;
end
legend('points','more samples','7','2','3','4','5');
% todo: fix legend

%% How does polyfit work?
clear,clc,clf
% example: 1st degree polynomial (straight line) through two points
x=[1;4];
y=[2;6];
plot(x,y,'o');hold on; grid on

% Two equations, two unknowns
% y1 = a*x1 + b
% y2 = a*x2 + b
% -> unique solution

% linear approximation function: y=a1*x^1 + a2*x^0 = a*X
X=[x.^1 x.^0];
% solve for parameter vector a
a=X\y
xx=linspace(0,5,10);
plot(xx,a(1)*xx + a(2));    % plot(xx,polyval(a,xx));    
% verify with polyfit
polyfit(x,y,1)

%% system of equations without unique solution
% then an optimal approximate solution is found, so that the sum of the
% error squares becomes minimal
% e.g. straight line through 3 points
clear,clf
x=[1;4;3];
y=[2;6;4];
plot(x,y,'o');hold on;grid on

% linear approximation function: y=a1*x^1 + a2*x^0 = a*X
X=[x.^1 x.^0];
% solve for parameter vector a
a=X\y
% verify with polyfit
p=polyfit(x,y,1)

xx=linspace(0,5,10);
plot(xx,polyval(a,xx)); 
% or plot(xx,a(1)*xx + a(2))
% or plot(x,X*a,'r--'); 

%% approximating polynomial can be adjusted
% e.g. force intersection with origin -> x.^0 not applicable: X=[x.^2 x.^1]
% e.g. only even polynomial factors: X=[X.^4 x.^2]

%% Is the found straight line y=1.28x+0.57 really the one with the smallest error?
% plot error norm for all lines: y=a*x+b und a=[0,2], b=[0,2]
figure
[a1, a2]=meshgrid(0:0.01:2, 0:0.01:2);
abw=a1;
for i=1:numel(a1)
    abw(i)=norm(polyval([a1(i) a2(i)],x)-y);
end
contour(a1,a2,abw,0:0.1:2) 
colorbar;grid on; hold on
% surfc(a1,a2,abw) ; hold on    
plot(a(1),a(2),'*')

%% Polynomials are not always good approximating  functions
clear,clc,clf
% data of an exponential curve
a=.1;b=2;
x=linspace(0,5,999);
y=a*exp(b*x);
plot(x,y); hold on

% Polynomial fit of 7th degree looks
p1=polyfit(x,y,7);
% good on globale scale ...
plot(x,polyval(p1,x),'r--'),hold off


% ... but using zoom ...
plot(x,y,x,polyval(p1,x),'r--'),ylim([0,20])
% ... or log scale ... 
semilogy(x,y,x,polyval(p1,x),'r--');
% ... not any more

%% exp-fct can be converted to polynomial by log-fct
%    y  = a*exp(b*x)
% log(y)= log(a) + b*x
p2=polyfit(x,log(y),2)  % linear is sufficient
semilogy(x,y,x,exp(polyval(p2,x)),'r--')

%% Fit of any nonlinear functions
% lsqcurvefit (optimization toolbox)

% example: aperiodic limit PT2
% http://de.wikipedia.org/wiki/PT2-Glied#Sprungantwort
% y(t) = K*( 1 - (1+t/T)*exp(-t/T) )
clear,clc,clf
% measured data
x=[0.1000    0.4500    0.8000    1.1500    1.5000];
y=[0.0544    0.6496    0.9500    1.0077    1.0412];

% aperiodic limit PT2
f=@(p0,x) p0(1)*(1-(1+x/p0(2)).*exp(-x/p0(2)));
p0=[0,1];   % guess initial value
% p1 is the solution with minimum sum of squared errors (sse)
[p1, sse]=lsqcurvefit(f,p0,x,y)
x1=linspace(0,1.5);
plot(x,y,'o',x1,f(p1,x1))

% How does lsqcurvefit work?  ... fminsearch
fopt=@(p0) sum((f(p0,x)-y).^2) ;
% Summe der Fehlerquadrate wird minimiert
[p2, sse]=fminsearch(fopt,p0)

% alternative command: lsqnonlin
% equation f(x)-y=0 instead y=f(x)
f1=@(p0) f(p0,x)-y;
[p2,resnorm] = lsqnonlin(f1,p0)

%% exercise 18.3 Population development in the USA
% Visualize the data and the fit curves in the extended data area. 
% Approach 1: y=a*exp(b*x)
% Use a) polyfit and b) lsqcurvefit
% Approach 2: polynomial of nth Degree 
% Approach 3: y=a*(x-b)^c
% Which approach seems most appropriate? 
% For a better assessment, draw the population axis linearly and logarithmically.
clear, clc, clf

load census
x = cdate;
y = pop;

% extended data area: more samples + extrapolation
x1=1762:2020;

plot(x, y, '.');
grid on;

% 1.a)
p = polyfit(x,log(y),1);
hold on;
plot(x1, exp(polyval(p,x1)))
hold off;

% 1.b)
fun = @(p,x) p(1).*exp(p(2).*x);
p0 = [0,0.015];
optParams = lsqcurvefit(fun, p0, x, y);

hold on;
plot(x1, fun(optParams,x1));
hold off;

% 2)
p = polyfit(x,y,2);

hold on;
plot(x1, polyval(p,x1));
hold off;

% 3)
fun =@(p,x) p(1).*(x-p(2)).^p(3)
p0 = [0 1790 1];
optParams = lsqcurvefit(fun, p0, x, y);

hold on;
plot(x1, fun(optParams,x1));
hold off;

legend('data', 'exp polyfit', 'lsqcurvefit 1b', 'poly deg 2',...
       'lsqcurvefit 3','Location', 'northwest');


%% curve fitting tools
clear,clc,clf
% measured data
x=[0.1000    0.4500    0.8000    1.1500    1.5000];
y=[0.0544    0.6496    0.9500    1.0077    1.0412];
plot(x,y,'o')
% without toolbox: Plot-Tools-Basic fitting


% with curve fitting toolbox: app "Curve Fitting"
cftool
% without GUI: fit() function
fit(x',y', 'K*( 1 - (1+x/T)*exp(-x/T) )','Startpoint',[0 1]) 
% -> this is faaaaancy
