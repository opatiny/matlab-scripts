%% loops and conditional statements

%% for-loops
clear,clc

n=1e7;          % loop size
c=0;            % initialize sum
b=zeros(1,n);   % initialize array
for a=1:n
    b(a)=a; % füllt Vektor b mit Zahlen
    c=c+a;  % summiert auf
end
% smart ident (strg-I) <3

%% Debugging

% works with Run (F5) or section run (ctrl-return)
% set breakpoint by clicking on line number
% (conditional) breakpoints, step, quit

%% exercise 7.1
% rewrite the code above without loops
b = 1:n;
c = sum(b)

%% IF ELSE END, BREAK CONTINUE

% if
for i=1:10
    if i<4
        sprintf('%d is < 4',i)
    end
end

% combine conditions
for i=1:10
    if i<4 || i>7
        sprintf('%d is <4 or >7 ',i)
    end
end

% no need for continous loop vector
for i=[1 3 4 5 8 9]
    if i>4 & i<7
        sprintf('%d is between 5 and 7',i)
    end
end

% else, elseif, else
for i=1:10
    if i<4
        sprintf('%d is <4 ',i)
    elseif i>7
        sprintf('%d is >7 ',i)
    else
        disp('number is between 4 and 7')
    end
end

% break, continue  
for i=1:10
    if i<4
        continue  % next loop (goto 69)
    elseif i>7
        break     % stop loop (goto 70)
    else
        sprintf('%d ist zw. 4 und 7 ',i)
    end
end

%% SWITCH-CASE
% can be more readable
Str ='c'
% Lösung mit SWITCH-CASE
switch Str
    case {'a','b'}
        disp('It is a or b');
    case 'c'
        disp('it is c');
    otherwise
        disp('not valid');
end

% solution with IF-ELSE
if strcmp(Str,'a') || strcmp(Str,'b')
     disp('It is a or b');
elseif strcmp(Str,'c')
     disp('it is c');
else
    disp('not valid');
end


%% WHILE 
% if number of loop passes not known in advance

% example: Matlab's smallest number
var=1;       % variable
eps_a = 0.1; % staring value
while (var+eps_a) ~= var     
    eps_a = eps_a/2;         
end
eps_a = eps_a*2  


%% Do-while
% can be realized with break

clear
a=0;
while 1>0       % infinite loop (Abbruch ctrl-c in command window)
    a=a+1;      % dummy command
    if a>10
        break
    end
end

%% more programming language constructs
help lang 

%% exercise 7.2 1x1
% create a 10x10-Matrix with a multiplication table
% 1 2  3  4 ...
% 2 4  6  8 ...
% 3 6  9 12 ...
% 4 8 12 16 ...
% ...

% a) double for loop
M = zeros(10,10)
for i=1:10
    for j=1:10
        M(i,j) = i*j;
    end
end
M

% b) single for loop
for i = 1:10
    M(i,:) = i*(1:10)
end
M

% c) no for loop
vect = 1:10;
M = vect'*vect

%% exercise 7.3  Fibonacci number 
% https://en.wikipedia.org/wiki/Fibonacci_number
%  sequence starts with 0 and 1 
f=[0;1];  
% recurrence relation: f(n) = f(n-1) + f(n-2)
% 0, 1, 1, 2, 3, 5, 8, 13, ...
% a) calculate the firt twenty numbers
previous = 0;
current = 1;
for i=1:20
    tmp = current;
    current = current + previous
    previous = tmp;
    ratio = current/previous
end

% b) Show the limit (n -> inf) of consecutive quotients 
% % f(n+1)/f(n) = (1+sqrt(5))/2 = 1.618 (golden ratio)


%% exercise 7.4 while loop
% find the largest n with n! < 1e100  
% 4! = 1*2*3*4
i = 10;
fac = 0;
while fac < 1e100
    i = i + 1;
    fac = factorial(i)
end

result = i-1


