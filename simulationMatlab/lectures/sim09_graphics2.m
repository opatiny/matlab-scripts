%% more plot commands for 1D-data

%% default color order, autoUpdate

% problem 1: sine curves with offset should not show up in legend
% problem 2: sine curves with offset, but same phaseshift, differ in color  

clf,clc
phi=linspace(0,360);
phiv=(0:7)*15;
for i=1:length(phiv)
    phi0=phiv(i);
    plot(phi,sind(phi-phi0));
    hold on
end
grid on
legend(num2str(phiv'))

% solution 1: 'AutoUpdate','off': additional plots do not show in legend  
% legend(num2str(phiv'),'AutoUpdate','off')

% solution 2: restart color order
% set(gca,'ColorOrderIndex',1);
for i=1:3
    phi0=phiv(i);
    plot(phi,1+sind(phi-phi0),'--');
    hold on
end

%% colors with names
clf
c='rgbckm';     % colorvector
phi=linspace(-pi,pi);
phiv=(1:6)*pi/3;
for i=1:length(phiv)
    phi0=phiv(i);
    plot(phi,sin(phi+phi0),c(i));
    hold on
end
legend(num2str(180/pi*phiv'))


% set axis location to origin
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
% back to default setting
set(gca, 'XAxisLocation', 'default', 'YAxisLocation', 'default')

% draw axis manually
xline(0,'k-','y-Achse','LineWidth',2)
yline(0,'k-','x-Achse','LineWidth',2)

%% define colors manually
clf
% default color order (rgb)
c=colororder

phi=linspace(0,2*pi);
phiv=(1:7)*pi/4;
for i=1:length(phiv)
    phi0=phiv(i);
    plot(phi,sin(phi+phi0),'color',c(i,:));
    hold on
end
legend(num2str(180/pi*phiv'))

% flip colororder
% colororder(flipud(colororder))

%% Home/Community/Fileexchange
clf
% example: How do I find the RGB colorvector?
plot(phi,sin(phi),'Color',[0.6 0.16 0.16]),hold on
% matlab community may help
% http://www.mathworks.com/matlabcentral/fileexchange
% oder HOME - Community - fileexchange
% search text: RGB triple of color  
% https://www.mathworks.com/matlabcentral/fileexchange/24497-rgb-triple-of-color-name-version-2
% save rgb.m with copy/paste in current directory
% or change matlab's search path 
addpath('D:\OTH\Tools\MATLAB\tools')
plot(phi,cos(phi),'Color',rgb('Orange'))
% color chart
rgb chart

%% define legend within plot command
clear,clf
x = linspace(0,2*pi);

y1 = sin(x);
plot(x,y1,'DisplayName','sin(x)');hold on
legend

y2 = sin(x) + pi/2;
plot(x,y2,'DisplayName','sin(x) + \pi/2');

%% customize legend entries

clear,clf
x = linspace(0,2*pi);

y1 = sin(x);
p1 = plot(x,y1);hold on

y2 = sin(x) + pi/2;
p2 = plot(x,y2);

y3 = sin(x) + pi;
p3 = plot(x,y3);

% order and number of legend entries can be customized
legend([p3 p1],{'sin(x) + \pi','sin(x)'})

%% plot of functions

% plot over default interval
fplot(@erf)                     % https://en.wikipedia.org/wiki/Error_function

% define interval
fplot(@atan,[-1,1])

% define style
fplot('besselj(2,x)','--r')     % https://en.wikipedia.org/wiki/Bessel_function

% alternative
x=-6:.1:6; plot(x,atan(x))

%% pie chart

pie(ones(5,1))
pie(1:6)

%% subplot/tiledlayout: multiple plots in one figure
% subplot(m,n,p):  divides the current figure into an m-by-n grid 
% and creates axes in the position specified by p. 
z=magic(3);
figure()
subplot(2,3,1), bar(z)
subplot(2,3,2), bar3(z)      
subplot(2,3,3), pie(z)
subplot(2,3,4), pie3(z)      

% or
tiledlayout(2,3)
nexttile, bar(z)
nexttile, bar3(z)
nexttile, pie(z)
nexttile, pie3(z)

%% Logarithmic axis scaling

figure()
% log function results in a straight line in semi logarithmic representation
x = logspace(1,5,50);   % intervall from 10^1 to 10^5 
subplot(2,3,1)
plot(x,log(x)), title('log')
subplot(2,3,4)
semilogx(x,log(x)), title('semilogX')

% exp function results in a straight line in semi logarithmic representation
x = linspace(0,10,50);
subplot(2,3,2)
plot(x,exp(x)), title('exp')
subplot(2,3,5)
semilogy(x,exp(x)), title('semilogY')

% power function results in a straight line in double logarithmic representation
x = linspace(0,10,50);
x = logspace(-1,1,50);
subplot(2,3,3)
plot(x,x.^5), title('x^5')
subplot(2,3,6)
loglog(x,x.^5), title('loglog')


%% Two different y-axes in one plot
clf
x = 0:0.1:20;
y1 = 200*exp(-0.05*x).*sin(x);
y2 = 0.8*exp(-0.5*x).*sin(10*x);
plot(x,y1,x,y2)

% Problem: y2 << y1 is not visible in plot
figure(2)
yyaxis left
plot(x,y1)
ylabel('voltage u')
yyaxis right
plot(x,y2)
ylabel('current i')


%% ginput, text, gtext
clf;
phi=-6:.1:6;
plot(phi,sin(phi))
hold on
[x y]=ginput(1)
plot(x,y,'o')
str=sprintf('  x=%3.2f, y=%3.2f',x,y)
text(x,y,str)

%% area command fills areas  
clear,clc,clf
t=linspace(0,2*pi);                
plot(t,sin(t)),hold on

ha=area(t(end/2+1:end),sin(t(end/2+1:end)));
set(ha,'FaceColor',[0.85 0.95 0.9])         % color

%% latex-Font 

% without latex-interpreter: e.g. there is no varphi
ylabel('without latex: \int \alpha, \beta, \gamma, \phi')

% with latex-interpreter
x=xlabel('$$\mathrm{with ~ latex:} \int \alpha, \beta, \gamma, \varphi$$')
set(x,'Interpreter','latex')

text('Interpreter','latex',...
    'String','$$ A_\varphi = \int_\pi^{2\pi} \varphi(t) dt $$',...
    'Position',[3.5 -0.25],...
    'FontSize',16)

%% errorbars
clear,clc,clf
x=linspace(0,2*pi,10);
y=sin(x);
errorbar(x,y,0.1*y);    % error +/- 10%

% lower error bound 0.1, upper 0.2
errorbar(x,y,ones(1,10)*.1,ones(1,10)*.2)

%% exercise 9.1 errorbar
% read sim09_errorbar.txt
% in the 1. line are the measuring times
% the lines below contain the corresponding measured values
% Draw the measurement points and the average measurement curve with error bars
data = load('sim09_Dateien/sim09_errorbar.txt');
t = data(1,:)';
measurements = data(2:end,:)';
average = mean(measurements,2);

errMax = max(measurements - average, [], 2);
errMin = max(average - measurements, [], 2);

figure();
plot(t, measurements, 'b.');hold on;
errorbar(t, average, errMin, errMax);
hold off;
grid on;


%% Histogram
clear,clc,clf

% points in an exam
points = [1:30,4:27,7:24,10:21,13:18,14:15];

n=6;   % use n bins
subplot(311),histogram(points,n);         

% sorts points into bins with the bin edges specified by the vector edges. 
% Each bin includes the left edge, but does not include the right edge, 
% except for the last bin which includes both edges.
edges = [0,7,13 19 25 30];
subplot(312),histogram(points,edges);     

% 10 bins, vertical axis normalized with probability
subplot(313),h=histogram(points,10,'Normalization','probability')
axis tight  

% change color
h.FaceColor='r';    % (-> sim16 structure)

% the width of the bars can only be changed with a bar diagram, 
v = h.Values;                   % bin values
be = h.BinEdges;                % bin edges
em = be(1:end-1)+diff(be)/2;    % bin center 
subplot(311),bar(em, v,0.8)
% 0.8 means bar width is reduced to 80%

%% exercise 9.2 Histogram
% randn(n,1) returns n normally distributed random numbers with mean = 0.
% rand(n,1) returns n uniformly distributed random numbers from 0 to 1.
% compare the histogram of both distributions
n = 100000;

normalized = randn(n,1);
random = rand(n,1);

figure();
histogram(normalized);hold on;
histogram(random);
hold off;

%% plotmatrix
% creates a matrix of subaxes containing scatter plots of the columns of m
% against each other. 
clear,clc
x=linspace(-1,1);
m(:,1)=x;
m(:,2)=randn(size(x));
m(:,3)=-x.^2 + randn(size(x))/10;   
m(:,4)=sin(x*pi) + randn(size(x))/10;
plotmatrix(m);

% add axes labels
[~,ax]=plotmatrix(m);
n=length(ax);
for i=1:n
    xlabel(ax(n,i),sprintf('m%i',i))
    ylabel(ax(i,1),sprintf('m%i',i))
end

% correlation coefficient
% >0 means that an increase in one variable is associated with an increase in the other.
% <0 means that an increase in one variable is associated with a decrease in the other.
% A correlation of 1 indicates that the variables are perfectly linearly related. 
% A correlation of 0 indicates that the variables are not linearly related. 
corrcoef(m)




%% plot commands for 2d data

%% imagesc, colormap
clear,clc
% Each element of A specifies the color for one pixel of the image
% The color is defined in the colormap

A=eye(50)
imagesc(A)
colorbar      % show color legend

imagesc(rand(50))    

imagesc(magic(50)); 
colorbar;            
colormap(flipud(colormap))  % flip colormap
 
colormap(gray);             % jet, copper, hot, gray ...

load('Mandrill');           % read image data and colormap
imagesc(X)
colormap(map)

colormap(gray)
colormap(jet);           


%% contourplot for functions
figure()
fcontour(@(x,y) x.^2+y.^2), axis equal

f=@(x,y) 3*(1-x).^2.*exp(-(x.^2) - (y+1).^2) ...
   - 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) ...
   - 1/3*exp(-(x+1).^2 - y.^2);

% define interval, levels and mesh density
fcontour(f,[-2,2, -3,3],'MeshDensity',100, 'LevelList',-6:.2:8)    
colorbar


%% contourplot for data: contour(X,Y,Z)

% generate regulary spaced data with meshgrid
x=linspace(-2,2,50);
y=linspace(-3,3,50);
[X,Y]=meshgrid(x,y);

% what does meshgrid do?
% it is the 2D extension of the linspace command
% in X,Y there are all coordinates of a regulary spaced grid
% imagesc(X); colorbar    
% imagesc(Y); colorbar

contour(X,Y,f(X,Y),9)      % 9/30 levels
contour(x,y,f(X,Y),30)   % grid coordinates may be vectors or arrays 
colorbar, axis equal

% with filling
contourf(X,Y,f(X,Y),30)  

% with labeling of levels
c=-6:2:6; % levels
[C,h]=contour(X,Y,f(X,Y),c)   
clabel(C,h,c);

load penny
contour(P,99),axis equal tight, colormap(copper)

% How can you flip the image?

%% exercise 9.3 Isolinie
% draw the contour line of the function 
% f(x,y)= (x^2+y-11)^2+(x+y^2-7)^2
% in the interval  -5 < x,y < 5





%% vector field 1 (streamslice)
% magnetic field of a long straight conductor with current I
% the conductor is located at x=y=0
% Hx = I/(2pi r^2) * (-y)
% Hy = I/(2pi r^2) * (+x)
% with r = sqrt(x^2+y^2)

clear,clc,clf
I=1;    % current [A]
% plot grid
X=-2:0.01:2;
[x,y]=meshgrid(X);
% radius square
r2 = x.^2 + y.^2;

% vector field of H
Hx= -I./(2*pi*r2).*y;
Hy=  I./(2*pi*r2).*x;
% draw vector field
streamslice(x,y,Hx,Hy)
axis equal, axis tight

%% vector field 2 (quiver)
% By default, the quiver function scales the arrow lengths so that they do not overlap
X=-2:0.5:2;
[x,y]=meshgrid(X);
% radius square
r2 = x.^2 + y.^2;

% vector field of H
Hx= -I./(2*pi*r2).*y;
Hy=  I./(2*pi*r2).*x;
quiver(x,y,Hx,Hy)
axis equal, axis tight, grid on

%% Heatmap creates a heatmap from matrix data 
clf
A=rand(9);  % 9x9 random numbers
heatmap(A)

% detect outliers
A(3,7)=3;
heatmap(A)

%% Scatter plot of temperature measured in March 
clear,clf
data = readtable("sim09_MarchTemps.txt")
% size and color of marker can be individually defined (plot cannot)
scatter(data.longitude,data.latitude,[],data.temperature,"filled")
colormap(jet)
colorbar
xlabel('longitude')
ylabel('latitude')

% Which country is displayed?
%% more examples for 2D graphics: sim09_graphics2_example.m

