% GENERATEFIG4A fetches the data from the .MAT file and plots Figure 4A. 
%
%   AUTHOR ================================================================
%
%   S.Bahdasariants, NEL, WVU, https://github.com/SerhiiBahdas
%
%   =======================================================================

% Path to the folder conaining the .FIG files. 
sFolderName = "FIG files"; 

% Specify filename. 
sFile = "data_FIG4A.mat"; 

% Specify path to the figure. 
sPath = fullfile(erase(cd, 'Scripts'), sFolderName, sFile); 

% Load data.
load(sPath); 

%% VISUALIZE AND COMPARE ERRORS W and W/O IMPEDANCE.

% Create figure.
figure; 

% Significance level.
nAlpha = 0.05; 

% Clear variables. 
clear nAngErr_matrix nTorErr_matrix

% Save data not to overwrite it. 
tbl_1 = tbl; 

% Solvers to delete.
sSolverList_delete = ["be", "be0", "fe", "fe0"]; 

% Loop through solvers. 
for iSolver = 1:length(sSolverList_delete)

    % Find indexes of the rows to delete. 
    nIdxList = tbl_1.sSolver == sSolverList_delete(iSolver); 
    
    % Remove data related to the solvers you are not interested in. 
    tbl_1(nIdxList, :) = [];

end % iSolver

% Freq. to delete.
sFreqList_delete = []; 

% Loop through freq. 
for iFreq = 1:length(sFreqList_delete)

    % Find indexes of the rows to delete. 
    nIdxList = tbl_1.sFreq == sFreqList_delete(iFreq); 
    
    % Remove data related to the freq. you are not interested in. 
    tbl_1(nIdxList, :) = [];

end % iFreq

% Make solver variables cathegorical and reorder them for visualization
% purposes. 
tbl_1.sSolver = categorical(tbl_1.sSolver, {'rk0', 'rk'}); 

% Order in which frequencies are going to be visualized. 
freqOrder = {'Freq_50','Freq_100','Freq_200', 'Freq_300', 'Freq_400', 'Freq_500'}; 

% Make names of the frequencies a cathegorical label. 
tbl_1.sFreq = categorical(tbl_1.sFreq,freqOrder);

% Counter to loop through subplots. 
iCounter = 1; 

% List the DOFs to visualize. 
sDOFList = ["Lkneex"]; 

% Extract solver names. 
sSolverArray = unique(tbl_1.sSolver); 

% Extract list of frequencies. 
nFreqList = unique(tbl_1.nFreq); 

% Extract names of the frequencies.
sFreqList = unique(tbl_1.sFreq); 

% Loop through the DOF. 
for sDOFName = sDOFList

    % Disp DOF Name.
    disp(sDOFName); 
    
    % Visualize angular boxplots. 
    subplot(1,length(sDOFList), iCounter); 

    % Visualize boxplot. 
    boxchart(tbl_1.sFreq(tbl_1.sDOF == sDOFName),...
             tbl_1.nTorErr(tbl_1.sDOF == sDOFName),...
             'GroupByColor',...
             tbl_1.sSolver(tbl_1.sDOF == sDOFName));

    % Add label and title. 
    ylabel('Torque RMSE, %'); title(sDOFName);

    % Increement counter. 
    iCounter = iCounter +1; 

end % sDOFName
