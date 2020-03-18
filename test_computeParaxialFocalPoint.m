function tests = test_computeParaxialFocalPoint
    tests = functiontests(localfunctions);
end

function test_computeParaxialFocalPoint_biConvex(testCase)

    surface1 = Surface3D([0,0,0], 40e-3 ,1.5);
    surface2 = Surface3D([0,0,60e-3], -40e-3 ,1.5);
    surface3 = Surface3D([0,0,100e-3], inf ,1);
    
    ns = [1.0, 1.5, 1.0, 1.0];
    distances  = [10e-3, 20e-3, 100e-3];
    
    system = [surface1, surface2, surface3];
    
    
    [~, ~, systemMatrix] =...
        getSystemMatrix(system,distances,ns);
    
    [oF,iF] = computeParaxialFocalPoint(systemMatrix,ns);

    
    verifyEqual(testCase, [oF, iF], [-36.36, 36.36],'RelTol',0.001)

end


function test_computeParaxialFocalPoint_biConvex2(testCase)

    surface1 = Surface3D([0,0,-52e-3+35e-3], 52e-3 ,1.5);
    surface2 = Surface3D([0,0,52e-3], -52e-3 ,1.5);
    surface3 = Surface3D([0,0,200e-3], inf ,1);
    
    ns = [1.0, 1.680, 1.0, 1.0];
    distances  = [10e-3, 35e-3, 100e-3];
    
    system = [surface1, surface2, surface3];
    
    [~, ~, systemMatrix] =...
        getSystemMatrix(system,distances,ns);

    [oF,iF] = computeParaxialFocalPoint(systemMatrix,ns);
    
    verifyEqual(testCase, [oF, iF], [-32.21,32.21],'RelTol',0.001)

end


function test_computeParaxialFocalPoint_meniscusConvex(testCase)

    surface1 = Surface3D([0,0,-30e-3], 30e-3 ,1.5);
    surface2 = Surface3D([0,0,0], 30e-3 ,1.5);
    surface3 = Surface3D([0,0,200e-3], inf ,1);
    
    ns = [1.0, 1.6, 1.3, 1.0];
    distances  = [10e-3, 30e-3, 100e-3];
    
    system = [surface1, surface2, surface3];
    
    [~, ~, systemMatrix] =...
        getSystemMatrix(system, distances, ns);

    [oF,iF] = computeParaxialFocalPoint(systemMatrix,ns);
    
    verifyEqual(testCase, [oF, iF], [-86.36,59.09],'RelTol',0.001)

end


function test_computeParaxialFocalPoint_meniscusConcave(testCase)

    surface1 = Surface3D([0,0,-50e-3], 50e-3 ,1.5);
    surface2 = Surface3D([0,0,65e-3], -50e-3 ,1.5);
    surface3 = Surface3D([0,0,300e-3], inf ,1);
    
    ns = [1.0, 1.626, 1.0, 1.0];
    distances  = [0e-3, 15e-3, 230e-3];
    
    system = [surface1, surface2, surface3];
    
    [~, ~, systemMatrix] =...
        getSystemMatrix(system, distances, ns);

    [oF,iF] = computeParaxialFocalPoint(systemMatrix,ns);
    
    verifyEqual(testCase, [oF, iF], [-37.49,37.49],'RelTol',0.001)

end


function test_computeParaxialFocalPoint_biConcave(testCase)

    surface1 = Surface3D([0,0,0], -40e-3 ,1.5);
    surface2 = Surface3D([0,0,90e-3], 40e-3 ,1.5);
    surface3 = Surface3D([0,0,100e-3], inf ,1);
    
    ns = [1.0, 1.5, 1.0, 1.0];
    distances  = [10e-3, 10e-3, 100e-3];
    
    system = [surface1, surface2, surface3];
    
    [~, ~, systemMatrix] =...
        getSystemMatrix(system, distances, ns);

    [oF,iF] = computeParaxialFocalPoint(systemMatrix,ns);
    
    verifyEqual(testCase, [oF, iF], [41.60,-41.60],'RelTol',0.001)
end


function test_computeParaxialFocalPoint_glasSphere(testCase)

    surface1 = Surface3D([0,0,0], +20e-3 ,1.7);
    surface2 = Surface3D([0,0,0], -20e-3 ,1.7);
    surface3 = Surface3D([0,0,100e-3], inf ,1);
    
    ns = [1.0, 1.7, 1.0, 1.0];
    distances  = [0e-3, 40e-3, 100e-3];
    
    system = [surface1, surface2, surface3];
    
    [~, ~, systemMatrix] =...
        getSystemMatrix(system, distances, ns);

    [oF,iF] = computeParaxialFocalPoint(systemMatrix,ns);
    
    verifyEqual(testCase, [oF, iF], [-4.29,4.29],'RelTol',0.001)

end


function test_getSystemMatrix_twoPlanoConvex(testCase)

    surface1 = Surface3D([0,0,0], inf ,1.5);
    surface2 = Surface3D([0,0,-15.46e-3], -19.7e-3 ,1.5);
    surface3 = Surface3D([0,0,21.16e-3+4.24e-3+17.51e-3], 17.51e-3 ,1);
    surface4 = Surface3D([0,0,21.16e-3+4.24e-3+2.97e-3], inf ,1);
    surface5 = Surface3D([0,0,100e-3], inf ,1);
    
    ns = [1.0, 1.517, 1.0, 1.517, 1.0, 1.0];
    distances  = [0e-3, 4.24e-3, 21.16e-3, 2.97e-3, 100e-3];
    
    system = [surface1, surface2, surface3, surface4, surface5];
    
    [~, ~, systemMatrix] =...
        getSystemMatrix(system, distances, ns);

    [oF,iF] = computeParaxialFocalPoint(systemMatrix,ns);
    
    verifyEqual(testCase, [oF, iF], [-6.74,9.34],'RelTol',0.001)

end
