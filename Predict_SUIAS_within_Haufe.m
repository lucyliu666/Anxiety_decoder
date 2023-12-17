
% clc;clear
parent = 'D:\Work\2019_Phd\NeuScan\Projects\Fear\fMRI\Pipeline\SVR\Onset\no_shock\new\within_subject\'; 
datapath = 'D:\Work\2019_Phd\NeuScan\Projects\Fear\fMRI\Pipeline\SVR\Onset\no_shock\new\within_subject\mat_n44\';
outputdir = 'D:\Work\2019_Phd\NeuScan\Projects\Fear\fMRI\Pipeline\SVR\Onset\no_shock\new\final_results\Haufe\Haufe\n44\';

dir(datapath); 
predfiles = dir([datapath,'Sub*','.mat']);
predfiles = {predfiles.name}';
nsub = length(predfiles);


for ii = 1:nsub
    clear prediction_correlation predicted_rating RSimgs CVindex Y
    cd(datapath)
    matfile = predfiles{ii,1}; 
    load(matfile)
    
    Haufe_pattern = fast_haufe(double(within.dat'), double(stats_boot.weight_obj.dat), 500);
    stats.weight_obj.dat=Haufe_pattern;
    save([outputdir,matfile],'within','stats','Haufe_pattern');    
    w=fmri_data(stats.weight_obj);   
    cd(outputdir) 
    write(w,'fname',[matfile,'.nii']);

      
end

 
   
        


% % the generalization dataset can be available from the authors of
% % Taschereau-Dumouchel et al. 2019, Molecular Psychiatry
% load('Sub-085.mat');
% % load('sub_label_pines.mat');
% predicted_ratings = double(within.dat)'*weights+bias;
% 
% % or simply use:
% % VIFS = fmri_data('VIFS.nii', 'GM_mask.nii');
% % predicted_ratings = double(affect.dat'*VIFS.dat);
% 
% true_ratings = within.Y;
% prediction_outcome_correlation = corr(predicted_ratings, within.Y);
% 
% predicted_ratings_reshaped = nan(121*5, 1);
% predicted_ratings_reshaped(sub121_label_pines) = predicted_ratings;
% predicted_ratings_reshaped = reshape(predicted_ratings_reshaped, [5, 121])';
% %% plot
% create_figure('Whole-brain Prediction');[r
% lineplot_columns(predicted_ratings_reshaped, 'color', [.1 .7 .5], 'markerfacecolor', [.1 .8 .6]);
% % lineplot_columns(predicted_ratings_reshaped, 'color', [.1 .7 .5], 'markerfacecolor', [0 .2 0.8]);
% %lineplot_columns(predicted_ratings_reshaped, 'color', 'black', 'markerfacecolor', [0 0 0]);
% xlabel('True Rating');
% ylabel('Predicted Rating')
% set(gca,'FontSize',20);
% set(gca,'linewidth', 2)
% set(gca, 'XTick', 1:6)
% xlim([0.8 5.2])
%  ylim([0 5])
% set(gcf, 'Color', 'w');
% % export_fig Discovery_whole-brain_prediction -tiff -r500