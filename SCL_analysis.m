% acq = load_acq('0602xuchengan.acq',0);
% acqdata = acq.data;
% marks = acqdata(:,2:6); % depends on your settings
dirfolder = 'H:\copy\Work\NeuScan\Fear\data\SCR_mat\lucy\acqdata_generalize\SCL\';
subfiles = dir([dirfolder,'*.mat']);
subfiles = {subfiles.name}';
nsub = length(subfiles);

for k = 1:nsub
    load(subfiles{k,1});
    SCL=data(:,1);
    SCR=data(:,2);
    marks = data(:,3:7);
    markonset = diff(marks);
    [rows,cols] = find(markonset==5);
    Condition1Idx = find(cols==1); % check your settings
    Condition1Onsets = rows(Condition1Idx);

    Condition2Idx = find(cols==2); % check your settings
    Condition2Onsets = rows(Condition2Idx);

    Condition3Idx = find(cols==3); % check your settings
    Condition3Onsets = rows(Condition3Idx);

    Condition4Idx = find(cols==4); % check your settings
    Condition4Onsets = rows(Condition4Idx);

    ShockIdx = find(cols==5); % check your settings
    ShockOnsets = rows(ShockIdx);

    Condition_all = [Condition1Onsets;Condition2Onsets;Condition3Onsets;Condition4Onsets];

    clear Condition1Idx Condition2Idx Condition3Idx Condition4Idx Condition1Onsets Condition2Onsets Condition3Onsets Condition4Onsets

    %onset of anticipation
    Cue = Condition_all + durations;

    idx = logical(onsets);

    %onset of no shock anticipation
    noshock = Cue(idx);

    %onset of baseline and SCR time window
    timepoint(:,1) = noshock - 1999; % 1s before the cue
    timepoint(:,2) = noshock;   % onset of the cue
    timepoint(:,3) = noshock + 1000;  % 1s after the cue
    timepoint(:,4) = noshock + 8999;  % 8s after the cue

    %extract the data (mean) of 1~0 s before the cue
    nlen = length(timepoint);
    for i = 1: nlen
        t1 = timepoint(i,1);
        t2 = timepoint(i,2);
        value0 = SCL(t1:t2,1);
        value1 = SCR(t1:t2,1);
        base_SCL = sort(value0,'descend');
        base_SCR = sort(value1,'descend');
        max_SCL(i,1) = base_SCL(1);
        max_SCR(i,1) = base_SCR(1);
        
        
%         avg_SCL(i,1)=mean(value0);
%         avg_SCR(i,1)=mean(value1);
    end


    %extract the data (max amplitude) of 1~8 s after the cue
    for j = 1: nlen
        t3 = timepoint(j,3);
        t4 = timepoint(j,4);
        value2 = SCL(t3:t4,1);
        value3 = SCR(t3:t4,1);
        des_SCL = sort(value2,'descend');
        des_SCR = sort(value3,'descend');
        max_amp_SCL(j,1) = des_SCL(1);
        max_amp_SCR(j,1) = des_SCR(1);
    end

%     % SCL&SCR change
%     delta_SCL = max_amp_SCL-avg_SCL;
%     delta_SCR = max_amp_SCR-avg_SCR; 
    
    delta_SCL = max_amp_SCL-max_SCL;
    delta_SCR = max_amp_SCR-max_SCR; 

    % SCL change per condition
    Condition1SCL=delta_SCL(1:16,1);
    Condition2SCL=delta_SCL(17:32,1);
    Condition3SCL=delta_SCL(33:48,1);
    Condition4SCL=delta_SCL(49:64,1);

    ConditionSCL = [Condition1SCL;Condition2SCL; Condition3SCL;Condition4SCL]; 
    TrialSCL(:,k) = ConditionSCL;
    
    % SCR change per condition
    Condition1SCR=delta_SCR(1:16,1);
    Condition2SCR=delta_SCR(17:32,1);
    Condition3SCR=delta_SCR(33:48,1);
    Condition4SCR=delta_SCR(49:64,1);

    % mean SCL change per condition
    SCL_con1 = mean(Condition1SCL);
    SCL_con2 = mean(Condition2SCL);
    SCL_con3 = mean(Condition3SCL);
    SCL_con4 = mean(Condition4SCL);

    SCL_con = [SCL_con1,SCL_con2,SCL_con3,SCL_con4];

    % mean SCR change per condition
    SCR_con1 = mean(Condition1SCR);
    SCR_con2 = mean(Condition2SCR);
    SCR_con3 = mean(Condition3SCR);
    SCR_con4 = mean(Condition4SCR);

    SCR_con = [SCR_con1,SCR_con2,SCR_con3,SCR_con4];
 
    clear Condition1SCL Condition2SCL Condition3SCL Condition4SCL Condition1SCR Condition2SCR Condition3SCR Condition4SCR 
    
    SCL_data(k,:) = SCL_con;
    SCR_data(k,:) = SCR_con;
end
