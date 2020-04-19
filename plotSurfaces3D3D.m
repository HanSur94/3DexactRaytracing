function [plotHandle] = plotSurfaces3D3D(system, distances)
%PLOTSURFACES3D3D will plot the surfaces of the optical system in 3D space.
%
%   [plotHandle] = plotSurfaces3D3D(system)

    z2 = system(1,2).radius - system(1,1).radius + distances(1,2)
    z1 = ((system(1,2).radius)^2-(system(1,1).radius)^2-(z2)^2)/(2*z2)
    R = sqrt(system(1,1).radius^2-z1^2)
   
    hold on;
    for iSystem = 1:1:size(system,2)
        
  
        
        numberOfRads = 50;
        [xCoords, yCoords, zCoords] = sphere(numberOfRads);
        
        xCoords = xCoords * system(1,iSystem).radius;
        yCoords = yCoords * system(1,iSystem).radius;
        zCoords = zCoords * system(1,iSystem).radius;
        


        if system(1,iSystem).radius > 0
            zCoords(zCoords > -z1) = NaN;
        else
            zCoords(zCoords < -z2-z1) = NaN;
        end
        
        xCoords = xCoords + system(1,iSystem).origin(1);
        yCoords = yCoords + system(1,iSystem).origin(2);
        zCoords = zCoords + system(1,iSystem).origin(3);

        plotHandle = surf(xCoords, yCoords, zCoords,'EdgeColor',...
            'none', 'FaceLighting','phong', 'FaceColor',...
            'interp','FaceColor',[0.3010 0.7450 0.9330],...
            'SpecularStrength', 1, 'FaceAlpha',0.5, 'EdgeAlpha',0.5 );
        xlabel('x')
        ylabel('y')
        zlabel('z')
        xlim([-0.05,0.05])
        ylim([-0.05,0.05])
        zlim([-0.05,0.05])
        grid on;
    end
    hold off;


end

