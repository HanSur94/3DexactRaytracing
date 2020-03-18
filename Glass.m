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
            %GLASS Construct an instance of this class
            % 
            %   Glass(type,manufracturer,abbeGrouping,...
            %                nd,ne,vd,ve,sellmeier)
            
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
end

