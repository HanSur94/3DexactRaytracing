function tests = test_raytraceSurface3D
    tests = functiontests(localfunctions);
end


%% testing normal numeric input

function testSurface3D_numericSingleConvex(testCase)
    % create single ray
    rayInSingle = Ray3D([2e-3, 1e-3, 2e-3], [0.2,0.2,0], 1);
    rayInSingleCell = cell(1,1);
    rayInSingleCell{1,1} = rayInSingle;
    
    % create surface
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    
    % expected output ray and round
    rounding = 100;
    rayOutSingle = Ray3D(round([3.78485e-3, 2.78485e-3, 0.559848e-3],rounding),...
        round([0.064202,0.0824673,0.994524],5), 1.5);
    rayOutSingleCell = cell(1,1);
    rayOutSingleCell{1,1} = rayOutSingle;
    
    % expected input ray
    rayInSingleCellRef{1,1} = rayInSingle;
    rayInSingleCellRef{1,1}.distanceToIntersection = 8.92426e-3;
    
    % round the test output
    [rayInSingleCell, output] = raytraceSurface3D(rayInSingleCell, surface1, 1, 1.5, 10e-3);
    output{1,1}.direction = round(output{1,1}.direction,rounding);
    output{1,1}.origin = round(output{1,1}.origin,rounding);
    
    % set rel tol due to precision errors from matlab
    relTol = 0.0001;
    
    % test ray out
    verifyRay(output{1,1},rayOutSingleCell{1,1},relTol, testCase)
    % test ray in
    verifyRay(rayInSingleCell{1,1},rayInSingleCellRef{1,1},...
        relTol, testCase)
     
end


function testSurface3D_numericSingleConcave(testCase)
     rounding = 100;

    % create single ray
    rayInSingle = Ray3D([3.78485e-3, 2.78485e-3, 0.559848e-3],...
        [0.064202,0.0824673,0.994524], 1.5);

    rayInSingleCell = cell(1,1);
    rayInSingleCell{1,1} = rayInSingle;
    
    % create surface
    surface1 = Surface3D([0,0,5e-3], -10e-3 ,1.5);
    
    % expected output ray and round
   
    rayOutSingle = Ray3D(round([3.98453e-3, 3.04134e-3, -1.34704e-3],rounding),...
        round([-0.135022,-0.052866,0.989431],rounding), 1);
    rayOutSingleCell = cell(1,1);
    rayOutSingleCell{1,1} = rayOutSingle;
    
    
    % expected input ray
    rayInSingleCellRef{1,1} = rayInSingle;
    rayInSingleCellRef{1,1}.distanceToIntersection = 3.1128764833e-3;
    
    % round the test output
    [rayInSingleCell, output] = raytraceSurface3D(rayInSingleCell, surface1, 1.5, 1, 5e-3);
    output{1,1}.direction = round(output{1,1}.direction,rounding);
    output{1,1}.origin = round(output{1,1}.origin,rounding);
    
    % set rel tol due to precision errors from matlab
    relTol = 0.001;

        % test ray out
    verifyRay(output{1,1},rayOutSingleCell{1,1},relTol, testCase)
    % test ray in
    verifyRay(rayInSingleCell{1,1},rayInSingleCellRef{1,1},...
        relTol, testCase)

end

%% test with multiple rays through 1 convex surface

