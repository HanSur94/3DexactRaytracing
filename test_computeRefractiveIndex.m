function tests = test_computeRefractiveIndex
    tests = functiontests(localfunctions);
end

function test_computeRefractiveIndex_BK7(testCase)

    wavelength_d = 587.6e-9;
    wavelength_e = 546.07e-9;
    
    load glassDB.mat;
    
    results = searchGlassDB('BK7','GlassType',glassDB);
    P_BK7 = Glass.GlassFromDB(results(1,:));
    
    nd = computeRefractiveIndex(P_BK7,wavelength_d);
    ne = computeRefractiveIndex(P_BK7,wavelength_e);
    
    verifyEqual(testCase, [nd, ne], [P_BK7.nd, P_BK7.ne], 'RelTol', 0.0001);

end


function test_computeRefractiveIndex_Errors(testCase)

    wavelength = 546.07e-9*i;
    
    load glassDB.mat;
    
    results = searchGlassDB('BK7','GlassType',glassDB);
    P_BK7 = Glass.GlassFromDB(results(1,:));
    
    verifyError(testCase, @()computeRefractiveIndex(P_BK7,...
        wavelength), 'computeRefractiveIndex:InputDataType');
    
    verifyError(testCase, @()computeRefractiveIndex(P_BK7,...
        (wavelength:10e-9:700e-9)'), 'computeRefractiveIndex:InputDataSize');
    
    verifyError(testCase, @()computeRefractiveIndex(P_BK7,...
        'a'), 'computeRefractiveIndex:InputDataType');

end
