classdef Glass
    %GLASS Summary of this class goes here
    %
    %   Glass(type,manufracturer,abbeGrouping,...
    %                nd,ne,vd,ve,sellmeier)
    
    properties
        type
        manufracturer
        abbeGrouping
        nd
        ne
        vd
        ve
        sellmeier
    end
    
    methods
        function obj = Glass(type,manufracturer,abbeGrouping,...
                            nd,ne,vd,ve,sellmeier)
            % GLASS Construct an instance of this Glass Class.
            % 
            %   Glass(type,manufracturer,abbeGrouping,...
            %                nd,ne,vd,ve,sellmeier)
            
            % check that sellmeier is a row vector with length of 6
            if iscolumn(sellmeier)
                error('Glass:InputDataSize',...
                    'sellmeier must be a row vector.')
            end
            
            if length(sellmeier) ~= 6
                error('Glass:InputDataSize',...
                    'sellmeier must have length of 6.')
            end
            
            obj.type = type;
            obj.manufracturer = manufracturer;
            obj.abbeGrouping = abbeGrouping;
            obj.nd = nd;
            obj.ne = ne;
            obj.vd = vd;
            obj.ve = ve;
            obj.sellmeier = sellmeier;
        end
    end
    
    methods (Static)
        function obj = GlassFromDB(tableSingleRow)
            % GlassFromDB Construct an instance of this Glass Class.
            % 
            %   GlassFromDB(searchTableSingleRow)
            
            % height of input table must be 1
            if height(tableSingleRow) ~= 1
                error('GlassFromDB:InputDataSize',...
                    'tableSingleRow must have a height of 1.')
            end
            
            % fetch data from single table row
            type = tableSingleRow.('GlassType');
            manufracturer = tableSingleRow.('Mfg');
            abbeGrouping = tableSingleRow.('AbbeGroupings');
            nd = tableSingleRow.('nd1');
            ne = tableSingleRow.('ne');
            vd = tableSingleRow.('vd1');
            ve = tableSingleRow.('ve');
            sellmeier =...
                [tableSingleRow.('B1'), tableSingleRow.('B2'),...
                tableSingleRow.('B3'), tableSingleRow.('C1'),...
                tableSingleRow.('C2'), tableSingleRow.('C3')];
            
            % construct the glass object from the table data
            obj = Glass(type,manufracturer,abbeGrouping,...
                            nd,ne,vd,ve,sellmeier);
        end
    end
end

