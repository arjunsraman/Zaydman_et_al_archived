function [EigGenes]=approxProteinProjections(Proteomes,Dij,V)

[C,iP,iD] = intersect(Proteomes.Ecoli.Domains.List,Dij.Data.ColLabels);
sorted_GeneDomainMatrix=Proteomes.Ecoli.Domains.UniprotGene_PFAM_Matrix(:,iP);
sorted_V=V(iD,:);
EigGenes=zeros(length(Proteomes.Ecoli.Domains.UniprotGene_PFAM_Matrix(:,1)),length(V(1,:)));
for i=1:1:length(Proteomes.Ecoli.Domains.UniprotGene_PFAM_Matrix(:,1))
    thisGene=find(sorted_GeneDomainMatrix(i,:));
    EigGenes(i,:)=mean(sorted_V(thisGene,:),1);
end