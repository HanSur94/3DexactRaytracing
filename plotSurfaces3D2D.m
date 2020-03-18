function [plotHandles] = plotSurfaces3D2D(surfaces,varargin)
%PLOTSURFACES3D2D will plot the 3D surface in 2D. The surfaces will be plot
%a simple spheres in the z-y-plane. A color must be specified
%
%   [plotHandle] = plotSurfaces3D2D(surfaces,varargin)

    % check that surfaces are in a row vector
    if ~isrow(surfaces)
        error('plotSurfaces3D2D:InputDataSize',...
        'Input is not a row vector.');
    end
    
    
    for iSurface = 1:1:size(surfaces,2)
        % Check that surface is a surface object
        if ~isa(surfaces(1,iSurface), 'Surface3D')
            error('plotSurfaces3D2D:InputDatatype',...
                'Surface is not a Surface3D class object.');
        end
    end
    
    
    plotHandles = cell(size(surfaces));

    % plot the surfaces
    hold on;
    for iSurface = 1:1:size(surfaces,2)
        
        % check if surface is a sphere or plane
        if isinf(surfaces(1,iSurface).radius)
            
            plotHandles{1,iSurface} =...
                xline(surfaces(1,iSurface).origin(3), varargin{:});
            
        else
            rad = linspace(0, 2*pi, 1000);
        
            sphereX = sin(rad) * surfaces(1,iSurface).radius +...
                surfaces(1,iSurface).origin(3);

            sphereY = cos(rad) * surfaces(1,iSurface).radius +...
                surfaces(1,iSurface).origin(2);

            plotHandles{1,iSurface} = plot(sphereX, sphereY, varargin{:});
        end
        
    end
    
    % plot optical axis
    yline(0,'b--')
    hold off;
    
end

