function tests = test_medias2refractiveIndices
    tests = functiontests(localfunctions);
end

function test_medias2refractiveIndices_BK7(testCase)

    load glassDB;
    results = searchGlassDB('BK7','GlassType',glassDB);
    P_BK7 = Glass.GlassFromDB(results(1,:)); 

    medias = {1.0, P_BK7, 1.0, 1.0};

    ns = medias2refractiveIndices(medias, 550e-9);

end


function test_medias2refractiveIndices_BK7_wavelengths(testCase)

    load glassDB;
    results = searchGlassDB('BK7','GlassType',glassDB);
    P_BK7 = Glass.GlassFromDB(results(1,:)) ;

    medias = {1.0, P_BK7, 1.0, 1.0};

    wavelengths = [380, 555, 780] * 1e-9;

    ns = medias2refractiveIndices(medias, wavelengths);

end
