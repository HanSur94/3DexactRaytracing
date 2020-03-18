function [surfaceMatrix, translationMatrix, systemMatrix] = ...
    getSystemMatrix(system, distances, ns)
%GETSYSTEMMATRIX will return the system matrix of a system.
%
% [surfaceMatrix, translationMatrix, systemMatrix] = ...
%    getSystemMatrix(system, distances, ns)

    % check size of the inputs arrays
    if size(system,2) ~= size(distances,2)
        str =  ['Input size of system & distances not Valid. ',...
            'Input size(system,2) must be equal size(distances,2).'];
        error('getSystemMatrix:InputDataSize',str);
    end
    
    if size(distances,2)+1 ~= size(ns,2)
        str =  ['Input size of ns is not Valid. ',...
            'Input size(ns,2) must be equal size(distances,2)+1.'];
        error('getSystemMatrix:InputDataSize',str);
    end

    % create a cell arrays for surface matrices & translation matrices
    surfaceMatrix = cell(1,size(system,2)-1);
    translationMatrix = cell(1,size(distances,2)-2);
    ns = ns(1:end-1);
    
    for iSystem = 1:1:size(system,2)-1
        
        surfaceMatrix{1,iSystem} =  [1,...
            -((ns(1,iSystem+1)-ns(1,iSystem))/...
            system(1,iSystem).radius);0, 1];
    end 

    % compute translation matrices
    for iDistance = 2:1:size(distances,2)-1        
        
         translationMatrix{1,iDistance-1} = [1, 0;...
             distances(1,iDistance)/ns(1,iDistance), 1];
    end
    
    % instatiate the system matrix with a identity matrix
    systemMatrix = eye(2,2);
    
    for iDistance = size(surfaceMatrix,2):-1:2
        
           systemMatrix = systemMatrix *...
               surfaceMatrix{1,iDistance} *...
               translationMatrix{1,iDistance-1};
    end
    % multiply the last surface to the system matrix
    systemMatrix = systemMatrix * surfaceMatrix{1,1};
    
    
    % scale some of the matrix entries
    systemMatrix(1,2) = systemMatrix(1,2) * 1e-3;
    systemMatrix(2,1) = systemMatrix(2,1) * 1e3;

end

