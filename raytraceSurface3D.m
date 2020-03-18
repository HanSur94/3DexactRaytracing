function [raysIn3D, raysOut3D] = raytraceSurface3D(raysIn3D,...
                                        surface3D, n1, n2, t, varargin)
%RAYTRACESURFACE3D will raytrace one Ray3D or a cell array of Ray3D
%objects through a given 3D surface. The Output will be a cell array of 
%Ray3D objects. The user can choose between the 'new' or 'append' mode,
%which will return either only the new raytraced ray or it will return the
%new ray appended to the original input rays.
%
%   [raysIn3D, raysOut3D] = raytraceSurface3D(raysIn3D, surface3D, t, varargin)


% n1 is the refractive index before the surface
% n2 is the refractive index after the surface

% input must be a cell array in vector form!
% input cannot be a matrix of cells
% input can be a single cell!

    % Check for valid input size
    if ~iscolumn(raysIn3D)
        error('raytraceSurface3D:InputDataSize',...
            'Ray input is not a column vector!');
    end
    
    % get number of columns
    numberOfRays = size(raysIn3D,1);
    
    % check that al rays are Ray3D objects
    for iRay = 1:1:numberOfRays
        if ~isa(raysIn3D{iRay,1}, 'Ray3D')
            error('raytraceSurface3D:InputDatatype',...
                'Ray is not a Ray3D class object!');
        end
    end
    
    % Check that surface is a surface object
    if ~isa(surface3D, 'Surface3D')
        error('raytraceSurface3D:InputDatatype',...
            'Surface is not a Surface3D class object!');
    end
    
    % check if t is a scalar
    if ~isscalar(t)
        error('raytraceSurface3D:InputDataSize', 'Input t be a scalar..');
    end
    
    % Check t input
    if ~isnumeric(t) || ~isreal(t) || isinf(t) || isnan(t)
        error('raytraceSurface3D:InputDatatype',...
            'Input t must be numeric and not NaN and real.');
    end
    
    
    if ~isempty(varargin)
        % check that varargin is size n=1, m=1
        if ~isscalar(varargin)
             error('raytraceSurface3D:InputDataSize',...
                'Too many input arguments for the mode.');
        end

        % check that mode is not numeric
        if isnumeric(varargin{1,1})
            error('raytraceSurface3D:InputDatatype',...
                'Input mode must be non-numeric.');
        end

        % check that mode fullfills ways
        if ~isequal('append',varargin{1,1})
            error('raytraceSurface3D:InputDataSize',...
                'Such in mode does not exist. Please choose "append".');
        end
    end

    % convert the rayIn3D information to matrices
    raysOrigin = ones(numberOfRays,3);
    raysDirection = raysOrigin;

    for iRay = 1:1:numberOfRays
        raysOrigin(iRay,:) = raysIn3D{iRay,1}.origin;
        raysDirection(iRay,:) = raysIn3D{iRay,1}.direction;
    end

    % convert the surface3D informations into matrices
    c = 1/surface3D.radius;

    % raytrace all rays through the surface
    % to compute the distance T from a ray to the surface intersection point
    % we compute the distance from the origin to the surface vertex point
    %t = surface3D.origin(3) - surface3D.radius

    % compute distance from the ray origin to the intersection point with the
    % ray itself and the vector M, which starts from the vertex of the surface
    % and is perpendiycular to the ray
    e = t.*raysDirection(:, 3) - (sum(raysOrigin .* raysDirection, 2));

    % compute the z component of the M vector
    Mz = raysOrigin(:, 3) + e .* raysDirection(:, 3)-t;

    % computet the square of the M vector
    M2 = sum(raysOrigin .^ 2, 2) - e.^2 + t.^2 - 2*t.*raysOrigin(:,3);

    % compute the cosine of theta to compute finally T
    d = c .* M2 - 2*Mz;
    cosTheta = sqrt(raysDirection(:,3).^2 - c .* d);

    % if cosTheta is imaginary, then there will be no intersection with the
    % sphere. this will result in the output of NaN
    if isreal(cosTheta)

        % compute T, the distance from the ray to the intersection point with the
        % surface
        T = e + d ./ (raysDirection(:,3) + cosTheta);

        % with the disctance simply compute the origin of the new ray at the
        % intersection point
        origin2 = raysOrigin + T .* raysDirection;
        origin2(:,3) = origin2(:,3) - t;

        % compute the direction vector after the refraction of the new ray at the
        % surface intersection point
        u = n1./n2;
        cosTheta2 = sqrt( 1 - u.^2 .* (1- cosTheta .^ 2) );
        g = cosTheta2 - u .* cosTheta;
        direction2 = raysDirection .* u - c .* g .* origin2;
        direction2(:,3) = direction2(:,3) + g;
        

    else

        origin2 = [NaN, NaN, NaN];
        direction2 = [NaN, NaN, NaN];
        n2 = NaN;
        T = inf;

    end
    
    if (sum(isnan(origin2)) > 1)
        
        origin2 = [NaN, NaN, NaN];
        direction2 = [NaN, NaN, NaN];
        n2 = NaN;
        T = inf;
    end

    raysOut3D = cell(numberOfRays,1);
    
    for iRay = 1:1:numberOfRays
        % convert the ray informations back into Ray3D cell array
        raysOut3D{iRay,1} = Ray3D(origin2(iRay,:),direction2(iRay,:),n2);
        
        % add the distance to intersection to the incoming rays
        raysIn3D{iRay,1}.distanceToIntersection = T(iRay,1);
    end 
    
    % if single mode was chosen, just return the refracted rays
    % if append mode was chosen, return input rays and output rays as a
    % matrix
    if ~isempty(varargin)
        if isequal('append',varargin{1,1}) 
            raysOut3D = [raysIn3D , raysOut3D];
        end
    end
end

