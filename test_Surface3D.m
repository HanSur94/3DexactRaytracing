function tests = test_Surface3D
    tests = functiontests(localfunctions);
end

%% testing normal numeric input

function testSurface3D_numeric(testCase)

    surface3d = Surface3D([1,-2,5.5], 4, 1);

    origin = [1,-2,5.5];
    radius = 4;


    verifyEqual(testCase,surface3d.origin,origin);
    verifyEqual(testCase,surface3d.radius,radius);
    verifyEqual(testCase,surface3d.n,1);
    
end

%% testing NaN & Inf Input

function testSurface3D_nan(testCase)

    verifyError(testCase, @()Surface3D([NaN,1,2], 0.557021,1),...
       'Surface3D:InputDatatype');
    verifyError(testCase, @()Surface3D([0,1,0], NaN,1),...
       'Surface3D:InputDatatype');
    verifyError(testCase, @()Surface3D([0,1,0], 1,NaN),...
       'Surface3D:InputDatatype');
  
end

function testSurface3D_inf(testCase)

    surface3d = Surface3D([1,-2,5.5], inf, 1);
    origin = [1,-2,5.5];
    radius = inf;
    
        verifyEqual(testCase,surface3d.origin,origin);
    verifyEqual(testCase,surface3d.radius,radius);
    verifyEqual(testCase,surface3d.n,1);

    verifyError(testCase, @()Surface3D([inf,1,0], 1,1),...
       'Surface3D:InputDatatype');

   verifyError(testCase, @()Surface3D([0,1,0], 1,inf),...
       'Surface3D:InputDatatype');
   
end


%% testing imaginary

function testSurface3D_imag(testCase)

   verifyError(testCase, @()Surface3D([1i,1,2], 0.557021,1),...
       'Surface3D:InputDatatype');
   verifyError(testCase, @()Surface3D([1,1,2], 1i,1),...
       'Surface3D:InputDatatype');
   verifyError(testCase, @()Surface3D([1,1,2],1, 1i),...
       'Surface3D:InputDatatype');
end


%% testing input size


function testRay3D_inputSize(testCase)

   verifyError(testCase, @()Surface3D([1,2], 0,1),...
       'Surface3D:InputDataSize');
   verifyError(testCase, @()Surface3D(1, 0,1),...
       'Surface3D:InputDataSize');
   verifyError(testCase, @()Surface3D([1,2,3,4], 0.557021,1),...
       'Surface3D:InputDataSize');
   verifyError(testCase, @()Surface3D([1,2,3], [0.557021,1],1),...
       'Surface3D:InputDataSize');
   verifyError(testCase, @()Surface3D([1,2,3], [0.557021,1], [1,2]),...
       'Surface3D:InputDataSize');
   verifyError(testCase, @()Surface3D([1,2,3], [0.557021,1], [1;3]),...
       'Surface3D:InputDataSize');
end

%% testing n greater 0

function testSurface3D_nGreater0(testCase)

   verifyError(testCase, @()Surface3D([1,2,3], 0,-1),...
       'Surface3D:InputDatatype');
   verifyError(testCase,  @()Surface3D([1,2,3], 0,0),...
       'Surface3D:InputDatatype');
   verifyError(testCase,  @()Surface3D([1,2,3], 0,-0.0000001),...
       'Surface3D:InputDatatype');

end