function testSurface3D_multipleRaysInConvex(testCase)

    numberOfRays = 10;

    % create single ray 
    raysIn = Ray3D([2e-3, 1e-3, 2e-3], [0.2,0.2,0], 1);
    raysInCell = cell(numberOfRays,1);
    for iRay = 1:1:numberOfRays
        raysInCell{iRay,1} = raysIn;
    end

    % create surface
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    
    % expected output ray and round
    rounding = 100;
    raysOut = Ray3D(round([3.78485e-3, 2.78485e-3, 0.559848e-3],rounding),...
        round([0.064202,0.0824673,0.994524],rounding), 1.5);
    raysOutCell = cell(numberOfRays,1);
    
    
    % expected input ray
    rayInSingleCellRef{1,1} = raysIn;
    rayInSingleCellRef{1,1}.distanceToIntersection = 8.92426e-3;
    
    for iRay = 1:1:numberOfRays
        raysOutCell{iRay,1} = raysOut;
    end
    
    % round the test output
    [raysInCell, output] = raytraceSurface3D(raysInCell, surface1,1,1.5, 10e-3);
    for iRay = 1:1:numberOfRays
        output{iRay,1}.direction = round(output{iRay,1}.direction,rounding);
        output{iRay,1}.origin = round(output{iRay,1}.origin,rounding);
    end
    
    % set rel tol due to precision errors from matlab
    relTol = 0.0001;

   for iRay = 1:1:numberOfRays
         % test ray out
        verifyRay(output{iRay,1}, raysOutCell{iRay,1},relTol, testCase)
        
        % test ray in
        verifyRay(raysInCell{iRay,1},rayInSingleCellRef{1,1},...
        relTol, testCase)
   end 
end

%% test with multiple rays through 1 concave surface

function testSurface3D_multipleRaysInConcave(testCase)

    numberOfRays = 10;

    % create single ray 
    raysIn = Ray3D([3.78485e-3, 2.78485e-3, 0.559848e-3],...
        [0.064202,0.0824673,0.994524], 1.5);
    raysInCell = cell(numberOfRays,1);
    
    for iRay = 1:1:numberOfRays
        raysInCell{iRay,1} = raysIn;
    end

    % create surface
    surface1 = Surface3D([0,0,5e-3], -10e-3 ,1.5);
    
    % expected output ray and round
    rounding = 100;
    raysOut = Ray3D(round([3.98453e-3, 3.04134e-3, -1.34704e-3],rounding),...
        round([-0.135022,-0.052866,0.989431],5), 1);
    raysOutCell = cell(numberOfRays,1);
    
    for iRay = 1:1:numberOfRays
        raysOutCell{iRay,1} = raysOut;
    end
    
      % expected input ray
    rayInSingleCellRef{1,1} = raysIn;
    rayInSingleCellRef{1,1}.distanceToIntersection = 3.1128764833e-3;
    
    % round the test output
    [raysInCell, output] = raytraceSurface3D(raysInCell, surface1,1.5,1.0, 5e-3);
    for iRay = 1:1:numberOfRays
        output{iRay,1}.direction = round(output{iRay,1}.direction,rounding);
        output{iRay,1}.origin = round(output{iRay,1}.origin,rounding);
    end
    
    % set rel tol due to precision errors from matlab
    relTol = 0.001;
    
   for iRay = 1:1:numberOfRays
       
        % test ray out
        verifyRay(output{iRay,1}, raysOutCell{iRay,1},relTol, testCase)
        
        % test ray in
        verifyRay(raysInCell{iRay,1},rayInSingleCellRef{1,1},...
        relTol, testCase)
   end 
end


%% test ray intersection with a plane
function testSurface3D_rayWithPlane(testCase)

    rounding = 100;

    % create single ray
    rayInSingle = Ray3D(round([3.98453e-3, 3.04134e-3, -1.34704e-3],rounding),...
        round([-0.135022,-0.052866,0.989431],rounding), 1);
    rayInSingleCell = cell(1,1);
    rayInSingleCell{1,1} = rayInSingle;
    
    % create surface
    surface1 = Surface3D([0,0,27e-3], inf ,1);
    
    % expected output ray and round
    rayOutSingle = Ray3D(round([2.16314e-3, 2.32819e-3, 0],rounding),...
        round([-0.135022,-0.052866,0.989431],5), 1);
    rayOutSingleCell = cell(1,1);
    rayOutSingleCell{1,1} = rayOutSingle;
    
    
    % expected input ray
    rayInSingleCellRef{1,1} = rayInSingle;
    rayInSingleCellRef{1,1}.distanceToIntersection = 13.439494038095333e-3;
    
    % round the test output
    [rayInSingleCell, output] = raytraceSurface3D(rayInSingleCell, surface1,1.0,1.0, 12e-3);
    output{1,1}.direction = round(output{1,1}.direction,rounding);
    output{1,1}.origin = round(output{1,1}.origin,rounding);
    
    % set rel tol due to precision errors from matlab
    relTol = 0.01;
    
    % test ray out
    verifyRay(output{1,1}, rayOutSingleCell{1,1},relTol, testCase)

    % test ray in
    verifyRay(rayInSingleCell{1,1},rayInSingleCellRef{1,1},...
    relTol, testCase)


