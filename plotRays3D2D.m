function [plotHandles] = plotRays3D2D(rays, distances, varargin)
%PLOTRAYS3D will plot all rays from an cell array/matrix in the z-y-plane.
%
%   plotRays3D2D(rays, distances, color)
    
    % check that distances is a row vector
    if ~isrow(distances)
        error('plotRays3D2D:InputDataSize',...
                'Input distances must be a row vector.');
    end
    
    % get cumulative sum from the distances
    distances = [0, distances];
    distances = cumsum(distances);
    
    plotHandles = cell(size(rays));
    
    hold on;
    for iRay = 1:1:size(rays,1)
        for iSystem = 1:1:size(rays,2)
            
            rays{iRay,iSystem}.origin(3) =...
                rays{iRay,iSystem}.origin(3) + distances(1,iSystem);
            
            % check if ray has a intersection distance
            if isinf(rays{iRay,iSystem}.distanceToIntersection)
                distance = 1e-3;
            else
                distance = rays{iRay,iSystem}.distanceToIntersection;
            end

            % line equation y = mx + b
            % compute slope m
            % m = tan(acos(rays{iRay,iSystem}.direction(2)))
            m = rays{iRay,iSystem}.direction(2) /...
               rays{iRay,iSystem}.direction(3);

            x = distance;
            b = rays{iRay,iSystem}.origin(2);
            y = m * x + b;
            

            % draw line
            plotHandles{iRay, iSystem} = line([rays{iRay,iSystem}.origin(3),...
                x+rays{iRay,iSystem}.origin(3)],...
                [rays{iRay,iSystem}.origin(2), y], varargin{:});

        end
    end
    hold off;

end

