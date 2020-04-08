function [] = plotMIWindowsFeature(MI_Windows,DataSets,Windows,IQRs)

c=[[0.75 0.75 0.75];[0 1 1];[1 0 0]];
m={'.','o','o'};
M_size=5;
 
dn=fieldnames(DataSets);
 
figure;set(gcf,'color','white');set(gcf,'Position',[100 100 750 275]);
for d=1:1:length(dn)
    subplot(1,2,d);
    for i=0:1:2
        h=plot3(MI_Windows.(Windows{1})(DataSets.(dn{d}).indices(DataSets.(dn{d}).Labels==i)),MI_Windows.(Windows{2})(DataSets.(dn{d}).indices(DataSets.(dn{d}).Labels==i)),MI_Windows.(Windows{3})(DataSets.(dn{d}).indices(DataSets.(dn{d}).Labels==i)),m{i+1},'color',c(i+1,:),'MarkerSize',M_size);hold on;
    end
    title(dn{d});
    view(48,25);
    xlabel(['\rho_{' num2str(IQRs.(Windows{1})(1)) '-' num2str(IQRs.(Windows{1})(2)) '}']);
    ylabel(['\rho_{' num2str(IQRs.(Windows{2})(1)) '-' num2str(IQRs.(Windows{2})(2)) '}']);
    zlabel(['\rho_{' num2str(IQRs.(Windows{3})(1)) '-' num2str(IQRs.(Windows{3})(2)) '}']);
    xlim([-1 1]);
    ylim([-0.3 1]);
    zlim([-0.5 1]);
end
