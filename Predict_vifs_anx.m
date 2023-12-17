svrobj = svr({'C=1', 'optimizer="andre"', kernel('linear')});
dataobj = data('spider data', double(discovery.dat)', discovery.Y);
% clear rating
[~, svrobj] = train(svrobj, dataobj, loss);
weights = get_w(svrobj)';
bias = svrobj.b0;
% save('VIFS', 'weights', 'bias', '-v7.3');

% load('Discovery_dataset.mat');
% load('fear_datasets_idx.mat')
% load('Validation_cohort.mat');
%load ('Anxiety_decoder_noshock_n50.mat')
predicted_ratings = double(indep.dat)'*weights+bias;
nsub = 50;
nlevel = 5;
true_ratings = indep.Y;

%% prediction-outcome corrs
prediction_outcome_corr = corr(predicted_ratings, true_ratings);

%% within-subject corrs
subject = repmat(1:nsub, nlevel,1)';
% subject = repmat(1:nsub, nlevel,1);
subject = subject(:);
subject = subject(sub50_label);

within_subj_corrs = zeros(nsub, 1);
within_subj_rmse = zeros(nsub, 1);
within_subj_evs = zeros(nsub, 1);

for i = 1:nsub
    subY = true_ratings(subject==i);
    subyfit = predicted_ratings(subject==i);
    within_subj_corrs(i, 1) = corr(subY, subyfit);
    err = subY - subyfit;
    mse = (err' * err)/length(err);
    within_subj_rmse(i, 1) = sqrt(mse);
    var_fit = (sum((err-mean(err)).^2))/(length(err)-1);
    varY = var(subY);
    within_subj_evs(i, 1) = 1-var_fit/varY;
end