%% HES d'été MATLAB - Exercice 1
% Date : 

%% Initialisation
close all;   % ferme toutes les fenêtres graphiques
clear;       % efface toutes les variables de l'espace de travail ("workspace")
clc;         % efface l'affichage de la fenêtre de commande ("Command window")

%Initialisation de la matrice M
M = [
    1,2,3,4,5,6
    7,8,9,10,11,12
    13,14,15,16,17,18
    19,20,21,22,23,24
    25,26,27,28,29,30
    ];

%% Q1
[L,C] = size(M); 

%% Q2
M2 = M';

%% Q3
v3 = M(4,:);

%% Q4
v4 = M(:,2);

%% Q5
M5 = M(:,(5:end));

%% Q6
M6 = M(:,[6,2,1]);
subLin243 = M([2,4,3],:);
new = M(:,[6,1]);

%% Q7
M7 = [M(3,:);M(5,:)];

%% Q8
M8 = M([2,5], [1,6]);

%% Q9
M9 = M(:,6:-1:1);
% this syntax creates a decreasing array with values from 6 to 1

%% Q10
onesLine = ones(1,6);
M10 = [M;onesLine]; % be careful with consistency!!
MM = [M,M];

%% Q11
M11 = [M, zeros(5,1)];

%% Q12
M12 = M;
M12(3,:) = ones(1,6);
M12(1,1) = 42;

%% Q13
M13 = M;
M13(3,:) = M(1,2); % on met le scalaire dans chacune des cases du array

%% Q14
%M14 = 

%% Q15
M15 = M;
M15(3,:) = fliplr(M(3,:))

%% Q16
[L16,C16] = find(M==16);

%% Q17
[L17,C17] = find(M>28);
min(M(1,:));

%% Q18
v18 = find(min(abs(M(2,:)-exp(1)))); % not finished

%% Q19
%v19 =