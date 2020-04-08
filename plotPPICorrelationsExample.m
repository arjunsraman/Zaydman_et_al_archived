function []=plotPPICorrelationsExample(V_protein,V_protein_shuffled)

f_size=8;
load('Examples.mat');
win_width=10;win_starts=[3;20;50;100;200;500;1000;2000;4000];
xlims=[win_starts win_starts+win_width];ylims=([-0.08 0.08]);

fn=fieldnames(Examples);



for f=1:2
    figure('NumberTitle', 'off', 'Name', Examples.(fn{f}).label);set(gcf,'color','white');set(gcf,'position',[100 450-(f-1)*350 800 250]);

    for i=1:1:length(xlims(:,1))

        subplot(3,2*length(xlims(:,1)),2*(i-1)+[1 2]);
        plot(V_protein(Examples.(fn{f}).indices,:)','color',Examples.(fn{f}).color);hold on;
        xlim(xlims(i,:));xticks([xlims(i,:)]);xtickangle(90);ylim(ylims);yticks([ylims(1) 0 ylims(2)]);
        set(gca,'xcolor','none');set(gca,'FontSize',f_size);box off;ylabel('|V>');set(gca,'ycolor','none');
        if i==1
           set(gca,'ycolor',[0 0 0]);ylabel('|V_{protein}>');
        end
        subplot(3,2*length(xlims(:,1)),2*(i-1)+[1 2]+2*length(xlims(:,1)));
        plot(V_protein_shuffled(Examples.(fn{f}).indices,:)','color',[0.5 0.5 0.5]);hold on;
        xlim(xlims(i,:));xticks([xlims(i,:)]);xtickangle(90);ylim(ylims);yticks([ylims(1) 0 ylims(2)]);
        set(gca,'xcolor','none');set(gca,'FontSize',f_size);box off;ylabel('|V>');set(gca,'ycolor','none');
        if i==1
           set(gca,'ycolor',[0 0 0]);ylabel('|V_{protein shuffled}>');
        end
        subplot(3,2*length(xlims(:,1)),2*(i-1)+[1 2]+4*length(xlims(:,1)));
        for j=xlims(i,1):1:xlims(i,2)
            rho=corr(V_protein(Examples.(fn{f}).indices,j-2:j+2)');rho(isnan(rho))=0;rho=rho(triu(rho,1)~=0);
            plot(j,mean(rho),'.','color',Examples.(fn{f}).color,'MarkerSize',9);hold on;
            rho=corr(V_protein_shuffled(Examples.(fn{f}).indices,j-2:j+2)');rho(isnan(rho))=0;rho=rho(triu(rho,1)~=0);
            plot(j,mean(rho),'.','color',[0.5 0.5 0.5],'MarkerSize',9);hold on;
        end
        set(gca,'ycolor','none');ylim([-0.2 1]);box off;xtickangle(90);xlim(xlims(i,:));xticks(xlims(i,:));
        if i==1
           set(gca,'ycolor',[0 0 0]);ylabel('\rho');xlabel('SV');
        end
    end
end