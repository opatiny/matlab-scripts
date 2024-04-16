function [mw,sta] = sim08_statistics(x)
% this text apperas if you call "help sim08_statistics"
% the function calculates from the given vector the
% mean and the standard deviation

% default values if no parameters are given 
if nargin <1        % nargin = number of given parameters
    x=1:10;         % default input parameter
end

n = length(x);
mw = sum(x)/n;                      % mean
% sta = sqrt(sum((x-mw).^2/n));     % standard deviation

% Functions can call sub-functions in addition to other functions
sta = sqrt(sum(myquad(x-mw)/n));   

end

% functions within a function share the workspace (nested functions)
function x2 = myquad(x)
x2 = x.^2;
end