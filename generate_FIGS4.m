% GENERATEFIGS4 fetches the data from the .MAT file and plots Figure S4. 
%
%   AUTHOR ================================================================
%
%   S.Bahdasariants, NEL, WVU, https://github.com/SerhiiBahdas
%
%   =======================================================================

% Path to the folder conaining the .FIG files. 
sFolderName = "FIG files"; 

% Specify filename. 
sFile = "data_FIGS4.mat"; 

% Specify path to the figure. 
sPath = fullfile(erase(cd, 'Scripts'), sFolderName, sFile); 

% Load data. 
load(sPath); 

%% Visualize angular errors for ankle, knee, and hip.
figure; 

% Order in which frequencies are going to be visualized. 
freqOrder = {'Freq_50','Freq_100','Freq_200','Freq_300','Freq_400','Freq_500'}; 

% Save data not to overwrite it. 
tbl_1 = tbl; 

% Make names of the frequencies a cathegorical label. 
tbl_1.sFreq = categorical(tbl_1.sFreq,freqOrder);

% Choose solvers used in the simulations. Suffix '0' corresponds to the
% data simulated with the zero stiffness and damping. 
solverOrder = {'fe0', 'fe' 'rk0', 'rk' 'be0', 'be'};

% Make names of the solvers a cathegorical variable. 
tbl_1.sSolver = categorical(tbl_1.sSolver, solverOrder); 

% Counter to loop through subplots. 
iCounter = 1; 

% List the DOFs to visualize. 
sDOFList = ["Lanklex", "Lankley", "Lanklez", "Lkneex", "Lhipx", "Lhipy", "Lhipz"]; 

% Loop through the DOF. 
for sDOFName = sDOFList
    
    % Visualize angular boxplots. 
    subplot(2, length(sDOFList), iCounter); 

    % Visualize boxplot. 
    boxchart(tbl_1.sFreq(tbl_1.sDOF == sDOFName),...
             tbl_1.nAngErr(tbl_1.sDOF == sDOFName),...
             'GroupByColor',...
             tbl_1.sSolver(tbl_1.sDOF == sDOFName));

    % Add label and title. 
    ylabel('Angle RMSE, %'); title(sDOFName);

    % Visualize torque boxplots. 
    subplot(2, length(sDOFList), iCounter+length(sDOFList)); 

    % Visualize boxplot. 
    boxchart(tbl_1.sFreq(tbl_1.sDOF == sDOFName),...
             tbl_1.nTorErr(tbl_1.sDOF == sDOFName),...
             'GroupByColor',...
             tbl_1.sSolver(tbl_1.sDOF == sDOFName));

    % Add label and legend. 
    ylabel('Torque RMSE, %'); 

    % Increement counter. 
    iCounter = iCounter +1; 

end % sDOFName
    
% Add legend. 
legend; 






























