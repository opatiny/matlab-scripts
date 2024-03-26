%% SIM02 arithmetic operations

%% matrix operations
% calculation rules of matrix algebra are applied

A = [1 2 3;4 5 6;7 8 9];     

% addition/subtraction 
A+1     % all elements
A+A     % element by element
A+[1 2] % error: 3x3 matrix + 1x2 matrix
A-A

% multiplikation
% [m x n]*[n x p] = [m x p]
[1 2 3]*[1;2;3]
A*A         % [3x3]*[3x3]=[3x3] 
A*[1;2;3]   % [3x3]*[3x1]=[3x1] 

A*[1 2 3]   % error using *
% Incorrect dimensions for matrix multiplication. 
% Check that the number of columns in the first matrix matches the
% number of rows in the second matrix.

% power
A=[1/6 1/2 1/3;  
   1/2 1/4 1/4;  
   1/3 1/4 5/12]
A^10   % = A*A*A*A*A*A*A*A*A*A

% division
% X=A/B resolves the equation X*A=B to X 
% X=A\B resolves the equation A*X=B to X  
% example see below

%% array operations
% .*, ./, .^ operate element by element with implicit loop 

% a) both arguments same size
A = [1 2 3;4 5 6;7 8 9];     
A.*A
A*A
A.^3    % = A.*A.*A
A.^0.5  % square root

% b) row vector 1xn and column vector mx1
% results in m x n-matrix
A=1:3;
B=(1:4)';
A.*B    % = B.*A = B*A (A*B dimension error)
A+B     % = repmat(A,4,1)+repmat(B,1,3) = B+A

%% example of matrix operation
% solve a system of equations with Cramer's rule
% https://en.wikipedia.org/wiki/Cramer's_rule
%   x1 + 2*x2 = 3
% 4*x1 + 5*x2 = 6

clear,clc
% System of equations in matrix form: A*x=b
A=[1 2;4 5];
b=[3;6];

detA=det(A) % determinant of a matrix

A1=A;       % copy
A1(:,1)=b   % replace first column with b
detA1=det(A1)  
    
A2=A;       % copy
A2(:,2)=b   % replace second column with b
detA2=det(A2)  

% solution
x=[detA1/detA; detA2/detA]


% alternative: backslash operator
x=A\b

% check by inserting the solution in equation: A*x=b
A*x


%% exercise 2.1: infinite sum
clear; clc;
% a)
% 1/1 + 1/4 + 1/9 + 1/16 + ...
% the sum of 1/x^2 with x=1 to infinity = pi^2/a
% calculate a
lin = 1:10000;
result = sum(1./lin.^2);

a = pi^2/result


% b)
% 1/1 + 1/9 + 1/25 + ...
% the sum of 1/x^2 with x only odd numbers = pi^2/b
% calculate b

linOdd = 1:2:10000;
result = sum(1./linOdd.^2);

b = pi^2/result

%% exercise 2.2: dot product
% calculate the dot product of the vectors (1,2,3) and (3,2,1)

dotProd = dot(1:3,3:-1:1)
