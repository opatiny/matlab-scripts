%% Assignment 9 - Exercise 1
clear; clc; clf;

% P at least two people have their birthday on the same day
nbIterations = 100000;
nbPeople = 50;

P = zeros(1,nbPeople);

% this works but is pretty slow obviously, analytical formula would be
% better
for i = 1:nbPeople
    sum = 0;
    for j = 1:nbIterations
        birthdays = randi(365,i,1);
        sorted = sort(birthdays);
        result = length(find(diff(sorted) == 0)) > 0;
        sum = sum + result;
    end
    P(1,i) = sum/nbIterations;
end

%% plot
plot(1:nbPeople, P*100, '-');
xlabel('Number of people');
ylabel('Probability [%]');