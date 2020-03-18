function [raysOut3D] = raytraceSystem3D(raysIn3D,surfaces,...
    refractiveIndices, distances)
%RAYTRACESYSTEM3D this function will raytrace input rays through a system.
%The input must must be a cell array of Ray3D objects.
%The function will output an cell matrix of Ray3D objects.
%
% [raysOut3D] = raytraceSystem3D(raysIn3D,surfaces,...
%    refractiveIndices, distances)


    % raysIn3D must be a column vector with type RaysIn3D
    if ~iscolumn(raysIn3D)
        error('raytraceSystem3D:InputDataSize',...
                'Ray input is not a column vector!');
    end
    
    for iRay = 1:1:size(raysIn3D,1)
        if ~isa(raysIn3D{iRay,1},'Ray3D')
            error('raytraceSystem3D:InputDatatype',...
                    'Rays are not type of Ray3D!');
        end
    end
    
    % system must be row vector with type Surface3D
    if ~isrow(surfaces)
        error('raytraceSystem3D:InputDataSize',...
                'Ray input is not a row vector!');
    end

    
    for iRay = 1:1:size(surfaces,2)
        if ~isa(surfaces,'Surface3D')
            error('raytraceSystem3D:InputDatatype',...
                    'Rays are not type of Surface3D!');
        end
    end

    % create raysOut cell matrix
    raysOut3D = cell(size(raysIn3D,1),size(surfaces,2));
    raysOut3D(:,1) = raysIn3D;

    % call raytraceSurface3D for each surface
    for iSurface = 1:1:size(surfaces,2)
        
        if iSurface == size(surfaces,2)
            % take the same n's when reached the image plane
            n1 = refractiveIndices(1,size(surfaces,2));
            n2 = refractiveIndices(1,size(surfaces,2));
        else
            % take the n's that we need 
            n1 = refractiveIndices(1,iSurface);
            n2 = refractiveIndices(1,iSurface+1);
        end
        
        % raytrace rays as columns vector through the system.
        % return the outgoing & modified incoming rays
        [raysOut3D(:,iSurface), raysOut3D(:,iSurface+1)] =...
            raytraceSurface3D(raysOut3D(:,iSurface),...
            surfaces(1,iSurface),n1,n2, distances(1,iSurface));
        
    end


end

