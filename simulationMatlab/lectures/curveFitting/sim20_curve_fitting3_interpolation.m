%% Interpolation
% interpolation curve intersects exactly at data points

%% 1D

%% Interpolation with global polynomial functions
% n data points can be fitted exactly by a polynomial (n-1)th degree  
% but there may be unwanted overshoots, which usually
% increase with the polynomial degree.

% http://en.wikipedia.org/wiki/Runge%27s_phenomenon
clear, clf, clc
x0=linspace(-3,3);
y=@(x) 1./(1+25*x.^2);
plot(x0,y(x0),'k','LineWidth',2), hold on
title('y = 1/(1+25*x^2)')

pg=8:4:16;      % polynomial degree
c='gbr';        % color vector
for i=1:length(pg)
    x=linspace(-3,3,pg(i)+1);
    p=polyfit(x,y(x),pg(i));    % polynomial interpolation
    h(i)=plot(x0,polyval(p,x0),c(i));
    plot(x,y(x),['o',c(i)]);
    axis manual     % freeze axis scale
    % only show legend for plots in handle h
    legend(h,num2str(pg(1:i)')) 
    pause           % wait for key
end

%% Interpolation with local (between two data points) polynomial functions
% Splines nth degree

clear,clc,clf
x=[3 4.5 7 9];
y=[2.5 1 2.5 0.5];
xx=linspace(x(1),x(end));
h(1)=plot(x,y,'ko'); hold on

% Spline 1. degree: line y=a*x+b
% 2 data points, 2 unknown parameters a,b -> unique solution
% Disadvantage: Function not differentiable
ys1=interp1(x,y,xx,'linear');   % linear = default
h(2)=plot(xx,ys1,'k');
% plot command applies linear interpolation

% Spline 2. degree: parabola y = a + b*x + c*x^2
% three parabolas are searched -> 3*3 = 9 parameters
% One parabola must intersect with each boundray node and both other 
% nodes must intersect with two parabolas -> 2+2*2=6 equations
% The slope of adjacent parabolas must be equal -> 2 equations
% 1 equation is missing -> here: Initial curvature=0 (arbitrary condition)
% Disadvantage: Asymmetry, function 1x, but not 2x differentiable
dx=diff(x);dy=diff(y);
% there is no matlab command for second degree splines 
% The parameters are determined by a system of equations
syms b1 b2 b3 c1 c2 c3
% parabolas start at nodes -> ai=yi
[b(1),b(2),b(3),c(1),c(2),c(3)]= solve(c1==0,... % curvature of first parabola = 0
    b1+2*dx(1)*c1==b2, b2+2*dx(2)*c2==b3, ...    % 1st derivative identical
    b1*dx(1)+c1*dx(1)^2==dy(1), b2*dx(2)+c2*dx(2)^2==dy(2), b3*dx(3)+c3*dx(3)^2==dy(3));
s=@(a,b,c,x0,x) a+b*(x-x0)+c*(x-x0).^2;
for i=1:3
    xi=linspace(x(i),x(i+1));
    h(3)=plot(xi,s(y(i),eval(b(i)),eval(c(i)),x(i),xi),'g');
end

% cubic spline: cubic polynomial y=a*x^3+b*x^2+c*x+d
% three polynomials of 3rd order are searched -> 3*4 = 12 parameters
% One cubic polynomial must intersect with each boundray node and both other 
% nodes must intersect with two cubic polynomials -> 2+2*2=6 equations
% Slope and curvature of adjacent cubic polynomial must be equal -> 4 equations
% 2 equations are missing -> e.g. slope at the edge 
ys3c = spline(x,[0 y 0],xx);  % clamped
h(4)=plot(xx,ys3c,'r');

% or default:  3. derivative on the nodes next to the boundary nodes are equal 
ys3=interp1(x,y,xx,'spline');
h(5)=plot(xx,ys3,'b');
% Advantage: symmetry, 2x differentiable

% cubic splines with four nodes is equivalent to polynomial intepolation
p = polyfit(x,y,3);
h(6)=plot(xx,polyval(p,xx),'c--');
legend(h,'Data','linear','spline2','spline3c','spline3','poly')


%% Other approximation functions in matlab
clear,clc,clf
% You perform a test drive on an automobile where you alternately
% accelerate the automobile and then hold it at a steady velocity.
% Note that you never decelerate during the experiment.
% The time series of spot measurements of velocity can be tabulated as
% -> best one is pchip
x = [0 20 40 56 68 80 84 96 104 110];
y = [0 20 20 38 80 80 100 100 125 125];
x2 = linspace(0,110);
yl = interp1(x,y,x2);
subplot(221),plot(x,y,'o',x2,yl), title('linear')
yn = interp1(x,y,x2,'nearest');
subplot(222),plot(x,y,'o',x2,yn), title('nearest')
ys = interp1(x,y,x2,'spline');
subplot(223),plot(x,y,'o',x2,ys), title('spline')
yh = interp1(x,y,x2,'pchip');
subplot(224),plot(x,y,'o',x2,yh), title('pchip')

 % pchip: Piecewise cubic Hermite interpolation
 % Only 1x differentiable, but shape preserving, no overshoot
 
 % Since 2017b there is also makima interpolation (between pchip and spline)

%% exercise 20.1: Sinus interpolation
% try all four approximation functions 
% try n=6 and n=7 interpolation nodes
clear, clf, clc
n=7; % nb data points
x = linspace(0,2*pi,n); 
fun = @(x) sin(x); 
y = fun(x);

x2 = linspace(0,2*pi,1000);
y2 = fun(x2);

yl = interp1(x,y,x2);
subplot(221),plot(x,y,'bo',x2,y2,'b-',x2,yl,'r-'), title('linear')
yn = interp1(x,y,x2,'nearest');
subplot(222),plot(x,y,'bo',x2,y2,'b-',x2,yn,'r-'), title('nearest')
ys = interp1(x,y,x2,'spline');
subplot(223),plot(x,y,'bo',x2,y2,'b-',x2,ys,'r-'), title('spline')
yh = interp1(x,y,x2,'pchip');
subplot(224),plot(x,y,'bo',x2,y2,'b-',x2,yh,'r-'), title('pchip')

%% exercise 20.2
% In a moving object there are two sensors.
% one measures x(t) the other y(t) at various times t 
% sim20_dataX.txt     t, x(t)
% sim20_dataY.txt     t, y(t)
% Plot the trajectory x(y) of the object 
% hint: for a reasonable plot x,y need the same time base

dataX = load('data/sim20_dataX.txt');
tx = dataX(:,1);
x = dataX(:,2);

dataY = load('data/sim20_dataY.txt');
ty = dataY(:,1);
y = dataY(:,2);

yInterpolated = interp1(ty,y,tx);

plot(x, yInterpolated);

%% Fourier interpoltion for periodic function (based on FFT)
clear,clc,clf
% original signal with fine sampling
y=@(x) sin(2*pi*x)+sin(2*pi*5*x);
n=1000;      
ts=1/n;      
x = 0:ts:(n-1)*ts;
plot(x,y(x),'k'), hold on

% low sampling rate
n1=12;   % Test n1=9 below Nyquist limit
ts1=1/n1;               % sampling time
x1 = 0:ts1:(n1-1)*ts1;  
plot(x1,y(x1),'ko')

% Spline interpolation
yspline = interp1(x1,y(x1),x,'spline');
plot(x,yspline,'b-')
% Fourier interpolation
yinterpft=interpft(y(x1),n);
plot(x,yinterpft,'r--');

legend('original','samples','spline','interpft')
ylim([-2.5,2.5])

%% fill missing data  

figure(1),clf
x = [-4*pi:0.1:0, 0.1:0.2:4*pi];
A = sin(x);
A(A < 0.75 & A > 0.5) = NaN;    % missing data
[F,idx] = fillmissing(A,'linear','SamplePoints',x);
plot(x,A,'.', x(idx),F(idx),'o')
xlabel('x');
ylabel('sin(x)')
legend('Original Data','Filled Missing Data')

%% 2D interpolation

%% generate more data in 2D space
clear, clf, clc

% coarse grid
v1=-3:.5:3;
[X,Y] = meshgrid(v1);
Z = peaks(X,Y);
plot3(X,Y,Z,'k.'), hold on
surf(X,Y,Z), hold off
legend('measured data')

% fine grid
v2=-3:0.1:3;
[XI,YI] = meshgrid(v2);
% interpolate original data X,Y,Z on fine grid XI,YI
ZI = interp2(X,Y,Z,XI,YI,'spline');
plot3(X,Y,Z,'k.','MarkerSize',12), hold on
surf(XI,YI,ZI)
hold off
legend('measured data')

%% exercise 20.3 cut line
% The plot shows the contour lines of the given function Z(X,Y).
% Plot the function along the black line

clear, clf, clc

x=3:-.01:-3;
a=1;
[X,Y]=meshgrid(x);
Z=100*(Y-X.^2).^2+(a-X).^2;
contour(X,Y,Z,0:50:1000)
hold on; colorbar;grid on;
x1=-1:0.1:2;
y1=2-x1;
plot(x1,y1,'k')
hold off;

zi = interp2(X,Y,Z,x1,y1);
plot(x1,zi)

%% interp2 needs regular grids
% alternative griddata(xv,yv,zv,gvx,gvy)
% generates from any data vector x,y,z
% the data values on the grid spanned by gvx, gvy

clear,clf;
v1=-3:0.5:3;
[X,Y] = meshgrid(v1);
n=floor(0.3*numel(X));    % delete 30% of the data
x=randi(numel(X),n,1);    % this is done by random selection
X(x)=[];Y(x)=[];Z = peaks(X,Y);
plot3(X,Y,Z,'k.'), hold on
v2=-3:0.125:3;
[XI,YI,ZI] = griddata(X,Y,Z,v2,v2','cubic')
mesh(XI,YI,ZI)


%% exercise 20.4 
% find the 10 missing table entries 
% in sim20_Table2D.xls by interpolation
% the coordinates are in the first row or column.
% a) Visualize the original data with surf
% b) interpolate missing data
% c) visualize interpolated data with surf
% Hint: 
% NaN entries have to be filtered or deleted for the griddata command 
% The isnan() command is useful for this.

clear,clc,clf

data = xlsread('data/sim20_Table2D.xls');
% a)
surf(data);

% b)
indices = find(isnan(data));
data(indices) = 0
surf(data)


