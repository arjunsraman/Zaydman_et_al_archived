function []=plotProteomeMIExample(quant_bins,Neg_bs_indices,Pos_bs_indices,U,Dij)

win_width=5;
win_centers=[3 5 10 100 1000];

figure('NumberTitle', 'off', 'Name', 'Phylogenetic MI Example');set(gcf,'color','white');set(gcf,'position',[100 100 700 800]);
set(0,'DefaultAxesTitleFontWeight','normal');
for c=1:1:length(win_centers)
    for benchmark=2:6
        subplot(5,length(win_centers),c+length(win_centers)*(benchmark-2));
        R=corr((U(:,win_centers(c)-floor(win_width/2):win_centers(c)+floor(win_width/2)))');
        histogram(R(Neg_bs_indices{benchmark}(1,:)),quant_bins,'FaceColor',[1 1 1]);hold on;
        histogram(R(Pos_bs_indices{benchmark}(1,:)),quant_bins,'FaceColor',[0 0 0]);hold on;
        title(['MI = ' num2str(empirical_differential_MI(R(Neg_bs_indices{benchmark}(1,:)),R(Pos_bs_indices{benchmark}(1,:)),quant_bins),2)]);
        set(gca,'ytick',[]);set(gca,'xtick',[]);box off;set(gca,'xlim',[-1 1]);
        if c==1
            ylabel(Dij.Taxonomy.Categories{benchmark});
        end
    end
        set(gca,'xcolor',[0 0 0]);  xlabel({'Correlation';['SV' num2str(win_centers(c)-floor(win_width/2)) ' to SV' num2str(win_centers(c)+floor(win_width/2))]});
        xticks([-1 0 1]);
end

leg=legend({'Different taxa','Same taxa'},'Location','northoutside','Orientation','horizontal','boxoff');set(leg,'Position',[0.5 0.95 0.1 0.025]);legend boxoff;

