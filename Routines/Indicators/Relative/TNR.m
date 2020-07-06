%% Program for computing True Negative Rate
% Date: 05 - 07 - 20
% Author: Diego Herrera
% Description: In this program, The PSR indicator is used to compute the
%              total of false events cathegorized as false as a 
%              proportion of truly false events.

function tnr = TNR(truedirname,filttype,threshold)
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
    
    fpt = 0;
    for k = 1:numel(falseSubs)
        %% Compute PSE values over false class set
        [psrvals, ~, ~] = ...
            PSR_Database(truedirname,falseSubs{k},filttype);
    
        %% Count events cathegorized as true class
        fpt = fpt + ...
            length(psrvals(psrvals < threshold));
    
    end
    
    %% Compute fpr
    tnr = fpt/(numel(falseSubs)*199);
end