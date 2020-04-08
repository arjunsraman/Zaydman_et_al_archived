function []=plotNullModels(win_centers,win_width,V_protein_matrices)

labels={};
for l=1:1:length(win_centers)
   labels=[labels;[num2str(win_centers(l)-win_width/2) ' to '  num2str(win_centers(l)+win_width/2)]];
end
Line_types={'-','--',':','-.'};

figure1 = figure('NumberTitle','off',...
'Name','Plotting Null Model',...
'Color',[1 1 1]);
set(gcf,'color','white');set(gcf,'position',[200 200 300 1000]);



Orgs=fieldnames(V_protein_matrices);
for o=1:1:length(Orgs)
    subplot(length(Orgs),1,o);hold all;
    for i=1:1:length(win_centers)
       R=corr(V_protein_matrices.(Orgs{o})(:,win_centers(i)-win_width/2:win_centers(i)+win_width/2)');
       cdfplot(R(:));
    end
    title(Orgs{o});
    xlim([-1 1]);
    xticks([-1:0.5:1]);
    xtickangle(90);
    yticks([0:0.5:1]);
    xlabel('Correlation');
    ylabel('Cumulative probability');
    grid off;
    set(gca,'FontSize',6);
    legend(labels,'Location','SouthEast');
end

