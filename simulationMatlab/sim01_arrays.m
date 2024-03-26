%% Overview GUI
% toolstrip: home, editor, ...    open sim01_arrays.m       
% command window: calculator mode: 3*3 
% workspace: lists type and values of all variables: a=3
% Current Folder toolbar          view (pwd) and change current directory
% Current folder window           windows explorer
% Editor window                   % comment  
% quickacess                      save, undo, help, favorites

% home-layout-default

%% run code 

% F5 (Run) runs the full script in the editor. 
% we prefer to run single lines or sections of the script.

% copy-paste
% mark sections of the code 
% use CTRL-C in editor and CTRL-V, RETURN im command window 

a=3
A=[1, 2, 3]

% F9    is equivalent to copy/paste but faster


% CTRL-RETURN    runs all code in a section of the script
% a section starts and ends with %% in the editor

%% define variables
% default: matrix or array  

a=3         % 1x1 Matrix (number or scalar)
A=[1, 2, 3] % 1x3 Matrix (line vector)

% :-operator simplifies vector definition
c=1:10      % equivalent to 1:1:10
d=3:-.5:1    

e=[1;2;3]   % 3x1 Matrix (column vector)

f1=[1,2,3; 4,5,6; 7,8,9] % 3x3 Matrix
% or more clearly arranged
f2=[1,3,2   
    8,7,9   
    6,5,4]

% alternative for :-operator
c=1:.33:3           % fixed step size, size and last element of vector is calculated
c=linspace(1,3,7)   % size and last element of vector is fixed, step size is calculated

%% clear variables 

clc         % clear command window
clear e f*  % clear variable e und all variablen starting with f  
clear       % clear all variables in workspace

%% special variables

ans         % last result
pi          % mathematical constant 3.14
eps         % smallest number

%% display format in command window

format long    % more decimals 
pi
format short   % default: 4 decimals (change: home-prefs)

3/7+2/7
format rat     % fractions
3/7+2/7
format short   % default

[1 1.2 12.3 123.4 1234.5]
format shortg  % avoid scientific notation
[1 1.2 12.3 123.4 1234.5]
format short   % default

doc format     % more formats (e.g. hex) 

%% manipulate arrays I
clear 

A=[1 2 3]       % commas are optional [1,2,3] 
A(2)=22

A(end)=33       % end is the last index
A(end+1)=44

A=[A;1:4]       % new row with ;
A=[A,[1;2]]     % new column with ,

% get part of an array  
a=[1:4;5:8;9:12;13:16]
a(2:3,2:3)

A
A(1,:)          % first line
A=[A;A(1,:)]    % append first line at the end
A(:,2)          % second column of the array
A(:,end)=A(:,2) % replace last column with second column

A(1:3,end)=[1;2]  % error: 3x1-Matrix cannot be filled with 2x1-Matrix 
A(1:3,end)=[1;2;0]  
A(2:3,end)=[1;2]

%% exercise 1.1

A=[1 2 3;
   4 5 6;
   7 8 9]

% reverse the order of the first line in A
%  3 2 1
%  4 5 6
%  7 8 9
A1 = A;
A1(1,:) = fliplr(A1(1,:))

% reverse the order of all columns in A
%  7 8 9
%  4 5 6
%  1 2 3
A2 = A;
A2 = fliplr(A2)
 
%% manipulate arrays II
% beside indexing by position there is also linear indexing 
A(3:6)          % numbering starts top left going down first
% and logical indexing (sim03.m)

% clear single elements of an array
A(:,3)=[]       % delete 3. column
A(2,:)=[]       % delete 2. line
% transpose: row vector <-> column vector
a
a'
[1, 2, 3]'
[1; 2; 3]'

%% exercise 1.2

clear,clc
M = [1 2 3;4 5 6;7 8 9]  

% a) create 6x6 matrix
%    V= |M M|
%       |M M|

V = [M M; M M]

% b) try again with the command repmat (-> doc repmat)

V = repmat(M, 2, 2)

% c) create 5x5-Matrix V1 by deleting 2nd row and 3rd column of matrix V 
V1 = V;
V1(2,:) = []
V1(:, 3) = []

% d) create 6x6-Matrix V2 by replacing 4th row of V with the vector of the numbers from 1 to 6

V2 = V;
V2(4, :) = 1:6

% e) create 3x3-Matrix M1 by replacing every second value of M with 0
% M1 = [1 0 3;
%       0 5 0
%       7 0 9]

M1 = M;
M(2:2:end) = 0

%% special arrays 
eye(4)          % unit matrix
ones(5,2)       % 5x2 matrix fill of 1
zeros(3,4)      % 3x4 matrix full of 0

%% sum function 
% works like most matlab commands along first array dimension (down)
A = [1 2 3;4 5 6;7 8 9] ;   
% ; at end of line suppress output in command window

sum(A)
sum(A')         % or sum(A,2)
sum([1 2 3])    % in a matrix with single column sums row elements
sum(sum(A))     % sums all elements or sum(A,'all')

%% history 
% cursor up shows command history

%% exercise 1.3
% calculate sum of all numbers from 1 to 100
sum(1:100)

%% exercise 1.4
% calculate the sum of all rows and columns of M

clear,clc
M = magic(5)
rows = sum(M,2) 
columns = sum(M)


