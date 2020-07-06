%% Program for computing  PSR indicator for Correlation over false class
% Date: 05 - 07 - 20
% Author: Diego Herrera
% Description: In this program, The PSR indicator is computed over a
%              database with a correlation filter associated with a
%              particular individual. The data base corresponds to all
%              impostor datasets.

function psrvals = PSR_Impostors(truedirname,filttype)
    %% Get false class folders
    % The subjects that have images with the correct size are filtered.
    % Read Subject names on database
    path = [pwd() '/ProcessedDatabase'];
    RawDatabase = dir([pwd() '/RawDatabase']);
    % Read sample size
    impath = [path '/' truedirname '_filtered' '/filtered_sample1.png'];
    refsize = size(imread(impath));
    % Get plausible sets for comparison
    falseSubs = {};
    for k = 1:numel(RawDatabase)
        falseSubject = RawDatabase(k).name;
        cond = (strcmp(falseSubject,'.') | ... 
            strcmp(falseSubject,'..')) | ...
            strcmp(falseSubject,truedirname);
        if ~cond
            impath = [path '/' falseSubject ...
                '_filtered' '/filtered_sample1.png'];
            if isfile(impath)
                candsize = size(imread(impath));
                cond1 = candsize == refsize;
                if cond1
                    falseSubs{end +1} = falseSubject;
                    disp(['Identified ' ...
                        falseSubject ' with correct size']);
                end
            end
        end
    end
    
    %% Compute PSR over impostors
    psrvals = zeros(numel(falseSubs)*199,1);
    inflim = 1; suplim = 199;
    % Iterate over impostor folders
    for k = 1:numel(falseSubs)
        %% Compute PSE values over false class set
        [Psr, ~, ~] = ...
            PSR_Database(truedirname,falseSubs{k},filttype);
        psrvals(inflim:suplim) = Psr;
        inflim = suplim+1;
        suplim = inflim+198;
    end
end