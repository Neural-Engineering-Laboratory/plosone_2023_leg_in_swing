% GENERATEFIG 2 fetches the data from the .MAT file and plots Figure S2. 
%
%   AUTHOR ================================================================
%
%   S.Bahdasariants, NEL, WVU, https://github.com/SerhiiBahdas
%
%   =======================================================================

% Path to the folder conaining the .FIG files. 
sFolderName = "FIG files"; 

% Specify filename. 
sFile = "data_FIG2.mat"; 

% Specify path to the figure. 
sPath = fullfile(erase(cd, 'Scripts'), sFolderName, sFile); 

% Load data. 
load(sPath); 

%% FIGURE 2. NUMERIC STIFFNESS AND DAMPING AFFECT ANGULAR AND TORQUE RMSE.
% This figure shows that the increase in [K,B] values leads to the decrease
% in the angular errors and increase in the torque errors. The purpose of
% the plot is introduce reader to the importance of choosing optimal [K,B].

% Manually specify the labels of the axis. 
sLabel_x = {'0', '10^-^4', '10^-^3', '10^-^2', '10^-^1'}; 
sLabel_y = flip({'0', '10^-^4', '10^-^3', '10^-^2', '10^-^1'}); 

% Specify the maximum and minimum limits for the colorbars. 
nLimitsColor_tor = [0,20];
nLimitsColor_ang = [0,0.05];

% Name the figure. 
figure('Name', 'NUMERIC STIFF. AND DAMP. AFFECT ANGULAR AND TORQUE RMSE'); 

% Manually choose which swing to visualize. 
idSwing = 5; 

% Manually choose the frequency, Hz. 
nRate = 200; 

% Name the frequency. 
sFreq = "Freq_" + string(nRate); 

% List DOFs that you want to visualize.
sDOFList = ["Lhipy", "Lhipz","Lankley","Lanklez"];

% Solver used in simulations. 
input.sSolver = "be"; 

% For all chosen DOFs. 
for iDOF = 1:numel(sDOFList)

    % Name of the DOF. 
    sDOF = sDOFList(iDOF); 

    % Find ID of the DOF in the signal list. 
    idDOF = find(input.sSignalList == sDOF); 

    % Fetch angular error matrix. 
    nAng = angle.(input.sSolver).(sFreq)(:, :, idDOF, idSwing); 

    % Create subplot. 
    subplot(2, numel(sDOFList), iDOF); 

    % Plot the errors. 
    heatmap(sLabel_x, sLabel_y, flip(nAng,1), 'CellLabelColor','none'); 

    % Visualize colorbar. 
    colorbar; 

    % Set colorbar limits. 
    clim(nLimitsColor_ang); 

    % Choose the colormap; 
    colormap(flip(gray));

    % For the first column. 
    if iDOF == 1
        ylabel('Angle RMSE, deg'); 
    end
        
    % Add title.
    title(sDOF); 

    % Fetch torque error matrix. 
    nTor = torque.(input.sSolver).(sFreq)(:, :, idDOF, idSwing); 

    % Create subplot. 
    subplot(2, numel(sDOFList), iDOF + numel(sDOFList)); 

    % Plot the errors. 
    heatmap(sLabel_x, sLabel_y, flip(nTor,1), 'CellLabelColor','none'); 

    % Visualize colorbar. 
    colorbar; 

    % Set colorbar limits. 
    clim(nLimitsColor_tor); 

    % Choose the colormap; 
    colormap(flip(gray));

    % For the first column. 
    if iDOF == 1
        ylabel('Torque RMSE, Nm'); 
    end

end 

% Add labels.
xlabel('Damping, Nm/deg'); 
ylabel('Stiffness, Nms/deg'); 

