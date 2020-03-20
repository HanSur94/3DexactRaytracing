function [tca, raySlopes] = computeTCA(system, rays, distances, medias,...
                            wavelengths, varargin)
%COMPUTETCA will compute the transversal chromatic aberration of the
%system. It will use the TSA function and compute the TSA for multiple
%wavelengths.
%
%  [tca] = computeTCA(system, rays, distances, medias, wavelengths, varargin)


    % convert system matrials to array of refrective indices
    % refrective indices to compute the paraxial system matrix & focal point
    nd = medias2refractiveIndices(medias, 587.6e-3);
    
    % to compute the refractive indices for the tca computation
    ns = medias2refractiveIndices(medias, wavelengths);
    
    % compute system matrix of the system
    [~, ~, systemMatrix] = getSystemMatrix(system, distances, nd);

    % compute the image side focal plane
    [~, imageFocalPoint] =...
        computeParaxialFocalPoint(systemMatrix, nd);

    % create tca matrix
    tca = zeros(size(rays,1),size(wavelengths,2));
    raySlopes = tca;
    
    % create new system with the last surface being the paraxial focal
    % plane
    % swap out last surface
    distances(1,end) = imageFocalPoint * 1e-3;
    imageFocalPointDistance = cumsum(distances);
    imageFocalPointDistance = imageFocalPointDistance(1,end);
    system(1,end) = Surface3D([0, 0, imageFocalPointDistance], inf, 1.0);

    
    % for each wavelength, compute the tsa of the rays
    for iWavelength = 1:1:size(wavelengths,2)
        
        % raytrace through a new system
        raysOut = raytraceSystem3D(rays, system, ns(iWavelength,:),...
            distances);

        tsa = zeros(size(raysOut,1),1);
        raySlope = tsa;
        
        for iRay = 1:1:size(raysOut,1)
            % get origin points of the last rays
            tsa(iRay,1) = raysOut{iRay,end}.origin(2);

            % get the height of the rays in the entrance pupil ray slope
            raySlope(iRay,1) = raysOut{iRay,end}.direction(2)/...
            raysOut{iRay,end}.direction(3);
        end
        
        %[tsa, raySlope] = computeTSA(system, rays, distances, ns(iWavelength,:));
        tca(:,iWavelength) = tsa;
        raySlopes(:,iWavelength) = raySlope;
        
        
    end


end

