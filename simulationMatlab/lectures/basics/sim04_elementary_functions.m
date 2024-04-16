%% SIM04 elementary functions
clear,clc

% functions with array argument operate element by element with implicit loop 
% there is no need to use loops as in other programming languages

% radian
phi=0:pi/6:pi;
sin(phi)
% degree 
phi=0:30:180;
sind(phi)

% example: convert dimensionless number to decibel
data=[0.5 1 2 3 6 10 20 50 100];
data_dB = 20*log10(data)

% more elementary functions
help elfun


%% exercise 4.1
% convert the four vectors kk from cartesian to polar coordinates 
% r^2 = x^2+y^2
% tan(phi) = y/x

kk = [1,1; -1,1; -1,-1; 1,-1]'

x = kk(1,:);
y = kk(2,:);

r = sqrt(x.^2 + y.^2);
phi = atan2(y,x);

polar = [r;rad2deg(phi)]'



% solution pk=[
%     1.4142   45.0000;
%     1.4142  135.0000;
%     1.4142 -135.0000;
%     1.4142  -45.0000];

% hint: using atan() results in this solution
%        1.4142           45
%        1.4142          -45
%        1.4142           45
%        1.4142          -45
%  as the value range of atan() is [-pi,pi]
%  better: atan2()

%% more special functions

help specfun        % e.g. cart2pol(x,y)

%% array dimensions

A=[ 16     2     3    13
     5    11    10     8
     9     7     6    12];

size(A)         % size of all dimensions
numel(A)        % number of elements
length(A)       % size of largest dimension
ndims(A)        % number of dimensions

A(:,:,2)=A      % 3d-array
ndims(A)

%% arithmetic operators

A=[ 16     2     3    13
     5    11    10     8
     9     7     6    12];

sum(A)          % sum (along first dimension)
prod(A)         % product
diff(A)         % difference 
rem(A,5)        % remainder after division

% round
B=[-1:.25:1]
round(B)        % to nearest decimal or integer
floor(B)        % round towards -inf
ceil(B)         % round towards +inf
fix(B)          % round towards 0

% absolut value
abs(B)

%% descriptive statistics

A
% along first dimension (column)
mean(A)         % mean value
min(A)          % min value
max(A)          % max value

% along second dimension (row)
max(A')         % oder max(A,[],2)
mean(A')        % mean(A,2)

% element by element
max(A,sqrt(A)+5)       

A
[mx,idx]=max(A) % returns also index location idx of maximum mx 

A'              % k smallest elements in each column
mink(A',2)

%% sorting and reshaping arrays

A
sort(A)             % sort along first dimension (down)
[value idx]=sort(A)  % idx describes the rearrangement of each column

A
fliplr(A)
flipud(A)
reshape(A,4,[]) % reshape tp 4x? matrix
reshape(A,[],5) % reshape to ?x2 matrix

% more elementary matrix manipulations
help elmat

%% function help 

% use TAB to complete: e.g. flip-TAB

% docsearch (upper right) 

% mark command with mouse
% % press F1 or right mouse click "help on"

% or search manually in documentation 
% doc - Matlab - Language fundamentals - matrices and arrays - reshape


%% exercise 4.2
clear,clc
% calculate 10! = 1*2*3*...*10
% solution 3628800

ex2 = prod(1:10)

%% exercise 4.3
clear,clc
data=sin(0:0.11:2*pi).^2;
length(data)

% count and delete all outliers of data deviating by more than 0.5 from the mean value 
% solution: 3

indices = find(abs(data - mean(data)) > 0.5);

data(indices) = []

%% exercise 4.4
% the results from an exam are given:
format shortg
exam=[12345, 2.7;  17345, 3.7;  12385, 2.3;  12349, 1.3;  14345, 2.7;  12145, 2.0];
% sort array exam by matriculation number

ex4 = sortrows(exam)

sortedGrades = sortrows(exam,2)


