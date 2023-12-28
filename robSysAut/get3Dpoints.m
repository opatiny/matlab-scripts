% Compute points of each joints based on the transforms from one to the
% other
function [x,y,z] = get3Dpoints(transforms)

    nbPoints = length(transforms);
    
    previousPoint = [0;0;0;1];
    points = zeros(4, nbPoints);
    points(:, 1) = previousPoint;
    
    for i=1:nbPoints
        currentMatrix = transforms{i};
        
        newPoint = currentMatrix*previousPoint;
        
        points(:, i+1) = newPoint;
        previousPoint = newPoint;
    end
    
    x = points(1, :);
    y = points(2, :);
    z = points(3, :);
end