end



%% test multiple rays through the convex, concave & plane surface

function  testSurface3D_multipleRaysConvexConcavePlane(testCase)

    % create single ray 
    raysIn = Ray3D([2e-3, 1e-3, 2e-3], [0.2,0.2,0], 1);
    %raysIn.distanceToIntersection = 8.92426e-3;
    
    % create many rays
    numberOfRays = 1;
    raysInCell = cell(numberOfRays,1);
    
    for iRay = 1:1:numberOfRays
        raysInCell{iRay,1} = raysIn;
    end

    % create surfaces
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    surface2 = Surface3D([0,0,5e-3], -10e-3 ,1.5);
    surface3 = Surface3D([0,0,27e-3], inf ,1);
    
    rounding = 100;
    
    raysInSingleCellRef{1,1} = raysIn;
    raysInSingleCellRef{1,1}.distanceToIntersection = 8.92426e-3;
    
    % expected output1 rays and round
    raysOut1 = Ray3D([3.78485e-3, 2.78485e-3, 0.559848e-3],...
        [0.064202,0.0824673,0.994524], 1.5);
    raysOut1.distanceToIntersection = 3.1128764833e-3;
    
    raysOut2 = Ray3D(round([3.98453e-3, 3.04134e-3, -1.34704e-3],rounding),...
        round([-0.135022,-0.052866,0.989431],5), 1);
    raysOut2.distanceToIntersection = 13.439494038095333e-3;
    
    raysOut3 = Ray3D([2.16314e-3, 2.32819e-3, 0],...
        [-0.135022,-0.052866,0.989431], 1);

    
    raysOutCell1 = cell(numberOfRays,1);
    raysOutCell2 = cell(numberOfRays,1);
    raysOutCell3 = cell(numberOfRays,1);
    
    for iRay = 1:1:numberOfRays
        raysOutCell1{iRay,1} = raysOut1;
        raysOutCell2{iRay,1} = raysOut2;
        raysOutCell3{iRay,1} = raysOut3;
    end
   
    % round the test output
    [raysInCell,output1] = raytraceSurface3D(raysInCell, surface1,1.0,1.5, 10e-3);
    [output1,output2] = raytraceSurface3D(output1, surface2,1.5,1.0, 5e-3);
    [output2,output3] = raytraceSurface3D(output2, surface3,1.0,1.0, 12e-3);
    
    for iRay = 1:1:numberOfRays
        output1{iRay,1}.direction = round(output1{iRay,1}.direction,rounding);
        output1{iRay,1}.origin = round(output1{iRay,1}.origin,rounding);
        
        output2{iRay,1}.direction = round(output2{iRay,1}.direction,rounding);
        output2{iRay,1}.origin = round(output2{iRay,1}.origin,rounding);
        
        output3{iRay,1}.direction = round(output3{iRay,1}.direction,rounding);
        output3{iRay,1}.origin = round(output3{iRay,1}.origin,rounding);
    end
    
    % set rel tol due to precision errors from matlab
    relTol1 = 0.01;
    
    for iRay = 1:1:numberOfRays
        verifyRay(raysInCell{iRay,1}, raysInSingleCellRef{1,1}, relTol1,...
            testCase)
        verifyRay(output1{iRay,1}, raysOutCell1{iRay,1}, relTol1,...
            testCase)
        verifyRay(output2{iRay,1}, raysOutCell2{iRay,1}, relTol1,...
            testCase)
        verifyRay(output3{iRay,1}, raysOutCell3{iRay,1}, relTol1,...
            testCase)
    end

end


%% test when ray does not intersect with the surface

