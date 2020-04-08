function []=plotProteomeCorrelationsExample(U,Dij)

f_size=8;
N=40;
rng(2);
cmap=hsv(15);xlims=[[0 50]];ylims=[-0.07 0.07];
seed='Bacillus';seed_index=find(strcmp(Dij.Taxonomy.STRING(:,6),seed),1);Tax_levels=[2 3 4 5 6];

figure('NumberTitle', 'off', 'Name', 'Correlation between proteomes over SVD components');set(gcf,'color','white');set(gcf,'position',[100 100 700 800]);set(gcf,'position',[100 100 350 700]);

for t=1:1:length(Tax_levels)
    subplot(7*(length(Tax_levels)+1),1,7*(t-1)+[1:5]);
    SameClade=find(strcmp(Dij.Taxonomy.STRING(:,Tax_levels(t)),Dij.Taxonomy.STRING(seed_index,Tax_levels(t))));  
    sample=randi(length(SameClade),N,1);
    plot(U(SameClade(sample),:)','-','color',cmap(t,:));hold on;ylabel('|U>');
    text(xlims(2),ylims(2)*1.3,['[' Dij.Taxonomy.Categories{Tax_levels(t)} '] ' Dij.Taxonomy.STRING{seed_index,Tax_levels(t)} ] ,'HorizontalAlignment','right','FontSize',f_size);
    xlim(xlims);ylim(ylims);set(gca,'xcolor','none');set(gca,'FontSize',f_size);box off;
    yyaxis right;
    for i=3:1:48
        rho=corr(U(SameClade(sample),i-2:i+2)');
        non_redundant_rho=rho(triu(rho,1)~=0);
        plot(i,mean(non_redundant_rho),'.k','MarkerSize',7);hold on;
    end
    ylim([-0.1 1.1]);ylabel('\rho');set(gca,'xcolor','none');set(gca,'FontSize',f_size);set(gca,'YColor',[0 0 0]);box off;
end

subplot(7*(length(Tax_levels)+1),1,7*(t)+[1:5]);
Rand_Unit=[];
    while(length(Rand_Unit)<N)
        i=randi(length(Dij.Taxonomy.STRING(:,1)));
        if ischar(Dij.Taxonomy.STRING{i,Tax_levels(t)})
            Rand_Unit=[Rand_Unit;i];
        end
    end
    
plot(U(Rand_Unit,:)','-','color',[0.5 0.5 0.5]);
text(xlims(2),ylims(2)*1.3,['Random' ] ,'HorizontalAlignment','right','FontSize',f_size);
xlim(xlims);ylim(ylims);xlabel('SV');box off;set(gca,'FontSize',f_size);ylabel('|U>');yyaxis right;    

for i=3:1:48
    rho=corr(U(Rand_Unit,i-2:i+2)');
    non_redundant_rho=rho(triu(rho,1)~=0);
    plot(i,mean(non_redundant_rho),'.k');hold on;
end
ylim([-0.1 1.1]);ylabel('\rho');set(gca,'xcolor','none');set(gca,'FontSize',f_size);set(gca,'YColor',[0 0 0]);box off;

subplot(7*(length(Tax_levels)+1),1,7*(t)+[7]);
plot(xlims,ylims,'color',[1 1 1]);
box off;set(gca,'ycolor','none');set(gca,'FontSize',f_size);xlabel('SV');

