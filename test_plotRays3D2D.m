function tests = test_plotRays3D2D
    tests = functiontests(localfunctions);
end

function test_plotRays3D2D_withRaytraceSurface(~)

    numberOfRays = 1;
    
    raysIn = Ray3D([0e-3, 0e-3, -2e-3], [0,0.2,0.8], 1);
    raysInCell = cell(numberOfRays,1);
    
    for iRay = 1:1:numberOfRays
        raysInCell{iRay,1} = raysIn;
    end

    % def first Surface
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    surface2 = Surface3D([0,0,5e-3], -10e-3 ,1.5);
    surface3 = Surface3D([0,0,27e-3], inf ,1);

    opticalSystem = [surface1, surface2, surface3];
    distances = [10e-3,5e-3,12e-3];

    [raysInCell, output] =...
        raytraceSurface3D(raysInCell, surface1, 1, 1.5, 10e-3);
    [output, output2] =...
        raytraceSurface3D(output, surface2, 1.5, 1, 5e-3);
    [output2, output3] =...
        raytraceSurface3D(output2, surface3, 1, 1, 12e-3);
    
    rays = [raysInCell, output, output2, output3];
    
    figure(1);
    [~] = plotSurfaces3D2D(opticalSystem,'Color', 'black');
    [~] = plotRays3D2D(rays, distances,'Color', 'red');
    
    
end

function test_plotRays3D2D_withRaytraceSystem(~)

    numberOfRays = 1;
    
    raysIn = Ray3D([0e-3, 0e-3, -2e-3], [0,-0.2,0.8], 1);
    raysInCell = cell(numberOfRays,1);
    
    for iRay = 1:1:numberOfRays
        raysInCell{iRay,1} = raysIn;
    end

    % def first Surface
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    surface2 = Surface3D([0,0,5e-3], -10e-3 ,1.5);
    surface3 = Surface3D([0,0,27e-3], inf ,1);

    opticalSystem = [surface1, surface2, surface3];
    distances = [10e-3,5e-3,12e-3];

    [raysInCell, output] =...
        raytraceSurface3D(raysInCell, surface1, 1, 1.5, 10e-3);
    [output, output2] =...
        raytraceSurface3D(output, surface2, 1.5, 1, 5e-3);
    [output2, output3] =...
        raytraceSurface3D(output2, surface3, 1, 1, 12e-3);
    
    rays = [raysInCell, output, output2, output3];
    
    figure(2);
    [~] = plotSurfaces3D2D(opticalSystem, 'black');
    [~] = plotRays3D2D(rays, distances);
    [~] = plotRays3D2D(rays, distances,'Color','red');
    
end


function test_plotRays3D2D_withRaytraceSystem2(~)

    % get input rays
    raysIn = getRay3DBundle(20,[0,0],[0,0],[0,0],...
                    [0,0],[0.5,-0.5],[0,0]);

    % def first Surface
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    surface2 = Surface3D([0,0,5e-3], -10e-3 ,1.5);
    surface3 = Surface3D([0,0,30e-3+20e-3], 20e-3 ,1.5);
    surface4 = Surface3D([0,0,5e-3+20e-3], -10e-3 ,1.5);
    surface5 = Surface3D([0,0,27e-3+20e-3], inf ,1);
    
    opticalSystem = [surface1, surface2, surface3, surface4, surface5];
    distances = [10e-3,5e-3,15e-3,5e-3,12e-3];
    ns = [1, 1.5, 1, 1.5, 1, 1];
    
    rays = raytraceSystem3D(raysIn, opticalSystem, ns, distances);

    figure(3);
    [~] = plotSurfaces3D2D(opticalSystem, 'black');
    [~] = plotRays3D2D(rays, distances, 'Color', 'red');

    
end


function test_plotRays3D2D_notValidInput(testCase)
    
    numberOfRays = 1;
    
    raysIn = Ray3D([0e-3, 0e-3, -2e-3], [0,-0.2,0.8], 1);
    raysInCell = cell(numberOfRays,1);
    
    for iRay = 1:1:numberOfRays
        raysInCell{iRay,1} = raysIn;
    end

    % def first Surface
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    surface2 = Surface3D([0,0,5e-3], -10e-3 ,1.5);
    surface3 = Surface3D([0,0,27e-3], inf ,1);

    distances = [10e-3,5e-3,12e-3];

    [raysInCell, output] =...
        raytraceSurface3D(raysInCell, surface1, 1, 1.5, 10e-3);
    [output, output2] =...
        raytraceSurface3D(output, surface2, 1.5, 1, 5e-3);
    [output2, output3] =...
        raytraceSurface3D(output2, surface3, 1, 1, 12e-3);
    
    rays = [raysInCell, output, output2, output3];

    verifyError(testCase,@()plotRays3D2D(rays, distances','Color','red'),...
        'plotRays3D2D:InputDataSize')
    
end