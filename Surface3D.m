classdef Surface3D
    %SURFACE3D will create a surface object
    % 
    %   Surface3D(origin, radius, n)
    
    properties
        origin                 % vector 3d in [m] -> [x, y, z]
        radius                 % scalar radius in [m] -> r
        n                      % refractive Index of the material behind
                               % the surface
    end
    
    methods
        function obj = Surface3D(origin, radius, n)
            %SURFACE3D will construct a 
            % 
            %   Surface3D(origin, radius, n)
            
            % check size of the input
            if ~isSize(origin, 1, 3) || ~isSize(radius, 1, 1) ||...
                    ~isSize(n,1,1)
                
                 error('Surface3D:InputDataSize',...
                    'Input size not valid, check for scalar or vector.');
            
            end
            
            % check datatype of the input
            if (sum(isnan(origin)) > 0 || sum(isinf(origin)) > 0 ||...
                    ~isnumeric(origin) ||  ~isreal(origin)) ||...
                    (isnan(radius) ||...
                    ~isnumeric(radius) ||...
                    ~isreal(radius))
                
                error('Surface3D:InputDatatype',...
                    'Constructor input must be numeric and not NaN and real.');
                
            end
            
            
            %check that value for n is > 0, numeric and not NaN & not imag
            if  ~isreal(n) || n <= 0 || isnan(n) ||...
                    ~isnumeric(n) || isinf(n)
                
                 error('Surface3D:InputDatatype',...
                    'Constructor input n must be n>0, not Nan and real.');
            end
            
                obj.origin = origin;
                obj.radius = radius;
                obj.n = n;
        end

    end
end