function testSurface3D_NoIntersection(testCase)
    % create single ray
    rayInSingle = Ray3D([2e-3, 1e-3, 2e-3], [0.7,0.7,0], 1);
    rayInSingleCell = cell(1,1);
    rayInSingleCell{1,1} = rayInSingle;
    
    raysInSingleCellRef = rayInSingleCell;
    raysInSingleCellRef{1,1}.distanceToIntersection = inf;
    
    % create surface
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    
    % expected output ray and round
    rounding = 100;
    rayOutSingle = Ray3D([NaN, NaN, NaN],...
        [NaN,NaN,NaN], NaN);
    rayOutSingleCell = cell(1,1);
    rayOutSingleCell{1,1} = rayOutSingle;
    rayOutSingleCell{1,1}.distanceToIntersection = inf;
    
    % round the test output
    [rayInSingleCell, output] = raytraceSurface3D(rayInSingleCell, surface1, 1.0, 1.5, 10e-3);
    output{1,1}.direction = round(output{1,1}.direction,rounding);
    output{1,1}.origin = round(output{1,1}.origin,rounding);
    
    % set rel tol due to precision errors from matlab
    relTol = 0.001;

    verifyRay(rayInSingleCell{1,1}, raysInSingleCellRef{1,1}, relTol,...
            testCase)
    verifyRay(output{1,1}, rayOutSingleCell{1,1}, relTol,...
            testCase)
     
end

%% test when ray a ray is NaN

function testSurface3D_RayInIsNaN(testCase)
    % create single ray with NaN
    rayInSingle = Ray3D([2e-3, NaN, 2e-3], [0.7,0.7,0], 1);
    rayInSingleCell = cell(1,1);
    rayInSingleCell{1,1} = rayInSingle;
    
    
    raysInSingleCellRef = rayInSingleCell;
    raysInSingleCellRef{1,1}.distanceToIntersection = inf;
    
    % create surface
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    
    % expected output ray and round
    rounding = 100;
    rayOutSingle = Ray3D([NaN, NaN, NaN],...
        [NaN,NaN,NaN], NaN);
    rayOutSingleCell = cell(1,1);
    rayOutSingleCell{1,1} = rayOutSingle;
    rayOutSingleCell{1,1}.distanceToIntersection = inf;
    
    % round the test output
    [rayInSingleCell, output] = raytraceSurface3D(rayInSingleCell, surface1,1.0,1.5, 10e-3);
    output{1,1}.direction = round(output{1,1}.direction,rounding);
    output{1,1}.origin = round(output{1,1}.origin,rounding);
    
    % set rel tol due to precision errors from matlab
    relTol = 0.001;

    verifyRay(rayInSingleCell{1,1}, raysInSingleCellRef{1,1}, relTol,...
            testCase)
    verifyRay(output{1,1}, rayOutSingleCell{1,1}, relTol,...
            testCase)
     
end

%% test multiple rays through the convex, concave & plane surface where first
% Ray is NaN

