function tests = test_raytraceSystem3D
    tests = functiontests(localfunctions);
end

function test_raytraceSystem3D_biConvexLens_singleRay(testCase)
    
    % create single ray 
    raysIn = Ray3D([2e-3, 1e-3, 2e-3], [0.2,0.2,0], 1);
    
    % create many rays
    numberOfRays = 10;
    raysInCell = cell(numberOfRays,1);
    
    for iSurface = 1:1:numberOfRays
        raysInCell{iSurface,1} = raysIn;
    end

    % create surfaces
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    surface2 = Surface3D([0,0,5e-3], -10e-3 ,1.5);
    surface3 = Surface3D([0,0,27e-3], inf ,1);
    
    % create system
    system = [surface1, surface2, surface3];
    distances = [10e-3,5e-3,12e-3];
    refractiveIndices = [1.0,1.5,1.0];
    
    rounding = 100;
    
    % expected output1 rays and round
    raysOut1 = Ray3D([3.78485e-3, 2.78485e-3, 0.559848e-3],...
        [0.064202,0.0824673,0.994524], 1.5);
    
    raysOut2 = Ray3D(round([3.98453e-3, 3.04134e-3, -1.34704e-3],rounding),...
        round([-0.135022,-0.052866,0.989431],rounding), 1);
    
    raysOut3 = Ray3D([2.16314e-3, 2.32819e-3, 0],...
        [-0.135022,-0.052866,0.989431], 1);
    
    raysOutCell = cell(numberOfRays,3);
    
    for iRay = 1:1:numberOfRays
        raysOutCell{1,1} = raysOut1;
        raysOutCell{1,2} = raysOut2;
        raysOutCell{1,3} = raysOut3;
    end
    % raytrace through system
    tic;
    raysOut = raytraceSystem3D(raysInCell, system, refractiveIndices, distances);
    toc;
    
    for iRay = 1:1:numberOfRays
        verifyRay2(raysOut{iRay,1}, raysInCell{1,1}, 0.001, testCase)
        verifyRay2(raysOut{iRay,2}, raysOut1, 0.001, testCase)
        verifyRay2(raysOut{iRay,3}, raysOut2, 0.001, testCase)
        verifyRay2(raysOut{iRay,4}, raysOut3, 0.001, testCase)
    end

end


function verifyRay(rayToTest, origin, direction, n, relTol, testCase)

    verifyEqual(testCase, rayToTest.origin,...
        origin, 'RelTol',relTol)

    verifyEqual(testCase, rayToTest.direction,...
        direction, 'RelTol',relTol)

    verifyEqual(testCase,rayToTest.n,...
        n, 'RelTol',relTol)

end


function verifyRay2(rayToTest, referenceRay, relTol, testCase)

    verifyEqual(testCase, rayToTest.origin,...
        referenceRay.origin, 'RelTol',relTol)

    verifyEqual(testCase, rayToTest.direction,...
        referenceRay.direction, 'RelTol',relTol)

    verifyEqual(testCase,rayToTest.n,...
        referenceRay.n, 'RelTol',relTol)

end