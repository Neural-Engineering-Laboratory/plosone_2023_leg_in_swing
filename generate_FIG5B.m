% GENERATEFIG5B fetches the data from the .MAT file and plots Figure 5B. 
%
%   AUTHOR ================================================================
%
%   S.Bahdasariants, NEL, WVU, https://github.com/SerhiiBahdas
%
%   =======================================================================

% Path to the folder conaining the .FIG files. 
sFolderName = "FIG files"; 

% Specify filename. 
sFile = "data_FIG5B.mat"; 

% Specify path to the figure. 
sPath = fullfile(erase(cd, 'Scripts'), sFolderName, sFile); 

% Load data.
load(sPath); 

% Create a figure. 
figure('Name', 'LIN. TREND. NORM. SIM. TIMES AS A FUNCTION OF SIM. FREQ.');

% Keep plotting on the same figure. 
hold on; 

% Create data array for X-axis. 
nX = nFreqList*1e-3; 

% Loop through solvers.
for iSolver = 1:length(sSolverList)

    % Fetch and display solver name.
    sSolver = sSolverList(iSolver); disp(sSolver); 

    % Median of the simulated times.
    tMedianTimeNorms = median(squeeze(nTimeNorm(iSolver, :, :))'); 

    % Display median times. 
    disp(1./tMedianTimeNorms);
    
    % Fit a regression line to show that medians of the normalized simulation 
    % times follow linear trend.
    
    % Linear regression.
    mdl = fitlm(nX, tMedianTimeNorms); 
    
    % Plot a regression line.
    plot(nX, mdl.Coefficients.Estimate(1) +...
      mdl.Coefficients.Estimate(2).*nX, '-o', 'LineWidth', 2);

    
    % Display coefficients of the regression line. 
    disp('COEFF B:' + string(mdl.Coefficients.Estimate(1))); 
    disp('COEFF M:' + string(mdl.Coefficients.Estimate(2)));
    
    % Plot unity line.
    %plot(nX, nX, 'LineWidth', 2); 
    
    % Display statistics
    disp('R-squared: '); disp(mdl.Rsquared.Ordinary); 
    disp('p-value:'); disp(mdl.Coefficients.pValue(2)); 

end % iSolver

%===================MANUALLY ADD THE LINES OF INTEREST ====================

% Choose normalized times for which the lines will be drawn.
nTimeArray = [3.5, 4.5, 5.5, 7.5, 11.5, 15.0]; 

% Loop through times. 
for iTime = 1:length(nTimeArray)

    % Fetch time.
    nTime = nTimeArray(iTime); 

    % Plot unity line.
    plot(nX, ones(numel(nX),1)/nTime, 'LineWidth', 0.5, 'Color', 'k'); 
    
    % Add text. 
    text(nX(end)*0.9, 1/nTime*1.03, string(nTime) + "x", 'FontSize', 12)

end % iTime

%==========================================================================

% Stop plotting on the same figure. 
hold off; 

ylabel('t_s_i_m/t_t_r_i_a_l_, n.u.');
xlabel('Sampling rate, kHz')
xlim([0,max(nX)+0.05*max(nX)])
ylim([0.05,0.3]);
title('Best linear fit'); 
legend(sSolverList)