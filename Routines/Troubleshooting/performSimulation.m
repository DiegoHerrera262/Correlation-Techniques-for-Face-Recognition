%% Program for Assesing MACE Filter Performance in Training set
% Date: 02 - 06 - 20
% Author: Diego Herrera
% Description: In this program a single MACE filter is computed
%              for a sample image and PSE is computed for the
%              correlation output of the other images in the
%              set. A plot of PSE vs. Image number is generated

function usedImages = performSimulation...
    (truedirname,falsedirname,refimag,numsamp,filtername)
    %% Parameters of True Folder location
    trueFolder = [pwd() '/ProcessedDatabase/' ...
        truedirname '_filtered'];            % Name of data folder
    MatchName = '/*sample*.png';             % Sample name of image files

    %% Parameters of False Folder location
    falseFolder = [pwd() '/ProcessedDatabase/' ...
        falsedirname '_filtered'];            % Name of data folder

    %% Definition of True data location
    trueLocation = [trueFolder MatchName];

    %% Definition of False data location
    falseLocation = [falseFolder MatchName];

    %% Read True images on folder
    Data = dir(trueLocation);      % Read data from folder
    
    %% Print folders used
    disp(['Used as true data ' trueLocation]);
    disp(['Used as false data ' falseLocation]);

    %% Compute n-Sample MACE
    subspsize = numel(Data);
    usedImages = {};
    if strcmp(filtername,'MINACE')
        usedImages = MINACE_Filter(truedirname,refimag,numsamp,subspsize);
    elseif strcmp(filtername,'HBCOM')
        usedImages = HBCOM_Filter(truedirname,refimag,numsamp);
    elseif strcmp(filtername,'MACE')
        usedImages = MACE_Filter(truedirname,refimag,numsamp,subspsize);
    end

    %% Compute PSR and Peak location for True Data
    [psrvals, peakloc, idx] = ...
        PSR_Database(truedirname,truedirname,filtername);
    
    %% Compute PSE and Peak Location for False Data
    [fake_psrvals, ~, fake_idx] = ...
        PSR_Database(truedirname,falsedirname,filtername);

    %% Compute mean values of PSE for both sets
    meanT = mean(psrvals); meanF = mean(fake_psrvals);
    numRange = 1:0.1:200;
    meanTrue = meanT * ones(size(numRange));
    meanFalse = meanF * ones(size(numRange));

    %% Plot PSR Results
    figure('Name',['Simulation Verification with ' filtername]);
    % subplot(1,2,1);
    scatter(idx,psrvals,'o','MarkerFaceColor','b'); hold on;
    scatter(fake_idx,fake_psrvals,'o','MarkerFaceColor','r'); hold on;
    plot(numRange,meanTrue,'LineWidth',2.0,'Color','b'); hold on;
    plot(numRange,meanFalse,'LineWidth',2.0,'Color','r');
    text(80,meanT,['PSE_T = ' num2str(meanT,3)],...
        'FontSize',15,'Color','k');
    text(80,meanF,['PSE_F = ' num2str(meanF,3)],...
        'FontSize',15,'Color','k');
    xlabel('No. Figure','FontSize',15);
    ylabel('PSE');
    title(['PSE as refered to image ' num2str(...
        refimag)],'FontSize',15);
    legend('True','False','Location','best');

    %% Plot Location Results
    subplot(1,2,2);
    scatter(idx,peakloc(:,1),...
        'o','MarkerFaceColor','b'); hold on;
    scatter(idx,peakloc(:,2),...
        'o','MarkerFaceColor','r'); hold on;
    xlabel('No. Figure','FontSize',15);
    ylabel('Peak Location','FontSize',15);
    title('Peak Location in Correlation Plane','FontSize',15);
    legend('Corrd. y','Coord. x','Location','best');
    
end
