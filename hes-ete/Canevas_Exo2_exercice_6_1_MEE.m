%% HES d'�t� MATLAB - Exercice 2
% Date : 

%% Initialisation
close all;   % ferme toutes les fen�tres graphiques
clear;       % efface toutes les variables de l'espace de travail ("workspace")
clc;         % efface l'affichage de la fen�tre de commande ("Command window")

%% Variables
M = [3,-5,0.1
     -1,0.01,-30
     10,11,-0.01];

%% R�solution
%Introduction du second membre
B = [pi; 0; 1];
res = inv(M)*B;
res = M\B; % better method
