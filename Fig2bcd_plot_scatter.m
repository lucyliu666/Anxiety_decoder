nsub = 50;
%  nsub = 44;
for i = 1:nsub
    Y = predicted_rating{i};
    X = actual_rating{i};
%     Y = all_predict{i};
%     X = all_Y{i};
    zy = zscore(Y);
    zx = zscore(X);
%     all_y{i} = zy;
% %     all_x{i} = zx;
    fit_y{i} = zy;
    fit_x{i} = zx;
%     out = plot_y_yfit(X, Y, 'data_alpha', 1, 'line_alpha', 0.7, 'dotsize', 25, 'xlim', [0 5], 'ylim', [0 5]);

    out = plot_y_yfit(zx, zy, 'data_alpha', 1, 'line_alpha', 0.7, 'dotsize', 25, 'xlim', [-3 3], 'ylim', [-3.5 3.5]);
    hold on
end

% % xx=cell2mat(all_x');
% % yy=cell2mat(all_y');
xx=cell2mat(fit_x');
yy=cell2mat(fit_y');

f=fit(xx,yy,'poly1');
hold on
plot(f)

xlabel('Actual rating (z score)', 'fontsize', 20); ylabel('Signature response (z score)', 'fontsize', 20);

hold off

% exportgraphics(gcf,'indiv_pred_50.png','Resolution',400)
% saveas(gcf,'predict_scatter','jpg');
