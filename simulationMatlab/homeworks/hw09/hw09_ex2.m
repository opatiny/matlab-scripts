%% Assignment 9 - Exercise 2
clear; clc; clf;

% fair trade
nbIterations = 1e6;

nbPeople = 100;
seedCapital = 100; % EUR
rate = 0.2;

capitals = ones(1,nbPeople)*seedCapital;

winners = zeros(1,nbIterations);
medians = zeros(1, nbIterations);

for i = 1:nbIterations
players = randi(nbPeople,2,1);
winner = randi(2,1,1);
looser = ~mod(winner+1, 2)+1;

exchangeValue = rate*min(capitals(players));

capitals(players(winner)) = capitals(players(winner)) + exchangeValue;

capitals(players(looser)) = capitals(players(looser)) - exchangeValue;

winners(1,i) = sum(capitals > seedCapital);
medians(1,i) = median(capitals);
end

%% plot
subplot(121);
semilogx(1:nbIterations, medians,'-'); hold on;
semilogx(1:nbIterations, winners,'-');
hold off;
xlabel('Transactions')
legend('Median capital [EUR]', 'Number of winners');
ylim([0,120]);

subplot(122);
stem(1:nbPeople, capitals);
xlabel('Participants');
ylabel('Capital [EUR]');
