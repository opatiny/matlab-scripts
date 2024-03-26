%% SIM03 Operators
clear,clc

%% Relational Operations
% true=1
% false=0

A=[ 16     2     3    13
     5    11    10     8
     9     7     6    12
     4    14    15     1];

A>8     % greater
A==4    % equal
A~=1    % unequal

% beside indexing by position and linear indexing (single index) there is
% also logical indexing:

A==A'   % compares element by element

A(A>8)  % returns all elements of A greater than 8

% FIND returns rows and columns instead of a logical matrix
[row, col]=find(A>=15)


%% Logical oerations

% and(a,b) &
% or(a,b)  |
% not(a)   ~
% xor(a,b)
% any
% all

ones(3) & eye(3)
ones(3) | eye(3)
~eye(3)

any(A>14)   % check each column if any element  > 14
all(A>2)    % check each column if all elements >  2

%% Bit wise operations

bitor(1,2)      % 2^0 + 2^1 = 3
% for comparison: logical or
or(1,2)         % 1~=0 oder 2~=0

dec2bin(17)
dec2bin(21)
dec2bin(bitand(17,21))

%% set operations

% unique 
a=[1 2 2 4 1 4 2 7];
unique(a)

% intersect
intersect(6:6:60, 8:8:80)

%% more examples

help ops

%% exercise 3.1: 
A=[ 16     2     3    13
     5    11    10     8
     9     7     6    12
     4    14    15     1];

% a) How many matrix entries are one-digit?

a = length(find(A<10))

% b) Add all two-digit entries
b = length(find(A>9 & A <100))

% c) all entries in the matrix between 4 and 8 are to be multiplied by 10 
indices = find(A >= 4 & A <= 8);
c = A;
c(indices) = A(indices)*10

% d) add all diagonal elements
indices = find(A == A');

d = sum(A(indices))

%% homework exercise 1.3 soccer

A =[ 4     8     4     7     4     8     8     3     4     1     1
     8     7     9     7     3     9     2     3     4     5     6
     1     9     0     5     7     6     6     5    -1     6     5
     3     0     9     6     7     2     6     5     8     4     0
     9     3     1     8     6     6     1     3     0     8     0
     9     6     6     0     1     0     4     3     4     7     1
     7     2     5     3     0     4     2     5     8     3     0
     6     2     6     0     5     6     7     6     3     4     4
     3     7     3     1     3     9     2     9     6     3     8
     9     6     6     7     9     8     8     7     8     7     6
     1     5     8     7     9     4     8     4     8     7     5
     7     6     0     8     2     7     3     8     9     4     8
     6     0     0     5     8     4     4     1     1     6     0
     8     3     9     0     8     9     6     0     2     9     9
     3     4     6     9     5     9     8     0     8     7     1
     7     2     2     8     8     8     6     1     5     7     5
     8     7     4     2     9     3     5     3     5     1     1
     3     8     1     5     5     4     3     3     6     3     5
     5     2     2     9     7     2     4     0     8     5     0
     9     7     2     7     5     7     7     5     5     4     7
     5     1     3     8     0     8     8     0     2     0     8
     3     8     1     4     4     9     7     1     4     2     9
     6     1     3     4     6     5     0     6     4     8     9
     3     5     1     5     5     5     6     8     9     0     5
     8     7     4     2     9     3     5     3     5     1     1
     7     3     8     2     3     1     4     9     6     8     2
     4     8     0     7     9     8     4     5     6     0     1
     4     5     9     5     8     4     1     9     7     6     5
     6     4     3     6     8     2     8     5     3     5     5
     9     8    -1     3     3     8     3     5     5     2     7
     3     3     3     1     5     7     2     3     5     5     0]
 