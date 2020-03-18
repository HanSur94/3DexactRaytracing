clear all;
close all;
dbName = 'LaCroixGlassData.xlsm';
glassDB = readtable(dbName,'Sheet','AllData', 'Range', ['A2:A356','B2:AB356'])