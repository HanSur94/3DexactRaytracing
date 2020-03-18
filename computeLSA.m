function [lsa,rayHeight, intersectionOpticalAxis] =...
            computeLSA(system, rays, distances, ns, varargin)
%COMPUTELSA will compute the longitudinal spherical aberration of the
%system.

    % tsa is the intersection height of the rays with the paraxial focal
    % plane

    % compute system matrix of the system
    [~, ~, systemMatrix] = getSystemMatrix(system, distances, ns);

    % compute the image side focal plane
    [~, imageFocalPoint] =...
        computeParaxialFocalPoint(systemMatrix, ns);

    % create new system with the last surface being the paraxial focal
    % plane
    % swap out last surface
    distances(1,end) = imageFocalPoint * 1e-3;
    imageFocalPointDistance = cumsum(distances);
    imageFocalPointDistance = imageFocalPointDistance(1,end);
    system(1,end) = Surface3D([0, 0, imageFocalPointDistance], inf, 1.0);

    % raytrace through a new system
    raysOut = raytraceSystem3D(rays, system, ns, distances);
        
    tsa = zeros(size(raysOut,1),1);
    c = tsa;
    rayHeight = c;
    for iRay = 1:1:size(raysOut,1)
        
        % get origin points of the last rays
        tsa(iRay,1) = raysOut{iRay,end}.origin(2);
        
        % get the angle gamma of the last rays
        c(iRay,1) = raysOut{iRay,end}.direction(3);
        
        rayHeight(iRay,1) = rays{iRay,1}.origin(2);
        
    end
    
    % compute the lsa
    lsa = tsa .* c ./ sqrt(1 - c .^ 2);
    lsa(isnan(lsa)) = 0;

    % compute intersection distance between rays & optical axis
    intersectionOpticalAxis = lsa + imageFocalPoint * 1e-3;
    intersectionOpticalAxis(isnan(intersectionOpticalAxis)) = 0;
    
    if nargin >= 5
        if isequal(varargin{1,1},'plot')
            % plot the data
            % take vargin{1,2:end} for plot formatting
            plot(lsa, rayHeight, varargin{1,2:end});
            grid on;
            grid minor;
            xlabel('Ray height y in [m]');
            ylabel('Longitudinal sph. aberration LSA in [m]');
            title('Longitudinal Spherical Aberration - LSA');
        else
            % otherwise, give error of wrong mode
            error('computeTSA:InputDatatype',...
            'Plot mode was written wrong, just type "plot" to the data.');
        end
    end
    
end

