%% reshape the predicted ratings from the 10x10 CV
% predicted_ratings_reshaped = nan(nsub*5, 1);
% avg=mean(predicted_ratings,2);
% predicted_ratings_reshaped(sub44_label) = avg; %avg=mean(predicted_ratings,2)
% predicted_ratings_reshaped = reshape(predicted_ratings_reshaped, [5,nsub])';
% 
Rating1 = predicted_ratings_reshaped(:,1);
Rating2 = predicted_ratings_reshaped(:,2);
Rating3 = predicted_ratings_reshaped(:,3);
Rating4 = predicted_ratings_reshaped(:,4);
Rating5 = predicted_ratings_reshaped(:,5);

x = 1:5; % levels   
% y = mean(predicted_ratings_reshaped)
% e = ste(predicted_ratings_reshaped)

y = [nanmean(Rating1); nanmean(Rating2); nanmean(Rating3); nanmean(Rating4);nanmean(Rating5)]
e = [nanstd(Rating1)/sqrt(nsub); nanstd(Rating2)/sqrt(nsub); nanstd(Rating3)/sqrt(nsub); nanstd(Rating4)/sqrt(nsub);nanstd(Rating5)/sqrt(nsub)]



%% pretty figure 
%  figtitle='SIAS predcition';
%  create_figure(figtitle);
%set(gcf, 'Position', [1   512   268   194]);
% col = [240,59,32;
%       197,27,138]./255;
hold on
colormod= [0.54 0.42 0.69];
% %     1 0.2 0.4]; 
% 1 0.6 0.2];
% 0 0.6 0.4];
%             0.54 0.42 0.69;
%             0 0.4 1];
markercol = colormod-.2;
markercol(markercol<0) = 0;

 h = errorbar(x, y, e, 'o', 'color', 'k', 'linewidth', 2, 'markersize', 10, 'markerfacecolor', colormod);
    hold on;
%     sepplot(x, y, .85, 'linewidth', 2);
    sepplot(x, y, .85, 'color', colormod, 'linewidth', 2);




% 
% for i =1:5 % lines to plot
%     h = errorbar(x, y(i,:), e(i,:), 'o', 'color', 'k', 'linewidth', 1, 'markersize', 6, 'markerfacecolor', colormod(i,:));
%     hold on;
%     sepplot(x, y(i,:), .75, 'linewidth', 1);
%     sepplot(x, y(i,:), .75, 'color', colormod(i,:), 'linewidth', 1);
%    % errorbar_width(h, x, [0 0]);
% end

% line([.5 5], [.06 .06], 'color', [.6 .6 .6], 'linewidth', 0.75, 'linestyle', '--');
% line([.5 5], [.17 .17], 'color', [.6 .6 .6], 'linewidth', 0.75, 'linestyle', '--');
% line([.5 5], [.35 .35], 'color', [.6 .6 .6], 'linewidth', 0.75, 'linestyle', '--');

set(gca, 'ylim', [0.5 5], 'xlim', [.5 5.5],'XTick', 0:1:5, 'YTick', 0:1:5,'linewidth', 1, 'tickdir', 'out', 'ticklength', [.02 .02]);
set(gca, 'box', 'off');
%set(gcf, 'position', [1   442   338   264]);

xlabel('Actual rating'); ylabel('Predicted rating'); set(gca, 'FontSize', 16);
% plugin_save_figure