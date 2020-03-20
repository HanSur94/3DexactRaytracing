function tests = test_computeLSA
    tests = functiontests(localfunctions);
end

function test_computeLSA_planoConvex(~)

clear all
clc
close all

    % setup system
    surface1 = Surface3D([0, 0, 30e-3], 20e-3, 1.5);
    surface2 = Surface3D([0, 0, 15e-3], inf, 1.5);
    surface3 = Surface3D([0,0, 100e-3], inf, 1);
    
    system = [surface1, surface2, surface3];
    
    load glassDB;
    
    P_BK7 = Glass.GlassFromDB(searchGlassDB('P-BK7','GlassType',glassDB))
    
    medias = {1.0, P_BK7, 1.0 ,1.0}
    
    wavelengths = [380, 555, 780]*1e-9;
    
    ns = medias2refractiveIndices(medias, wavelengths)
    
    distances = [10, 5, 85]*1e-3;
    
    raysIn = getRay3DBundle(31, [0,0], [-10,10]*1e-3, [0,0],...
        [0,0], [0,0],[1,1]);
    
     [tca, raySlopes] = computeTCA(system, raysIn, distances, medias, wavelengths)
     
     figure(1);
     plot(raySlopes(:,1),tca(:,1), 'b',...
         raySlopes(:,2),tca(:,2), 'g',...
         raySlopes(:,3),tca(:,3), 'r');
     
    grid on;
    grid minor;
    xlabel('Ray slope tan(u) in [rad]');
    ylabel('Transvers sph. aberration TSA in [m]');
    title('Transverse Spherical Aberration - TSA');
    
    raysOut380 = raytraceSystem3D(raysIn, system, ns(1,:), distances)
    raysOut555 = raytraceSystem3D(raysIn, system, ns(2,:), distances)
    raysOut780 = raytraceSystem3D(raysIn, system, ns(3,:), distances)
    
    figure(2)
    plotSurfaces3D2D(system,'black')
    plotRays3D2D(raysOut380, distances, 'Color', 'blue')
    plotRays3D2D(raysOut555, distances, 'Color', 'green')
    plotRays3D2D(raysOut780, distances, 'Color', 'red')
    
    
    %figure;
    %[tsa, ~] = computeTSA(system, raysIn, distances, ns,'plot','Color','red');
    

end
