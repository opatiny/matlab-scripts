%% functions Denavit Hartenberg
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

