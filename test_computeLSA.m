function tests = test_computeLSA
    tests = functiontests(localfunctions);
end

function test_computeLSA_planoConvex(testCase)

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
    [lsa, ~, intersectionOpticalAxis] = computeLSA(system, raysIn, distances, ns, 'plot',...
        'Color', 'blue');
    
    lsaRef = [0, -0.0286079, -0.114672, -0.258923, -0.462618,...
        -0.727598, -1.05638, -1.45229, -1.91969, -2.46423,...
        -3.09331]'*1e-3;
    
    intersectionOpticalAxisRef = [36.6667, 36.6381, 36.552, 36.4077, 36.204,...
        35.9391, 35.6103, 35.2144, 34.747, 34.2024, 33.5734]'*1e-3;
    

    verifyEqual(testCase, lsa, lsaRef,'RelTol',0.0001)
    verifyEqual(testCase, intersectionOpticalAxis,...
        intersectionOpticalAxisRef,'RelTol',0.0001)
    
    
end


function test_computeLSA_planoConvex2(testCase)

    % setup system
    surface1 = Surface3D([0, 0, 10e-3], inf, 1.5);
    surface2 = Surface3D([0, 0, -5e-3], -20e-3, 1.5);
    surface3 = Surface3D([0,0, 100e-3], inf, 1);
    
    system = [surface1, surface2, surface3];
    
    ns = [1.0, 1.5, 1.0, 1.0];
    distances = [10, 5, (100-15)]*1e-3;
    
    raysIn = getRay3DBundle(11, [0,0], [0,10]*1e-3, [0,0],...
        [0,0], [0,0],[1,1]);

    [lsa, ~, intersectionOpticalAxis] = computeLSA(system, raysIn, distances, ns);
    
    lsaRef = [0, -0.112623, -0.451988, -1.02269, -1.83281,...
        -2.89455, -4.2255, -5.85056, -7.80545, -10.1433,...
        -12.9486]'*1e-3;
    
    intersectionOpticalAxisRef = [40, 39.8874, 39.548, 38.9773, 38.1672, 37.1054,...
        35.7745, 34.1494, 32.1945, 29.8567, 27.0514]'*1e-3;
    

    verifyEqual(testCase, lsa, lsaRef,'RelTol',0.0001)
    verifyEqual(testCase, intersectionOpticalAxis,...
        intersectionOpticalAxisRef,'RelTol',0.0001)
    
end

function test_computeLSA_doublet(testCase)

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

    [lsa, ~, intersectionOpticalAxis] = computeLSA(system, raysIn, distances, ns);
    
    lsaRef = [0, -0.00447098, -0.0165481, -0.0319605, -0.04262,...
        -0.0347926, 0.0144488]'*1e-3;
    
    intersectionOpticalAxisRef = [37.3587, 37.3542, 37.3421, 37.5526, 37.316,...
        37.3239, 37.3731]'*1e-3;
    

    verifyEqual(testCase, lsa, lsaRef,'RelTol',0.0001)
    verifyEqual(testCase, intersectionOpticalAxis,...
        intersectionOpticalAxisRef,'RelTol',0.01)
     
    
end


function test_computeLSA_singleConvex(testCase)

    % setup system
    surface1 = Surface3D([0, 0, 30e-3], 20e-3, 1.5);
    surface2 = Surface3D([0,0, 100e-3], inf, 1);
    
    system = [surface1, surface2];
    
    ns = [1.0, 1.5, 1.0];
    distances = [10, 90]*1e-3;
    
    raysIn = getRay3DBundle(6, [0,0], [0,5]*1e-3, [0,0],...
        [0,0], [0,0],[1,1]);

    [lsa, ~, intersectionOpticalAxis] = computeLSA(system, raysIn, distances, ns);
    
    lsaRef = [0, -0.0333496, -0.133594, -0.301326,...
        -0.537556, -0.843747]'*1e-3;
    
    intersectionOpticalAxisRef = [60, 59.9667, 59.8664, 59.6987, 59.4624, 59.1563]'*1e-3;
    

    verifyEqual(testCase, lsa, lsaRef,'RelTol',0.0001)
    verifyEqual(testCase, intersectionOpticalAxis,...
        intersectionOpticalAxisRef,'RelTol',0.0001)
    
end


function test_computeLSA_biConvex(testCase)

    % setup system
    surface1 = Surface3D([0, 0, 30e-3], 20e-3, 1.5);
    surface2 = Surface3D([0, 0, 5e-3], -10e-3, 1.5);
    surface3 = Surface3D([0,0, 100e-3], inf, 1);
    
    system = [surface1, surface2, surface3];
    
    ns = [1.0, 1.5, 1.0, 1.0];
    distances = [10, 5, (100-15)]*1e-3;
    
    raysIn = getRay3DBundle(11, [0,0], [0,5]*1e-3, [0,0],...
        [0,0], [0,0],[1,1]);

    [lsa, ~, intersectionOpticalAxis] = computeLSA(system, raysIn, distances, ns);
    
    lsaRef = [0, -0.0367786, -0.147978, -0.336274, -0.606423,...
        -0.965788, -1.42527, -2.001, -2.71749, -3.61442, -4.76383]'*1e-3;
    
    intersectionOpticalAxisRef = [12.9412, 12.9044, 12.7932, 12.6049, 12.3348,...
        11.9754, 11.5159, 10.9402, 10.2237, 9.32676, 8.17735]'*1e-3;
    

    verifyEqual(testCase, lsa, lsaRef,'RelTol',0.0001)
    verifyEqual(testCase, intersectionOpticalAxis,...
        intersectionOpticalAxisRef,'RelTol',0.0001)
    
end

