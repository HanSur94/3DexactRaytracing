classdef Ray3D
    %RAY3D to represent a 3D vector.
    %
    %   Ray3D(origin, direction, n)
    
    properties
        origin              % vector 3d in [m] -> [x, y, z]
        direction           % vector 3d in [rad] -> [a, b, c] with
        % a = cos(A); b = cos(B) and
        % c = +sqrt(1-a*a-b*b)
        n                   % refractive Index of the media in which the
                            % ray travels in [-] --> scalar
        distanceToIntersection
    end
    
    methods
        function obj = Ray3D(origin, direction, n)
            %RAY3D Construct an instance of this class
            %
            %   Ray3D(origin, direction)
            
            % check for input size
            if ~isSize(origin,1,3) || ~isSize(direction,1,3) ||...
                    ~isSize(n,1,1)
                
                error('Ray3D:InputDataSize',...
                    'Input size not valid, check for scalar or vector.');
            
            end
            
            % check for input datatypes
            if (sum(isinf(origin)) > 0 ||...
                    ~isnumeric(origin) ||  ~isreal(origin)) ||...
                    (sum(isinf(direction)) > 0 || ~isnumeric(direction) ||...
                    ~isreal(direction))
                
                error('Ray3D:InputDatatype',...
                    'Constructor input must be numeric and not NaN and real.');
            end
            
            %check that value for n is > 0, numeric and not NaN & not imag
            if  ~isreal(n) || n <= 0 ||...
                    ~isnumeric(n) || isinf(n)
                
                 error('Ray3D:InputDatatype',...
                    'Constructor input n must be n>0, not Nan and real.');
            end
            
            
            % check if one of the inputs is NaN. if yes, then set
            % everything to NaN
            if sum(isnan(origin)) > 0 || sum(isnan(direction)) > 0 ||...
                    isnan(n)
                
                obj.origin = [NaN,NaN,NaN];
                obj.direction = [NaN,NaN,NaN];
                obj.n = NaN;
                
            else
                
                obj.origin = origin;
                obj.direction = direction;
                obj.direction(1,3) = sqrt(1-direction(1,1)^2-...
                    direction(1,2)^2);

                    if ~isreal(obj.direction(1,3))
                        error('Ray3D:InputDatatype',...
                        'calculation of obj.direction returns imaginary result.');
                    end  

                obj.n = n;
                
            end
            
            obj.distanceToIntersection = Inf;

        end
 
    end
end

