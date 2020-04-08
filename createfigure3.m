function createfigure3(FractionalVariance,Cum_FractionalVariance)
%CREATEFIGURE(X1, YMatrix1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 27-Feb-2020 15:36:22

% Create figure
figure1 = figure('NumberTitle','off','Name','Figure 3: SVD spectrum','Color',[1 1 1]);
set(gcf,'position',[200 200 250 200]);

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(100*FractionalVariance,'o','Parent',axes1,'MarkerSize',5,'LineWidth',1,...
    'Color',[0 0 0]);
plot1=plot(100*Cum_FractionalVariance,'Parent',axes1,'MarkerSize',5,'LineWidth',1,...
    'Color',[0 0 0]);
legend({'Per component','Cumulative'});
legend boxoff;

% Create ylabel
ylabel('Fractional Variance (%)');

% Create xlabel
xlabel('Component');

% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes1,[1e-06 100]);
% Set the remaining axes properties
set(axes1,'FontSize',8);
% Create legend
legend(axes1,'show');

% Create axes
axes2 = axes('Parent',figure1,'Position',[0.45 0.275 0.4 0.5]);
hold(axes2,'on');

% Create multiple lines using matrix input to plot
plot(100*FractionalVariance,'o','Parent',axes2,'MarkerSize',5,'LineWidth',1,...
    'Color',[0 0 0]);
plot(100*Cum_FractionalVariance,'Parent',axes2,'MarkerSize',5,'LineWidth',1,...
    'Color',[0 0 0]);

% Create ylabel and x label
ylabel('Fractional Variance (%)');
xlabel('Component');

% Uncomment the following line to preserve the X-limits of the axes
xlim(axes2,[0 20]);
% Set the remaining axes properties
set(axes2,'FontSize',8,'YColor',[0 0 0]);
