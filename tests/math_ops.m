% additions, soustractions et multiplications

close all; clc; clear all;

%% def
M1 = [1,2
      3,4
      5,6];
M2 = [3,4
      5,6
      7,8];
%% op matrices
M3 = M1 + M2;
M3 = M1 - M2;
M3 = M1 * M2'

%% op valeurs
res = M1.*M2; % element par element

  