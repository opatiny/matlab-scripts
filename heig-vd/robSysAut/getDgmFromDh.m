%% functions Denavit Hartenberg

% compute the direct geometric model from denavit hartenberg table
% (containig numerical values!

% returns: the DGM is a 4x4 transformation matrix, the transformations are
% also 4x4 and correspond to the transformations from one joint to another
function [dgm, transforms] = getDgmFromDh(dhTable)
    tabSize = size(dhTable);
    nbJoints = tabSize(1);
    
    dgm = getT(dhTable(1,:));
    transforms = {};
    
    for i=1:nbJoints
        T = getT(dhTable(i,:));
        % referentiel  mobile!!!!
        dgm = dgm * T;
        transforms{end+1} = T;
    end
end


function T = getT(jointVariables)
    T = getTz(jointVariables(3), jointVariables(4))...
        *getTx(jointVariables(1), jointVariables(2));
end


% DH method is a product of a transform along x and a transform along z
function Tz = getTz(di,thetai)
Tz = [cos(thetai) -sin(thetai) 0 0
      sin(thetai) cos(thetai) 0 0
      0 0 1 di
      0 0 0 1];
end

function Tx = getTx(ai, alphai)
Tx = [1 0 0 ai
      0 cos(alphai) -sin(alphai) 0
      0 sin(alphai) cos(alphai) 0
      0 0 0 1];
end

