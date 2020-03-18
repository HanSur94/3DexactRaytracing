function tests = test_isSize
    tests = functiontests(localfunctions);
end

%% testing normal numeric input

function testIsSize(testCase)

    verifyEqual(testCase, isSize([1,2,3],1,3), 1);
    
    verifyEqual(testCase,isSize([1,inf,3], 1,3),1);
    
    verifyEqual(testCase,isSize([1,NaN,3], 1,3),1);
    
    verifyEqual(testCase,isSize(1, 1,1),1);
    
    verifyEqual(testCase,isSize([1,2], 1,1),0);
    
    verifyEqual(testCase,isSize([1,3], -1,-2),0);
    
end