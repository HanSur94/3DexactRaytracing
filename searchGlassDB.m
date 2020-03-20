function [searchResultTable] = searchGlassDB(searchWord, keyWord, glassDB)
%SEARCHGLASSDB will search in the glass database for a specific glass type,
%manufracturer, abbe grouping, refractive indices (nd1, ne, vd1, ve) and
%seidel coefficients (B1,B2,B3,C1,C2,C3).
%It returns a table, containing all possible results. The function uses
%the stringfind function to search for the results.
%
%   [searchResultTable] = searchGlassDB(searchWord, keyWord, glassDB)


    if isnumeric(searchWord) || isnumeric(keyWord)
        error('searchGlassDB:InputDatatype',...
                    'searchWord & keyWord must be a string.')
    end
    
    % glassDB must be a table with at least height of 1
    if ~istable(glassDB)
        error('searchGlassDB:InputDatatype',...
                    'glassDB must be a table.')
    else
        if height(glassDB) < 1
            error('searchGlassDB:InputDataSize',...
                    'glassDB must have a height of at least 1.')
        end
        if width(glassDB) ~= 13
            error('searchGlassDB:InputDataSize',...
                    'glassDB must have a width of 13.')
        end
    end

    % fetch the glass types
    firstTable = glassDB.(keyWord);
    
    % search for the searchword string and convert results into a string
    stringsFound = strfind(string(firstTable(:,:)), searchWord,...
        'ForceCellOutput', true);
    
    indices = [];
    
    % get indices of results
    for iOutput = 1:1:length(stringsFound)
        if ~isempty(stringsFound{iOutput,1})
            indices = [indices, iOutput];
        end
    end

    
    % return table with results
    searchResultTable = glassDB(indices,:);
    
    % create table with search result index
    index = 1:1:height(searchResultTable);

    % combine search result table & 
    searchResultTable = addvars(searchResultTable,index','Before',...
        'GlassType');
    searchResultTable.Properties.VariableNames{1,1} = 'Index';
    
    
end

