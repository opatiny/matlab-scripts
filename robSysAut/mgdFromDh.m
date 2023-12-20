%% Get direct geometric model from Denavit-Hartenberg table
clear; clc; close all;

% DH: for each joint a_i, alpha_i, d_i, theta_i -> N*4

dhTable = [1 0 0 1
           1 0 0 1];
       
       
dgm = getDgmFromDh(dhTable)

function dgm = getDgmFromDh(dhTable)

    tabSize = size(dhTable);
    nbJoints = tabSize(1)
    
    dgm = getT(dhTable(1,:));
    
    for i=1:nbJoints
        T = getT(dhTable(i,:))
        % referentiel  mobile!!!!
        dgm = dgm * T;
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