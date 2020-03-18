function [rays] = getRay3DBundle(numberOfRays, startStopX, startStopY,...
    startStopZ, startStopDirX, startStopDirY, startStopDirZ)
%GETRAY3DBUNDLE will return ray cell array which is a column vector.
%
% [rays] = getRay3DBundle(numberOfRays, startStopX, startStopY,...
%    startStopZ, startStopDirX, startStopDirY, startStopDirZ)


    % check inputs to be scalar or row vector
    if  ~isscalar(numberOfRays)
        error('getRay3DBundle:InputDataSize',...
            'Number of Rays must be scalar.');
    end
    
    % check inputs to be scalar or row vector
    if  ~isrow(startStopX) || ~isrow(startStopY) || ~isrow(startStopZ) ||...
            ~isrow(startStopDirX) || ~isrow(startStopDirY) ||...
            ~isrow(startStopDirZ)
        
        error('getRay3DBundle:InputDataSize',...
            'Number of Rays must be scalar.');
    end
    
    
    % check inputs to be real and not NaN
    if ~isreal([numberOfRays, startStopX, startStopY, startStopZ,...
            startStopDirX, startStopDirY, startStopDirZ])
        
        error('getRay3DBundle:InputDatatype',...
            'All Input must contain real numbers.');
    end
    
    if sum(isnan([numberOfRays, startStopX, startStopY, startStopZ,...
            startStopDirX, startStopDirY, startStopDirZ])) > 1
        
        error('getRay3DBundle:InputDatatype',...
            'All Input must be not NaN');
    end
    
    if ~isnumeric([numberOfRays, startStopX, startStopY, startStopZ,...
            startStopDirX, startStopDirY, startStopDirZ])
        
        error('getRay3DBundle:InputDatatype',...
            'All Input must be numeric');
    end


    rays = cell(numberOfRays,1);
    x = linspace(startStopX(1), startStopX(2),numberOfRays);
    y = linspace(startStopY(1), startStopY(2),numberOfRays);
    z = linspace(startStopZ(1), startStopZ(2),numberOfRays);
    
    
    xDir = linspace(startStopDirX(1), startStopDirX(2),numberOfRays);
    yDir = linspace(startStopDirY(1), startStopDirY(2),numberOfRays);
    zDir = linspace(startStopDirZ(1), startStopDirZ(2),numberOfRays);
    
    for iRay = 1:1:numberOfRays
        rays{iRay,1} = Ray3D([x(1,iRay),y(1,iRay),z(1,iRay)],...
            [xDir(1,iRay), yDir(1,iRay), zDir(1,iRay)], 1);
    end

end

