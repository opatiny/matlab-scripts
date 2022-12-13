%% Test createRandomArray
% test that the createRandomArray function from ml-spectra-processing
% generates a gaussian distribution
clc; clear; close all;


%% load data
file = fopen('testCreateRandomArray.json');
raw = fread(file,inf);
string = char(raw');
fclose(file);

array = jsondecode(string);

%% plot data
figure();
histogram(array,100);
grid on;