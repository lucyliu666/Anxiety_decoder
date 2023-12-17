clc;clear
parent = 'D:\Work\2019_Phd\NeuScan\Projects\Fear\fMRI\Pipeline\SVR\Onset\no_shock\new\within_subject\'; 
datadir = 'D:\Work\2019_Phd\NeuScan\Projects\Fear\fMRI\Pipeline\SVR\Onset\no_shock\new\within_subject\n44\';
outpath = 'D:\Work\2019_Phd\NeuScan\Projects\Fear\fMRI\Pipeline\SVR\Onset\no_shock\new\within_subject\one_sample_44\';

dir(datadir); 
files = dir([datadir,'Sub*','.mat']);
files = {files.name}';
nsub = length(files);
nrepeat = 10; 
nfold = 10; 

for ii = 1:nsub
    clear prediction_correlation predicted_rating RSimgs CVindex datfile within outputdir pearson r sig Y p datapath predfiles
    cd(datadir)
    datfile = files{ii,1}; 
    load(datfile)
    ncope = length(RSimgs); 
%     Y = within.Y;
    for repeat = 1:nrepeat
     cd(parent)
     CVindex = GenerateCV(ncope, 1, repeat); 
%      for fold =1:nfold
%          testidx = find(CVindex==fold);
%          copelist= [1:ncope]';
%          copelist(testidx,:)=[];
%          test_idx = RSimgs(testidx);
%          trainidx = RSimgs(copelist);
%          trainY = Y(copelist);
%          testY = Y(testidx);
%          n_test = length(testidx);
%          n_train = length(trainidx);
% %          for jj = 1:n_train
% %              copename = trainidx{jj,1};
% %              [filepath,subname,ext] = fileparts(matfile);
%          R1imgs = cellstr(trainidx);
%          R2imgs = cellstr(test_idx);
         [~, stats] = predict(within,  'algorithm_name', 'cv_svr', 'nfolds', CVindex, 'error_type', 'mse');
%          rating = fmri_data(R1imgs,'D:\Work\2019_Phd\NeuScan\Projects\Fear\fMRI\Pipeline\SVR\Onset\no_safe\GM_mask.nii');
% %          test = fmri_data(R2imgs,'D:\Work\2019_Phd\NeuScan\Projects\Fear\fMRI\Pipeline\SVR\Onset\no_safe\GM_mask.nii');
%          svrobj = svr({'C=1', 'optimizer="andre"', kernel('linear')});
%          dataobj = data('spider data', double(rating.dat)', trainY);
%          [~, svrobj] = train(svrobj, dataobj, loss);
%          weights = get_w(svrobj)';
%          bias = svrobj.b0;
         predicted_rating(:, repeat) = stats.yfit;
    end
%          predicted_rating(:,fold) = {double(test.dat)'*weights+bias};
%          true_rating(:,fold) = {testY};
          Y = within.Y; 
          prediction_correlation = corr(Y, predicted_rating);        


%          predicted_all = cat(1,predicted_rating{:});
%          true_all = cat(1,true_rating{:});
%          prediction_correlation(repeat,1) = corr(predicted_all, true_all);  
%          predict(:,repeat) = predicted_all;
%          actual(:,repeat) = true_all;
%          prediction_correlation(repeat,1) = corr(predicted_all, true_all);        
         save([outpath,datfile],'within','stats','predicted_rating','prediction_correlation','CVindex','RSimgs','Y');    
         w=fmri_data(stats.weight_obj);
         write(w,'fname',[datfile,'.nii']);
         
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