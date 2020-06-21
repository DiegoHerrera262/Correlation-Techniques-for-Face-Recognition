%% Program for Assesing MACE Filter Performance in Trainning set
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

    %% Defnition of False data location
    falseLocation = [falseFolder MatchName];

    %% Read True images on folder
    Data = dir(trueLocation);      % Read data from folder
    basetrue = Data.folder;

    %% Read False images on folder
    Fake = dir(falseLocation);
    basefalse = Fake.folder;
    
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

    %% Compute PSE and Peak location for True Data
    peakloc = zeros(numel(Data),2);
    psevals = zeros(numel(Data),1);
    idx = zeros(numel(Data),1);
    for k = 1:numel(Data)
        % Extract real image index
        s1 = split(Data(k).name,'sample');
        s2 = split(char(s1(2)),'.');
        idx(k) = uint16(str2double(char(s2(1))));
        % Read training-test image
        filename = [basetrue '/' Data(k).name];
        im = imread(filename);
        % Compute correlation
        corrplane = CFxcorr(im,truedirname,filtername);
        % Compute PSE and Peak Location
        [pse, location] = PSE(corrplane);
        psevals(k) = pse;
        peakloc(k,1) = location(1);
        peakloc(k,2) = location(2);
    end

    %% Compute PSE and Peak Location for False Data
    fake_peakloc = zeros(numel(Fake),2);
    fake_psevals = zeros(numel(Fake),1);
    fake_idx = zeros(numel(Fake),1);
    for k = 1:numel(Fake)
        % Extract real image index
        s1 = split(Data(k).name,'sample');
        s2 = split(char(s1(2)),'.');
        fake_idx(k) = uint16(str2double(char(s2(1))));
        % Read training-test image
        filename = [basefalse '/' Fake(k).name];
        im = imread(filename);
        % Compute correlation
        corrplane = CFxcorr(im,truedirname,filtername);
        % Compute PSE and Peak Location
        [pse, location] = PSE(corrplane);
        fake_psevals(k) = pse;
        fake_peakloc(k,1) = location(1);
        fake_peakloc(k,2) = location(2);
    end

    %% Compute mean values of PSE for both sets
    meanT = mean(psevals); meanF = mean(fake_psevals);
    numRange = 1:0.1:200;
    meanTrue = meanT * ones(size(numRange));
    meanFalse = meanF * ones(size(numRange));

    %% Plot PSE Results
    figure('Name',['Simulación Reconocimiento con ' filtername]);
    subplot(1,2,1);
    scatter(idx,psevals,'o','MarkerFaceColor','b'); hold on;
    scatter(fake_idx,fake_psevals,'o','MarkerFaceColor','r'); hold on;
    plot(numRange,meanTrue,'LineWidth',2.0,'Color','b'); hold on;
    plot(numRange,meanFalse,'LineWidth',2.0,'Color','r');
    text(80,meanT,['PSE_T = ' num2str(meanT,3)],...
        'FontSize',15,'Color','k');
    text(80,meanF,['PSE_F = ' num2str(meanF,3)],...
        'FontSize',15,'Color','k');
    xlabel('No. Figura');
    ylabel('PSE');
    title(['PSE con referencia a imagen ' num2str(...
        refimag)]);
    legend('True','False','Location','best');

    %% Plot Location Results
    subplot(1,2,2);
    scatter(idx,peakloc(:,1),...
        'o','MarkerFaceColor','b'); hold on;
    scatter(fake_idx,peakloc(:,2),...
        'o','MarkerFaceColor','r'); hold on;
    xlabel('No. Figura');
    ylabel('Peak Location');
    title('Localización Máximo');
    legend('Corrd. y','Coord. x','Location','best');
    
end
