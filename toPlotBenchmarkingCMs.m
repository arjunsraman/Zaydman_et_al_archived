function [] = toPlotBenchmarkingCMs(BMs,RF_Models,Features)

fns=fieldnames(Features);
fns=fns([1 2 3 7 8 10 9 5 4 6]); 
titles={'Raw','\rho_{2-20}','MI windows','Epistasis','APMS1','APMS2','Y2H','GF','GC','GN'};
f_size=8;

for b=1:1:length(BMs)
    figure1=figure('NumberTitle','off',...
    'Name',BMs{b});
    set(gcf,'color','white');set(gcf,'Position',[100+(b-1)*300 100 300 800]);


    for f=1:1:length(fns)
        subplot(length(fns),4,(f-1)*4+[2 3]);
        TP=RF_Models.(fns{f}).Benchmarking.(BMs{b}).TP;
        TN=RF_Models.(fns{f}).Benchmarking.(BMs{b}).TN;
        FP=RF_Models.(fns{f}).Benchmarking.(BMs{b}).FP;
        FN=RF_Models.(fns{f}).Benchmarking.(BMs{b}).FN;
        CM=[TN FN; FP TP];
        Norm_CM=CM./sum(CM,2);
        imagesc(Norm_CM);
        colormap(flipud(gray));
        caxis([0 2]);
        xticks([1 2 3]);
        xticklabels({'Negative','Functional','Physical'});
        xtickangle(60);
        yticks([1 2 3]);
        yticklabels({'Negative','Functional','Physical'});
        set(gca,'TickLength',[0 0]);
        ylabel(titles{f});
        if f~=length(fns)
           xticklabels({}); 
        end
        if f==length(fns)
           xlabel('True class'); 
        end
        set(gca,'FontSize',8);

        for i=1:1:length(CM(:,1))
            for j=1:1:length(CM(1,:))
                text(i,j,num2str(CM(j,i)),'horizontalalignment','center','FontSize',f_size);
            end
        text(i,0.2,num2str(CM(i,i)/sum(CM(:,i)),2),'horizontalalignment','center','FontSize',f_size);
        text(2.8,i,num2str(CM(i,i)/sum(CM(i,:)),2),'horizontalalignment','center','FontSize',f_size);
        end
    end
end