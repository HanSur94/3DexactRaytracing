function [refractiveIndex] = computeRefractiveIndex(glass, wavelength)
%COMPUTEREFRACTIVEINDEX will compute the refractive index of a glass
%according to a special wavelength of multiple wavelength. The wavelength
%will be computed with the sellmeier formula. The seidel-coefficients will
%be used from the glass class.

    if ~isa(glass, 'Glass')
        error('computeRefractiveIndex:InputDataType',...
            'glass must be a class object of type "Glass".')
    end
    
    if ~isrow(wavelength) 
        error('computeRefractiveIndex:InputDatasize',...
            'wavelength must be row vector or scalar.')
    end
    
    if ~isnumeric(wavelength) 
        error('computeRefractiveIndex:InputDataType',...
            'wavelength must be numeric.')
    end
    
    if ~isreal(wavelength) 
        error('computeRefractiveIndex:InputDataType',...
            'wavelength must be real.')
    end

    refractiveIndex = sqrt(1+...
        (glass.sellmeier(1,1) * (wavelength * 1e6).^2)./...
            ((wavelength * 1e6).^2 - glass.sellmeier(1,4))+...
        (glass.sellmeier(1,2) * (wavelength * 1e6).^2)./...
            ((wavelength * 1e6).^2 - glass.sellmeier(1,5))+...
        (glass.sellmeier(1,3) * (wavelength * 1e6).^2)./...
            ((wavelength * 1e6).^2 - glass.sellmeier(1,6)));

end

