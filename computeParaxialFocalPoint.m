function [objectFocalPoint, imageFocalPoint] =...
    computeParaxialFocalPoint(systemMatrix,ns)
%COMPUTEFOCALPOINT will compute the paraxial focal point of the system via
%the system matrix of the ocrresponding system.
%
%   [objectFocalPoint, imgageFocalPoint] =...
%                       computeParaxialFocalPoint(systemMatrix,ns)

    objectFocalPoint = ns(1,1) * systemMatrix(1,1) / systemMatrix(1,2);
    imageFocalPoint = -ns(1,end-1) * systemMatrix(2,2) / systemMatrix(1,2);
    
end

