% GENERATEFIG6 fetches the data from the .MAT file and plots Figure 6. 
%
%   AUTHOR ================================================================
%
%   S.Bahdasariants, NEL, WVU, https://github.com/SerhiiBahdas
%
%   =======================================================================

% Path to the folder conaining the .FIG files. 
sFolderName = "FIG files"; 

% Specify filename. 
sFile = "data_FIG6.mat"; 

% Specify path to the figure. 
sPath = fullfile(erase(cd, 'Scripts'), sFolderName, sFile); 

% Load data. 
load(sPath); 

% Create a figure. 
figure; 

% Create color pallet. 
sColorList = ['r', 'g', 'b']; 

% Loop through anatomical joints. 
for iJoint = 1:numel(sJointList)

    % Name of the joint.
    sJoint = sJointList(iJoint); 

    % Create subplot for angles. 
    subplot(2, numel(sJointList), iJoint); 

    % List the DOFs. 
    sSignalList = Signals.(sJoint); 

    % For all DOFs of the joint above. 
    for iSignal = 1:numel(sSignalList)

        % Plot signals and statistics. 
        nAng = reshape(angle(iJoint, iSignal, :, :), [nSwingCount, numSmpl]);
        plotWstats(nAng, sColorList(iSignal)); 

    end % iSignal

    % For the furst plot. 
    if iJoint == 1
        
        % Add label to the y-axis. 
        ylabel('Angle, deg'); 

    end % iJoint

    % Add title.
    title(sJoint); 

    % Create subplot for angles. 
    subplot(2, numel(sJointList), iJoint + numel(sJointList)); 

    % For all DOFs of the joint above. 
    for iSignal = 1:numel(sSignalList)

        % Plot signals and statistics. 
        nTor = reshape(torque(iJoint, iSignal, :, :), [nSwingCount, numSmpl]);
        plotWstats(nTor, sColorList(iSignal)); 

    end % iSignal

    % For the furst plot. 
    if iJoint == 1
        
        % Add label to the y-axis. 
        ylabel('Torque, Nm'); 

    end % iJoint

    % Add label t0 x-axis.
    xlabel('Sample'); 

end % iJoint


function [nMean, nSTD] = plotWstats(nSig, sColor)
%PLOTWSTATS Plot (1) signals from the input 2-D matrix, (2) average, (3)
%positive and negative standart deviations. The area between the standart
%deviations is shaded automatically. 
%
%   INPUT =================================================================
%
%   nSig (numeric 2-D array)
%   Input matrix. 
%   Example: rand(100,3)
%
%   sColor (string)
%   Color. 
%   Example: 'k'
%
%   OUTPUT ================================================================
%   
%   nMean (numeric array)
%   Average of the input signals. 
%
%   nSTD (numeric array)
%   Standart deviation of the input signals. 
%
%   AUTHOR ================================================================
%   
%   S.Bahdasariants, NEL, WVU, sb0220@mix.wvu.edu
%
%   =======================================================================

% Find the greater dimention. 
[row, col] = size(nSig); 

% Signals are in columns. Samples are in rows. 
if col > row

    % Transpose the matrix. 
    nSig = nSig'; 

end

% Compute average. 
nMean = mean(nSig, 2);

% Compute STD. 
nSTD = std(nSig, 0, 2); 

% Plot positive STD. 
nSTD_upc = nMean + nSTD; 
plot(nSTD_upc, 'LineWidth', 2, 'Color', sColor);

% Keep plotting.
hold on; 

% Plot negative STD. 
nSTD_dwc = nMean - nSTD; 
plot(nSTD_dwc, 'LineWidth', 2, 'Color', sColor);

% Shade the area between + and - STD. 
nXaxis = [1:col, flip(1:col)]; 
nYaxis = [nSTD_dwc', fliplr(nSTD_upc')]; 
fill(nXaxis', nYaxis', sColor);

% Plot average. 
plot(nMean, 'LineWidth', 3, 'Color', 'k'); 

% Plot signals. 
plot(nSig, 'LineWidth', 0.2, 'Color', sColor);

% Add transparency. 
alpha(.5); 

end % function