function  testSurface3D_multipleRaysConvexConcavePlaneNaN(testCase)

    % create single ray 
    raysIn = Ray3D([NaN, NaN, NaN], [NaN,NaN,NaN], NaN);
    

    
    % create many rays
    numberOfRays = 1;
    raysInCell = cell(numberOfRays,1);
    
    for iRay = 1:1:numberOfRays
        raysInCell{iRay,1} = raysIn;
    end
    
    raysInSingleCellRef = raysInCell;
    raysInSingleCellRef{1,1}.distanceToIntersection = inf;

    % create surfaces
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    surface2 = Surface3D([0,0,5e-3], -10e-3 ,1.5);
    surface3 = Surface3D([0,0,27e-3], inf ,1);
    
    rounding = 100;
    
    % expected output1 rays and round
    raysOut1 = Ray3D([NaN, NaN, NaN], [NaN,NaN,NaN], NaN);
    raysOut2 = Ray3D([NaN, NaN, NaN], [NaN,NaN,NaN], NaN);
    raysOut3 = Ray3D([NaN, NaN, NaN], [NaN,NaN,NaN], NaN);
    
    raysOutCell1 = cell(numberOfRays,1);
    raysOutCell2 = cell(numberOfRays,1);
    raysOutCell3 = cell(numberOfRays,1);
    
    for iRay = 1:1:numberOfRays
        raysOutCell1{iRay,1} = raysOut1;
        raysOutCell2{iRay,1} = raysOut2;
        raysOutCell3{iRay,1} = raysOut3;
    end
   
    % round the test output
    [raysInCell,output1] = raytraceSurface3D(raysInCell, surface1,1.0,1.5, 10e-3);
    [output1, output2] = raytraceSurface3D(output1, surface2,1.5,1.0, 5e-3);
    [output2, output3] = raytraceSurface3D(output2, surface3,1.0,1.0, 12e-3);
    
    for iRay = 1:1:numberOfRays
        output1{iRay,1}.direction = round(output1{iRay,1}.direction,rounding);
        output1{iRay,1}.origin = round(output1{iRay,1}.origin,rounding);
        
        output2{iRay,1}.direction = round(output2{iRay,1}.direction,rounding);
        output2{iRay,1}.origin = round(output2{iRay,1}.origin,rounding);
        
        output3{iRay,1}.direction = round(output3{iRay,1}.direction,rounding);
        output3{iRay,1}.origin = round(output3{iRay,1}.origin,rounding);
    end
    
    % set rel tol due to precision errors from matlab
    relTol = 0.001;


   for iRay = 1:1:numberOfRays
       
    verifyRay(raysInCell{iRay,1},raysInSingleCellRef{1,1}, relTol, testCase)
    verifyRay(output1{iRay,1},raysOutCell1{iRay,1}, relTol, testCase)
    verifyRay(output2{iRay,1},raysOutCell2{iRay,1}, relTol, testCase)
    verifyRay(output3{iRay,1},raysOutCell3{iRay,1}, relTol, testCase)
   end 

end

%% testing t = inf, t = NaN

function testSurface3D_tIsNaNAndInf(testCase)
    % create single ray
    rayInSingle = Ray3D([2e-3, 1e-3, 2e-3], [0.2,0.2,0], 1);
    rayInSingleCell = cell(1,1);
    rayInSingleCell{1,1} = rayInSingle;
    
    % create surface
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    
      verifyError(testCase, @()raytraceSurface3D(rayInSingleCell, surface1,...
          1.0,1.0,inf),...
       'raytraceSurface3D:InputDatatype');
   verifyError(testCase, @()raytraceSurface3D(rayInSingleCell, surface1,...
       1.0,1.0,NaN),...
       'raytraceSurface3D:InputDatatype');
   verifyError(testCase, @()raytraceSurface3D(rayInSingleCell, surface1,...
       1.0,1.0,[1,2]),...
       'raytraceSurface3D:InputDataSize');
     
end


%% testing normal numeric in append mode

function testSurface3D_SingleConvexAppend(testCase)
    % create single ray
    rayInSingle = Ray3D([2e-3, 1e-3, 2e-3], [0.2,0.2,0], 1);
    rayInSingleCell = cell(1,1);
    rayInSingleCell{1,1} = rayInSingle;
    
    rayInSingleCellRef = rayInSingleCell;
    rayInSingleCellRef{1,1}.distanceToIntersection = 8.92426e-3;
    
    % create surface
    surface1 = Surface3D([0,0,30e-3], 20e-3 ,1.5);
    
    % expected output ray and round
    rounding = 100;
    rayOutSingle = Ray3D(round([3.78485e-3, 2.78485e-3, 0.559848e-3],rounding),...
        round([0.064202,0.0824673,0.994524],5), 1.5);
    rayOutSingleCell = cell(1,1);
    rayOutSingleCell{1,1} = rayOutSingle;
    
    % round the test output
    [rayInSingleCell, output] = raytraceSurface3D(rayInSingleCell, surface1,1.0,1.5,...
        10e-3,'append');
    output{1,1}.direction = round(output{1,1}.direction,rounding);
    output{1,1}.origin = round(output{1,1}.origin,rounding);
   
    
    % set rel tol due to precision errors from matlab
    relTol = 0.01;
    
    verifyRay(output{1,2},rayOutSingleCell{1,1},relTol,testCase)
    verifyRay(rayInSingleCell{1,1},rayInSingleCellRef{1,1},relTol,testCase)
     verifyRay(output{1,1},rayInSingleCellRef{1,1},relTol,testCase)

  
     
end








