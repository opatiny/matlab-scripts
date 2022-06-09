%% testing the a for loop
clc; clear; close all;

A = ones(3,2);

disp('Entering the loop')
for i=1:3
    A(i,:) = i;
end