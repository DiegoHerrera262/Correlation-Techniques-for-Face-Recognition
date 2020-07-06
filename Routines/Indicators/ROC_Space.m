function threshold = ROC_Space(truedirname,filttype)
    %% Compute PSR values for True & impostor classes
    [true_psrvals, ~, ~] = ...
        PSR_Database(truedirname,truedirname,filttype);
    false_psrvals = PSR_Impostors(truedirname,filttype);
    
    %% Compute intervals for thresholding
    tmean = mean(true_psrvals); tstd = std(false_psrvals);
    fmean = mean(false_psrvals); fstd = std(false_psrvals);
    inflim = fmean - 2.5*fstd;
    suplim = tmean + 2.5*tstd;
    delta = 0.05*(tmean - fmean);
    %% Generate ROC space
    rang = inflim:delta:suplim;
    x = zeros(length(rang),1);
    y = zeros(length(rang),1);
    for i = 1:length(rang)
        % Compute tpr
        y(i) = length(true_psrvals(true_psrvals >= rang(i)))/199;
        % Compute fpr
        x(i) = length(false_psrvals(false_psrvals >= rang(i)))...
            /length(false_psrvals);
    end
    
    %% Compute ideal threshold value
    indicator = sqrt(x.^2 - (y-1).^2);
    threshold = rang(indicator == min(indicator));
    
    %% Plot ROC space
    f = @(p) 1-p; g = @(p) p;
    figure('Name',['ROC Space for ' truedirname ' - ' filttype]);
    fplot(f,'LineWidth',1.5,'Color','b'); hold on;
    fplot(g,'LineWidth',1.5,'Color','r'); hold on;
    scatter(x,y,'o','MarkerFaceColor','k','MarkerEdgeColor','k');
    xlim([0.0 1.0]);
    ylim([0.0 1.0]);
    pbaspect([1 1 1]);
    xlabel('FPR','FontSize',15);
    ylabel('TPR','FontSize',15);
    title('ROC Space','FontSize',15);
    legend('ideal','random',filttype,'Location','best');
end