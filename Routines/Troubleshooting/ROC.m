%% Program for ploting ROC and other types of curves
% Date: 27 - 06 - 20
% Author: Diego Herrera-Luis Duran
% Description: In this program a MACE,MINACE or HBCOM filter is computed
%              for a sample image and PSR is computed for the
%              correlation output of the other images in the
%              set. A plot of the ROC curve, a TPR vs FNR curve and the 
%              FNR/TPR against the fraction of std used to form the
%              acceptance region curve, are generated
%              for those images on the set.


function usedImages = ROC...
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

    %% Compute PSR and Peak location for True Data
    peakloc = zeros(numel(Data),2);
    psrvals = zeros(numel(Data),1);
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
        % Compute PSR and Peak Location
        [psr, location] = PSR(corrplane);
        psrvals(k) = psr;
        peakloc(k,1) = location(1);
        peakloc(k,2) = location(2);
    end

    %% Compute PSR and Peak Location for False Data
    fake_peakloc = zeros(numel(Fake),2);
    fake_psrvals = zeros(numel(Fake),1);
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
        [psr, location] = PSR(corrplane);
        fake_psrvals(k) = psr;
        fake_peakloc(k,1) = location(1);
        fake_peakloc(k,2) = location(2);
    end

    %% Compute mean values of PSE for both sets
    meanT = mean(psrvals); meanF = mean(fake_psrvals);
   
    %% Compute standard deviation values of PSR for both sets
    stdT = std(psrvals); stdF = std(fake_psrvals);
   
    %% Define match band
    const=0.05:0.05:3.5; %Vector of the fractions of STD used
    Thereshold=zeros(length(const),1); %Initialize thereshold vector
    for k=1:length(const)
        Thereshold(k)=meanT-const(k)*stdT;
    end
  Thereshold; %Thereshold vector contains all thereshold values we'll use.
 
  %% True positive and false negative rate.
  
  TPR=zeros(1,length(const)); %Initialize
  FNR=zeros(1,length(const));
  %We need to store all the TPR or FNR values for each thereshold, we use a "for" 
  
  for k=1:length(const)            
      Thereshold_used=Thereshold(k);  %We start on the kth thereshold value
      for L=1:length(Data)            %And check all the images for that thereshold
          Image_used=L;
            if psrvals(L)>=Thereshold(k) %If the Lth image gives a match
            TPR(k)=TPR(k)+1;    %we add such match to the TPR on the element corresponding to the kth thereshold
            FNR(k)=FNR(k)+0;
            else                 %Otherwise we add the "no match" to the FNR
            TPR(k)=TPR(k)+0;
            FNR(k)=FNR(k)+1;
             end
      end 
  end
  TPR;FNR;
  TPR=TPR./length(Data); %TPR is a vector that contains the True positive rate for each thereshold value
  FNR=FNR./length(Data);%FNR is a vector that contains the False negative rate for each thereshold value
  
  %% False positive and True negative rate.
  FPR=zeros(1,length(const));
  TNR=zeros(1,length(const));
  %We need to store all the FPR or TNR values for each thereshold, we use a "for" 
  
  for k=1:length(const)
      Thereshold_used=Thereshold(k);
      for L=1:length(Fake)
          Image_used=L;
            if fake_psrvals(L)>=Thereshold(k) 
           FPR(k)=FPR(k)+1;
            TNR(k)=TNR(k)+0;
            else
            FPR(k)=FPR(k)+0;
            TNR(k)=TNR(k)+1;
             end
      end 
  end
  FPR;TNR;
  FPR=FPR./length(Fake); %FPR is a vector that contains the False positive rate for each thereshold value
  TNR=TNR./length(Fake);%FNR is a vector that contains the True negative rate for each thereshold value
 
  %% Plot ROC curve
% Define a tolerance range to find an aproximate value for FNR=FPR  
tol =0.05; 
for k=1:100                        %We use a "for" in case that the first range does not work
 index = abs(FNR-FPR) < tol; %Logical array corresponding to the elements on the substraction that satisfy the condition
 index_Numb=find(index);%index(:); %Finds and stores in a vector, the index number only for the truth elements on the logical array.  
   if isempty(index_Numb)   %Make sure the vector has at least one element
     tol =tol+0.005;         %If it's empty->increase a little the tolerance and start again.
   else
       break          %If it's not empty->Finish the loop
       
   end
end

tol %Final tolerance used.
FPR(index_Numb) %Now we want to see the FPR values corresponfing to those indeces
%PLOT:
 EER=max(FPR(index_Numb)).*ones(1,length(FPR));%Equal error rate->when FNR=FPR.
  figure('Name',['Simulación Reconocimiento con ' filtername]);
    plot(FPR,TPR);hold on;plot(FPR,TNR,'--r',EER,TPR,'--g');hold off;
    axis([0 1 min(TPR) 1]);xlabel('FPR');ylabel('TPR');
    title(['Curva ROC con referencia a imagen ' num2str(...
        refimag)]);
   grid on
   
  %% Plot ROC curve-2nd type
  figure('Name',['Simulación Reconocimiento con ' filtername]);
    plot(FPR,FNR);xlabel('FPR');ylabel('FNR');
    title(['Curva ROC (Tipo 2) con referencia a imagen ' num2str(...
        refimag)]);
   grid on

  %% Plot TPR vs FNR
  figure('Name',['Simulación Reconocimiento con ' filtername]);
    plot(FNR,TPR)
    xlabel('FNR');
    ylabel('TPR');
    title(['FNR vs TPR referencia a imagen ' num2str(...
        refimag)]);
   grid on
%% CURVES RESPECT TO Percentage of std used on the region size.

ratio=FNR./TPR;
figure('Name',['Simulación Reconocimiento con ' filtername]);
 plot(const,ratio);xlabel('STD fraction');ylabel('FNR / TPR');
    title(['FNR/TPR vs fracción de std con referencia a imagen ' num2str(...
        refimag)]);
   grid on
end
