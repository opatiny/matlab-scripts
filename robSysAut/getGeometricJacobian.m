% compute geometric Jacobian matrix for a given system with n joints
% points: n+1 [x;y;z] points
% the z axes of the joints
% jointTypes: joints can be 'R' or 'P'
function J = getGeometricJacobian(points, zAxes, jointTypes)
    nbJoints = length(zAxes(1,:));
    J = zeros(6, nbJoints);

    for i= 1:nbJoints
        switch jointTypes(i)
            case 'R'
                J(:,i) = getRjointVector(points, zAxes, i);
            case 'P'
                J(:,i) = getPjointVector(points, zAxes, i);
            otherwise
                error('unknown joint type');
        end
    end
end

% for roitoid joints
% the jacobianVector is a 6x1 vector
function jacobianVector = getRjointVector(points, zAxes, jointNb)
    top = cross(zAxes(:,jointNb), points(:,end) - points(:, jointNb));
    bottom = zAxes(:,jointNb);
    
    jacobianVector = [top; bottom];
end

% for prismatic joints
% the jacobianVector is a 6x1 vector
function jacobianVector = getPjointVector(~, zAxes, jointNb)
    top = zAxes(:,jointNb);
    bottom = [0;0;0];
    
    jacobianVector = [top; bottom];
end