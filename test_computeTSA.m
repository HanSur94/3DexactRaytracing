function tests = test_computeTSA
    tests = functiontests(localfunctions);
end

function test_computeTSA_planoConvex(testCase)

    % setup system
    surface1 = Surface3D([0, 0, 30e-3], 20e-3, 1.5);
    surface2 = Surface3D([0, 0, 15e-3], inf, 1.5);
    surface3 = Surface3D([0,0, 100e-3], inf, 1);
    
    system = [surface1, surface2, surface3];
    
    ns = [1.0, 1.5, 1.0, 1.0];
    distances = [10, 5, (100-15)]*1e-3;
    
    raysIn = getRay3DBundle(11, [0,0], [0,10]*1e-3, [0,0],...
        [0,0], [0,0],[1,1]);
    
    figure;
    [tsa, ~] = computeTSA(system, raysIn, distances, ns,'plot','Color','red');
    
    tsaRef = [0, -0.000716018, -0.00576005, -0.0196227, -0.0471348,...
        -0.0936764, -0.165442, -0.269794, -0.415756, -0.614736,...
        -0.88162]'*1e-3;

    verifyEqual(testCase, tsa, tsaRef,'RelTol',0.0001)
    
end


function test_computeTSA_planoConvex2(testCase)

    % setup system
    surface1 = Surface3D([0, 0, 10e-3], inf, 1.5);
    surface2 = Surface3D([0, 0, -5e-3], -20e-3, 1.5);
    surface3 = Surface3D([0,0, 100e-3], inf, 1);
    
    system = [surface1, surface2, surface3];
    
    ns = [1.0, 1.5, 1.0, 1.0];
    distances = [10, 5, (100-15)]*1e-3;
    
    raysIn = getRay3DBundle(11, [0,0], [0,10]*1e-3, [0,0],...
        [0,0], [0,0],[1,1]);

    [tsa, ~] = computeTSA(system, raysIn, distances, ns);
    
    tsaRef = [0,-0.00282176, -0.0227999, -0.0782602, -0.19007,...
        -0.383481, -0.690899, -1.15642, -1.84394, -2.85317,...
        -4.35526]'*1e-3;

    verifyEqual(testCase, tsa, tsaRef,'RelTol',0.0001)
    
end

function test_computeTSA_doublet(testCase)

    % setup system
    surface1 = Surface3D([0, 0, 37.11e-3], 27.11e-3, 1.5);
    surface2 = Surface3D([0, 0, -0.25e-3], -15.25e-3, 1.5);
    surface3 = Surface3D([0,0, -25.75e-3], -45.75e-3, 1);
    surface4 = Surface3D([0,0, 100e-3], inf, 1);
    
    system = [surface1, surface2, surface3, surface4];
    
    ns = [1.0, 1.5, 1.6, 1.0, 1.0];
    distances = [10, 5, 5, 80]*1e-3;
    
    raysIn = getRay3DBundle(7, [0,0], [0,6]*1e-3, [0,0],...
        [0,0], [0,0],[1,1]);

    [tsa, ~] = computeTSA(system, raysIn, distances, ns);
    
    tsaRef = [0, -0.000107763,-0.000798549,-0.0023173,-0.00412897,...
        -0.00422309, 0.00210885]'*1e-3;

     verifyEqual(testCase, tsa, tsaRef,'RelTol',0.0001)
     
    
end


function test_computeTSA_singleConvex(testCase)

    % setup system
    surface1 = Surface3D([0, 0, 30e-3], 20e-3, 1.5);
    surface2 = Surface3D([0,0, 100e-3], inf, 1);
    
    system = [surface1, surface2];
    
    ns = [1.0, 1.5, 1.0];
    distances = [10, 90]*1e-3;
    
    raysIn = getRay3DBundle(6, [0,0], [0,5]*1e-3, [0,0],...
        [0,0], [0,0],[1,1]);

    [tsa, ~] = computeTSA(system, raysIn, distances, ns);
    
    tsaRef = [0, -0.000556367, -0.00447055, -0.0151999,...
        -0.0364084, -0.0720891]'*1e-3;

    verifyEqual(testCase, tsa, tsaRef,'RelTol',0.0001)
    
end


function test_computeTSA_biConvex(testCase)

    % setup system
    surface1 = Surface3D([0, 0, 30e-3], 20e-3, 1.5);
    surface2 = Surface3D([0, 0, 5e-3], -10e-3, 1.5);
    surface3 = Surface3D([0,0, 100e-3], inf, 1);
    
    system = [surface1, surface2, surface3];
    
    ns = [1.0, 1.5, 1.0, 1.0];
    distances = [10, 5, (100-15)]*1e-3;
    
    raysIn = getRay3DBundle(11, [0,0], [0,5]*1e-3, [0,0],...
        [0,0], [0,0],[1,1]);

    [tsa, ~] = computeTSA(system, raysIn, distances, ns);
    
    tsaRef = [0, -0.00130559, -0.0105802, -0.0365, -0.0893093,...
        -0.182053, -0.332577, -0.567149, -0.927747, -1.48891,...
        -2.40512]'*1e-3;

    verifyEqual(testCase, tsa, tsaRef,'RelTol',0.0001)
    
end
