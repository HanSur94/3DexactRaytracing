function verifyRay(rayToTest, referenceRay, relTol, testCase)
%This function will use the verifyEqual function and compare to rays.
%
%   verifyRay(rayToTest, referenceRay, relTol, testCase)

    verifyEqual(testCase, rayToTest.origin,...
        referenceRay.origin, 'RelTol',relTol)

    verifyEqual(testCase, rayToTest.direction,...
        referenceRay.direction, 'RelTol',relTol)

    verifyEqual(testCase,rayToTest.n,...
        referenceRay.n, 'RelTol',relTol)
    
    verifyEqual(testCase,rayToTest.distanceToIntersection,...
        referenceRay.distanceToIntersection, 'RelTol',relTol)

end

