% clear, clc
% load('Anxiety_Lucy_noshock_n44.mat')
%load('Discovery_dataset1.mat')
load('Anxiety_Lucy_noshock_n44.mat')
% load('Anxiety_Lucy_noshock_novisual_n44.mat')
%load('subj_index.mat')
svrobj = svr({'C=1', 'optimizer="andre"', kernel('linear')});
dataobj = data('spider data', double(rating.dat)', rating.Y);
clear rating
[~, svrobj] = train(svrobj, dataobj, loss);
weights = get_w(svrobj)';
bias = svrobj.b0;
% save('VIFS', 'weights', 'bias', '-v7.3');
% load('VIFS.mat')

% the generalization dataset can be available from the authors of
% Taschereau-Dumouchel et al. 2019, Molecular Psychiatry
% load('Arousing_pics.mat');
Lucy_Picture_PE = double(Arousal.dat)'*weights+bias;
ROC_Lucy = roc_plot(Lucy_Picture_PE, [ones(48,1);zeros(48,1)], 'twochoice'); % two-choice, 58 subjects


% or simply use:
% VIFS = fmri_data('VIFS.nii', 'GM_mask.nii');
% predicted_ratings = double(affect.dat'*VIFS.dat);


