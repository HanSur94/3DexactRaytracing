%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: /Users/hannessuhr/Documents/MATLAB/exactRaytracing/3D/LaCroixGlassData.xlsm
%    Worksheet: AllData
%
% Auto-generated by MATLAB on 17-Mar-2020 22:36:11

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 17);

% Specify sheet and range
opts.Sheet = "AllData";
opts.DataRange = "A2:Q358";

% Specify column names and types
opts.VariableNames = ["GlassType", "Var2", "Var3", "Mfg", "AbbeGroupings", "Var6", "nd1", "ne", "vd1", "ve", "Var11", "B1", "B2", "B3", "C1", "C2", "C3"];
opts.SelectedVariableNames = ["GlassType", "Mfg", "AbbeGroupings", "nd1", "ne", "vd1", "ve", "B1", "B2", "B3", "C1", "C2", "C3"];
opts.VariableTypes = ["string", "char", "char", "categorical", "categorical", "char", "double", "double", "double", "double", "char", "double", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, ["GlassType", "Var2", "Var3", "Var6", "Var11"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["GlassType", "Var2", "Var3", "Mfg", "AbbeGroupings", "Var6", "Var11"], "EmptyFieldRule", "auto");

% Import the data
LaCroixGlassData = readtable("/Users/hannessuhr/Documents/MATLAB/exactRaytracing/3D/LaCroixGlassData.xlsm", opts, "UseExcel", false);


%% Clear temporary variables
clear opts
length = height(LaCroixGlassData)-1

glassTypes = LaCroixGlassData(2:end,1)
manufracturer = LaCroixGlassData(2:end,2)
abbeGroupings = LaCroixGlassData(2:end,3)
nd1 = LaCroixGlassData(2:end,4)
ne = LaCroixGlassData(2:end,5)
vd1 = LaCroixGlassData(2:end,6)
ve = LaCroixGlassData(2:end,7)
B1 = LaCroixGlassData(2:end,8)
B2 = LaCroixGlassData(2:end,9)
B3 = LaCroixGlassData(2:end,10)
C1 = LaCroixGlassData(2:end,11)
C2 = LaCroixGlassData(2:end,12)
C3 = LaCroixGlassData(2:end,13)

glassDB = cell(length,1);
for iGlassDB = 1:1:length
    
    glassDB{iGlassDB,1} = Glass(glassTypes{iGlassDB,1},...
                        manufracturer{iGlassDB,1},...
                        abbeGroupings{iGlassDB,1},...
                        nd1{iGlassDB,1},...
                        ne{iGlassDB,1},...
                        vd1{iGlassDB,1},...
                        ve{iGlassDB,1},...
                        [B1{iGlassDB,1},B2{iGlassDB,1}, B3{iGlassDB,1},...
                        C1{iGlassDB,1}, C2{iGlassDB,1}, C3{iGlassDB,1}] )
end

