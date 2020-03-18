function [tsa, raySlope] = computeTSA(system, rays, distances, ns,...
                                    varargin)
%COMPUTETSA3D will compute the transversal spherical aberration of the
%system.
%
%   [tsa, raySlope] = computeTSA(system, rays, distances, ns, varargin)

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
    raySlope = tsa;
    for iRay = 1:1:size(raysOut,1)
        % get origin points of the last rays
        tsa(iRay,1) = raysOut{iRay,end}.origin(2);
        
        % get the height of the rays in the entrance pupil? ray slope?
        raySlope(iRay,1) = raysOut{iRay,end}.direction(2)/...
                    raysOut{iRay,end}.direction(3);
    end
    
    if nargin >= 5
        if isequal(varargin{1,1},'plot')
            % plot the data
            % take vargin{1,2:end} for plot formatting
            plot(raySlope, tsa, varargin{1,2:end});
            grid on;
            grid minor;
            xlabel('Ray slope tan(u) in [rad]');
            ylabel('Transvers sph. aberration TSA in [m]');
            title('Transverse Spherical Aberration - TSA');
        else
            % otherwise, give error of wrong mode
            error('computeTSA:InputDatatype',...
            'Plot mode was written wrong, just type "plot" to the data.');
        end
    end

end

