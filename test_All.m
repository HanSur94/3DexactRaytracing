%% this script will run all tests
clearvars;
close all;
clc;

t1 = runtests('test_Ray3D');
t2 = runtests('test_Surface3D');
t3 = runtests('test_isSize');
t4 = runtests('test_raytraceSurface3D');
t5 = runtests('test_raytraceSystem3D');
t6 = runtests('test_plotSurfaces3D2D');
t7 = runtests('test_plotRays3D2D');
t8 = runtests('test_getSystemMatrix');
t9 = runtests('test_computeParaxialFocalPoint');
t10 = runtests('test_computeTSA');
t11 = runtests('test_computeLSA');

ts = [t1,t2, t3, t4, t5, t6, t7, t8, t9, t10, t11];

for iTest = 1:1:size(ts,2)
    if ts(1,iTest).Failed
        disp(ts(1,iTest))
    end
end