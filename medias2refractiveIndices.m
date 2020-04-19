function [ns] = medias2refractiveIndices(medias, wavelengths)
%MATERIALS2REFRACTIVEINDICES will convert a cell array of optical medias
%of a optical system according to the given wavelength into a row vector
%containing the refractive indicies for the given wavelength. The medias
%can contain pure numbers, gasses or glasses. The input wavelength can be a
%scalar or row vector. The output ns will have the dimensions
%ns(n,m) with n = size(wavelength,2) and m = size(medias,2).
%
%   [ns] = medias2refractiveIndices(medias, wavelength)

    arguments
        medias (1,:) cell {mustBeCellWithNumericOrGlass}
        wavelengths (1,:) double {mustBeNumeric,... 
                                  mustBeGreaterThan(wavelengths,0) }
    end

    ns = zeros(size(wavelengths,2),size(medias,2));

    for iMedia = 1:1:size(medias,2)
        
        if isa(medias{1,iMedia}, 'Glass')
            
            ns(:,iMedia) = computeRefractiveIndex(medias{1,iMedia},...
                                                    wavelengths)';
            
        elseif isnumeric(medias{1,iMedia})
            
            ns(:,iMedia) = medias{1,iMedia};
            
        else
            error('medias2refractiveIndices:CannotProceed',...
            'Cannot proceed, one of the specified medias is not numeric or a glass.');
            
        end
    end

end


function mustBeCellWithNumericOrGlass(cellArray)
    for iCell = 1:1:length(cellArray)
        if ~isnumeric(cellArray{iCell})
            if ~isa(cellArray{iCell},'Glass')
                error('medias2refractiveIndices:InputType',...
                'One of the cells dont contains Numeric or Glass object.');
            end
        end
    end
end

