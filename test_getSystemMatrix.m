function tests = test_getSystemMatrix
    tests = functiontests(localfunctions);
end

function test_getSystemMatrix_biConvex(testCase)

    surface1 = Surface3D([0,0,0], 40e-3 ,1.5);
    surface2 = Surface3D([0,0,60e-3], -40e-3 ,1.5);
    surface3 = Surface3D([0,0,100e-3], inf ,1);
    
    ns = [1.0, 1.5, 1.0, 1.0];
    distances  = [10e-3, 20e-3, 100e-3];
    
    system = [surface1, surface2, surface3];
    
%     figure(1);
%     plotSurfaces3D2D(system);
    
    [~, ~, systemMatrix] =...
        getSystemMatrix(system,distances,ns);

    
    verifyEqual(testCase, systemMatrix, [0.833333,-0.02291671;...
        13.3333, 0.833333],'RelTol',0.0001)

end


function test_getSystemMatrix_biConvex2(testCase)

    surface1 = Surface3D([0,0,-52e-3+35e-3], 52e-3 ,1.5);
    surface2 = Surface3D([0,0,52e-3], -52e-3 ,1.5);
    surface3 = Surface3D([0,0,200e-3], inf ,1);
    
    ns = [1.0, 1.680, 1.0, 1.0];
    distances  = [10e-3, 35e-3, 100e-3];
    
    system = [surface1, surface2, surface3];
    
%     figure(4);
%     plotSurfaces3D2D(system);
    
    [surfaceMat, translationMat, systemMatrix] =...
        getSystemMatrix(system,distances,ns);

    
    verifyEqual(testCase, systemMatrix, [0.727564,-0.0225912;...
        20.8333, 0.727564],'RelTol',0.0001)

end

function test_getSystemMatrix_meniscusConvex(testCase)

    surface1 = Surface3D([0,0,-30e-3], 30e-3 ,1.5);
    surface2 = Surface3D([0,0,0], 30e-3 ,1.5);
    surface3 = Surface3D([0,0,200e-3], inf ,1);
    
    ns = [1.0, 1.6, 1.3, 1.0];
    distances  = [10e-3, 30e-3, 100e-3];
    
    system = [surface1, surface2, surface3];
    
%     figure(5);
%     plotSurfaces3D2D(system);
    
    [surfaceMat, translationMat, systemMatrix] =...
        getSystemMatrix(system,distances,ns);

    verifyEqual(testCase, systemMatrix, [1.1875,-0.01375;...
        18.75, 0.625],'RelTol',0.0001)

end


function test_getSystemMatrix_meniscusConcave(testCase)

    surface1 = Surface3D([0,0,-50e-3], 50e-3 ,1.5);
    surface2 = Surface3D([0,0,65e-3], -50e-3 ,1.5);
    surface3 = Surface3D([0,0,300e-3], inf ,1);
    
    ns = [1.0, 1.626, 1.0, 1.0];
    distances  = [0e-3, 15e-3, 230e-3];
    
    system = [surface1, surface2, surface3];
    
%     figure(9);
%     plotSurfaces3D2D(system);
    
    [surfaceMat, translationMat, systemMatrix] =...
        getSystemMatrix(system,distances,ns);

    verifyEqual(testCase, systemMatrix, [0.884502,-0.023594;...
        9.22509, 0.884502],'RelTol',0.0001)

end


function test_getSystemMatrix_biConcave(testCase)

    surface1 = Surface3D([0,0,0], -40e-3 ,1.5);
    surface2 = Surface3D([0,0,90e-3], 40e-3 ,1.5);
    surface3 = Surface3D([0,0,100e-3], inf ,1);
    
    ns = [1.0, 1.5, 1.0, 1.0];
    distances  = [10e-3, 10e-3, 100e-3];
    
    system = [surface1, surface2, surface3];
    
%     figure(2);
%     plotSurfaces3D2D(system);
    
    [surfaceMat, translationMat, systemMatrix] =...
        getSystemMatrix(system,distances,ns);

    
    verifyEqual(testCase, systemMatrix, [1.08333,0.0260417;...
        6.66667, 1.08333],'RelTol',0.0001)

end


function test_getSystemMatrix_glasSphere(testCase)

    surface1 = Surface3D([0,0,0], +20e-3 ,1.7);
    surface2 = Surface3D([0,0,0], -20e-3 ,1.7);
    surface3 = Surface3D([0,0,100e-3], inf ,1);
    
    ns = [1.0, 1.7, 1.0, 1.0];
    distances  = [0e-3, 40e-3, 100e-3];
    
    system = [surface1, surface2, surface3];
    
%     figure(7);
%     plotSurfaces3D2D(system);
    
    [surfaceMat, translationMat, systemMatrix] =...
        getSystemMatrix(system,distances,ns);
% 
%     
    verifyEqual(testCase, systemMatrix, [0.176471,-0.0411765;...
        23.5294, 0.176471],'RelTol',0.0001)

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
    
%     figure(3);
%     plotSurfaces3D2D(system);
%     
    [surfaceMat, translationMat, systemMatrix] =...
        getSystemMatrix(system,distances,ns);
% 
%     
    verifyEqual(testCase, systemMatrix, [0.265182,-0.0393734;...
        22.9221, 0.367599],'RelTol',0.0001)

end



