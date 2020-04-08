function [Outputs]=BenchmarkModels(Features,DataSets,Benchmarks,ClassificationTask,thisFeature)

% Assumptions: None

% Inputs:
%   Features: Structered object of features
%   Datasets: Structured object of datasets
%   Benchmarks: Structured object of benchmarks
%   thisFeature: String of the name of the current feature to be used


% Outputs:
%   Benchmarking    %Structured object of benchmarking results
        % Benchmark: structure of benchmark
            % TP,TN,FP,FN: Counts for each outcome
            % Pre,Rec: Precision and recall
            % F_Score: Array of predicted classes for the validation dataset

                        
% Date: Version 1: 3/9/2020
%       Version 2: 3/10/2020
%       Version 3: 3/11/2020

% Authors: Mark Zaydman and Arjun Raman
% ________________________________________

thisFeatures='IQRs';
% Make list of features
if strcmp(thisFeature,'IQRs')
    X=[Features.(thisFeature).Phylogeny(:),...
        Features.(thisFeature).Functional(:),...
        Features.(thisFeature).Physical(:)];
else
    X=Features.(thisFeature)(:);
end

%Find unique list of features
[X_Unique]=unique(X,'rows');

%Predict classes for unique list of features
Y_Unique = str2num(cell2mat(predict(ClassificationTask.(thisFeature).Model,X_Unique)));

%Build filter to remove training data
Filter_TrainingData=ones(size(Benchmarks.PDB.Data));
Filter_TrainingData(DataSets.TrainingSet.indices)=0;

%Make list of benchmarks
Benchmark_names=fieldnames(Benchmarks);
    
%Compute performance of each benchmark
for b=1:1:length(Benchmark_names)
    thisBenchmark=Benchmark_names{b}; 
    
    %Find unique list of predicted positive features values
    X_Pos=X_Unique(ismember(Y_Unique,Benchmarks.(thisBenchmark).Class),:);

    %Find indices of features with predicted positive values
    i_Pos=(ismember(X,X_Pos,'row'));  

    %Build matrix of predicted positives elements of the benchmark 
    Pos=zeros(size(Benchmarks.PDB.Data));
    Pos(i_Pos)=1;

    %Count outcomes
    TP=sum(sum(triu(Filter_TrainingData.*(Benchmarks.(thisBenchmark).Data~=0).*Pos,1)));
    FP=sum(sum(triu(Filter_TrainingData.*(Benchmarks.(thisBenchmark).Data==0).*Pos,1)));
    FN=sum(sum(triu(Filter_TrainingData.*(Benchmarks.(thisBenchmark).Data~=0).*~Pos,1)));
    TN=sum(sum(triu(Filter_TrainingData.*(Benchmarks.(thisBenchmark).Data==0).*~Pos,1)));

    %Calculate precision, recall, and F-score
    Pre=TP/(TP+FP);
    Rec=TP/(TP+FN);
    F_score=2*Pre*Rec/(Pre+Rec);

    %Output results
    Outputs.(thisBenchmark).TP=TP;
    Outputs.(thisBenchmark).FP=FP;
    Outputs.(thisBenchmark).TN=TN;
    Outputs.(thisBenchmark).FN=FN;
    Outputs.(thisBenchmark).Precision=Pre;
    Outputs.(thisBenchmark).Recall=Rec;
    Outputs.(thisBenchmark).F_score=F_score;
end


