%% Assignment 9 - Exercise 1
clear; clc; clf;

% P at least two people have their birthday on the same day
n = 10;
nbPeople = 10;
birthdays = randi(365,n,1);

subset = birthdays(indices);