function tests = test_Ray3D
    tests = functiontests(localfunctions);
end

%% testing normal numeric input

function testRay3D_1(testCase)

    ray3d_1 = Ray3D([1,-2,5.5], [0.557021,-0.742794,0], 1);

    origin_1 = [1,-2,5.5];
    direction_1 = [0.557021,-0.742794,0];
    direction_1 = [0.557021,-0.742794,sqrt(1-direction_1(1,1)^2-...
                        direction_1(1,2)^2)];
                


    verifyEqual(testCase,ray3d_1.origin,origin_1);
    verifyEqual(testCase,ray3d_1.direction,direction_1);
    verifyEqual(testCase,ray3d_1.n,1);
    
end
%% testing NaN & Inf Input

function testRay3D_nan(testCase)
   
    ray3d_1 = Ray3D([NaN,1,2], [0.557021,0,0], 1);
   
    origin = [NaN,NaN,NaN];
    direction = [NaN,NaN,NaN];

    verifyEqual(testCase,ray3d_1.origin,origin);
    verifyEqual(testCase,ray3d_1.direction,direction);
    verifyEqual(testCase,ray3d_1.n,NaN);

    ray3d_1 = Ray3D([0,1,0], [0.557021,NaN,0], 1);

    verifyEqual(testCase,ray3d_1.origin,origin);
    verifyEqual(testCase,ray3d_1.direction,direction);
    verifyEqual(testCase,ray3d_1.n,NaN);
    
    ray3d_1 = Ray3D([0,1,0], [0.557021,0,0], NaN);
    
    verifyEqual(testCase,ray3d_1.origin,origin);
    verifyEqual(testCase,ray3d_1.direction,direction);
    verifyEqual(testCase,ray3d_1.n,NaN);
  
end

function testRay3D_inf(testCase)

    verifyError(testCase, @()Ray3D([inf,1,0], [0.557021,0,0],1),...
       'Ray3D:InputDatatype');
   verifyError(testCase, @()Ray3D([0,1,0], [0.557021,inf,0],1),...
       'Ray3D:InputDatatype');
   verifyError(testCase, @()Ray3D([0,1,0], [0.557021,0,0],inf),...
       'Ray3D:InputDatatype');
   
end


%% testing imaginary


function testRay3D_imag(testCase)

   verifyError(testCase, @()Ray3D([1i,1,2], [0.557021,0,0],1),...
       'Ray3D:InputDatatype');
   verifyError(testCase, @()Ray3D([1,1,2], [0.557021,1i,0],1),...
       'Ray3D:InputDatatype');
      verifyError(testCase, @()Ray3D([1,1,2], [0.557021,1i,0],1i),...
       'Ray3D:InputDatatype');
end

%% testing input size


function testRay3D_inputSize(testCase)

   verifyError(testCase, @()Ray3D([1,2], [0.557021,0,0], 1),...
       'Ray3D:InputDataSize');
   verifyError(testCase, @()Ray3D(1, [0.557021,1,0],1),...
       'Ray3D:InputDataSize');
   verifyError(testCase, @()Ray3D([1,2,3], 0.557021,1),...
       'Ray3D:InputDataSize');
   verifyError(testCase, @()Ray3D([1,2,3], [0.557021,1],1),...
       'Ray3D:InputDataSize');
  verifyError(testCase, @()Ray3D([1,2,3], [0.557021,1],[1,2,3]),...
       'Ray3D:InputDataSize');
   verifyError(testCase, @()Ray3D([1,2,3], [0.557021,1],[1;2;3]),...
       'Ray3D:InputDataSize');
end

%% testing input n > 0

function testRay3D_nGreater0(testCase)

   verifyError(testCase, @()Ray3D([1,2,0], [0.557021,0,0], 0),...
       'Ray3D:InputDatatype');
   verifyError(testCase, @()Ray3D([1,2,0], [0.557021,0,0], -1),...
       'Ray3D:InputDatatype');
   verifyError(testCase, @()Ray3D([1,2,0], [0.557021,0,0], -0.00001),...
       'Ray3D:InputDatatype');

end

%% testing direction(1,3)

function testSurface3D_direction(testCase)

   verifyError(testCase, @()Ray3D([1,2,3], [0.8,0.8,0],1),...
       'Ray3D:InputDatatype');
   verifyError(testCase,  @()Ray3D([1,2,3], [-0.8,-0.8,0],1),...
       'Ray3D:InputDatatype');
   verifyError(testCase,  @()Ray3D([1,2,3], [-0.8,0.8,0],1),...
       'Ray3D:InputDatatype');

end


