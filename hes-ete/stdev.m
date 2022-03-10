%% Ex 6 - Implementation of a standard deviation
% Date: 2021.08.31

% do NOT put clc; clear; close all; here!!
% first work of file must be 'function'
%% function
function [sd] = stdev(x, y, polynom)
    % param
    % - x: x values
    % - y: y values
    % - polynom: polynom fitting the data
    % return: 1 standard deviation
    if length(x) ~= length(y)
        error('X and y have different lengths'); % error message
    end
    disp('Computing SD'); % printing text to console
    sd = sqrt(mean((polyval(polynom, x) - y).^2));
end