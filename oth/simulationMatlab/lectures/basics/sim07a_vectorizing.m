%% vectorizing
% Evaluate 2D function 
% z(x,y) = x*exp(-x^2-y^2)
% on a 2D grid with about 1 million coordinates

clear, clc
% grid
x = -6:0.01:6;
y = -4:0.01:4;

%% method 1: clearly represented, but inefficient 

tic     % start timer
% matlab hint: preallocation improves speed
for xi= 1:length(x)
    for yi= 1:length(y)
        Z1(xi,yi) = x(xi)*exp( -x(xi)^2 - y(yi)^2 );
    end
end
toc     % stop timer

%% method 2 with preallocation

tic     
Z1 = zeros(length(x),length(y));   
for xi= 1:length(x)
    for yi= 1:length(y)
        Z1(xi,yi) = x(xi)*exp( -x(xi)^2 - y(yi)^2 );
    end
end
toc     

%% methode 3: clearly represented and efficient

tic
[Y, X] = meshgrid(y,x);
Z2 = X.*exp(-X.^2 - Y.^2);
toc

%% methode 4: very efficient, but not clear
% implicit sum in scalar product

tic
Z3 = (x'.*exp(-x'.^2)) * exp(-y.^2);
toc

