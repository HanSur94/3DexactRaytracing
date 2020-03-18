function tests = test_plotSurfaces3D2D
    tests = functiontests(localfunctions);
end

function test_plotSurfaces3D2D_SingleSurface(~)

    % def first Surface
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    surface2 = Surface3D([0,0,5e-3], -10e-3 ,1.5);
    surface3 = Surface3D([0,0,27e-3], inf ,1);
    
    opticalSystem = [surface1, surface2, surface3];
    
    figure(1);
    plotSurfaces3D2D(opticalSystem,'Color','black');

    figure(2);
    plotSurfaces3D2D(opticalSystem);

end


function test_plotSurfaces3D2D_notValidInput(testCase)
    % not row vector
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    surface2 = Surface3D([0,0,5e-3], -10e-3 ,1.5);
    surface3 = Surface3D([0,0,27e-3], inf ,1);
    
    opticalSystem = [surface1; surface2; surface3];

    verifyError(testCase, @()plotSurfaces3D2D(opticalSystem,'black'),...
           'plotSurfaces3D2D:InputDataSize');
       
   % not a Surface3D object
       
   ray3d_1 = Ray3D([1,-2,5.5], [0.557021,-0.742794,0], 1);
       
   verifyError(testCase, @()plotSurfaces3D2D(ray3d_1,'Color','black'),...
           'plotSurfaces3D2D:InputDatatype');
end



