 function tests = test_plotSurfaces3D3D
    tests = functiontests(localfunctions);
end

function test_plotSurfaces3D3D_SingleSurface(~)
 close all 
 clc
    % def first Surface
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    surface2 = Surface3D([0,0,5e-3], -10e-3 ,1.5);
    surface3 = Surface3D([0,0,27e-3], inf ,1);
    
    opticalSystem = [surface1,surface2];
    distances = [10e-3,5e-3,12e-3];
    
    figure(1);
    plotSurfaces3D3D(opticalSystem, distances);
    
end
