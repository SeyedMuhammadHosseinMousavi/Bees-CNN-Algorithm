function bestfis=BEEFCN(fis,data)
% Variables
p0=GettingFuzzyParameters(fis);
Problem.CostFunction=@(x) FuzzyCost(x,fis,data);
Problem.nVar=numel(p0);
alpha=1;
Problem.VarMin=-(10^alpha);
Problem.VarMax=10^alpha;
% Bees Algorithm Parameters
Params.MaxIt=15;
Params.nScoutBee = 10;                                  % Number of Scout Bees
Params.nSelectedSite = round(0.5*Params.nScoutBee);     % Number of Selected Sites
Params.nEliteSite = round(0.4*Params.nSelectedSite);    % Number of Selected Elite Sites
Params.nSelectedSiteBee = round(0.5*Params.nScoutBee);  % Number of Recruited Bees for Selected Sites
Params.nEliteSiteBee = 2*Params.nSelectedSiteBee;       % Number of Recruited Bees for Elite Sites
Params.r = 0.1*(Problem.VarMax-Problem.VarMin);         % Neighborhood Radius
Params.rdamp = 0.95;                                    % Neighborhood Radius Damp Rate
% Starting Bees Algorithm
results=Runbee(Problem,Params);
% Getting the Results
p=results.BestSol.Position.*p0;
bestfis=FuzzyParameters(fis,p);
end
%% Bees
function results=Runbee(Problem,Params)
disp('Starting Bees Algorithm Training :)');
% Cost Function
CostFunction=Problem.CostFunction;
% Number of Decision Variables
nVar=Problem.nVar;
% Size of Decision Variables Matrixv
VarSize=[1 nVar];
% Lower Bound of Variables
VarMin=Problem.VarMin;
% Upper Bound of Variables
VarMax=Problem.VarMax;
% Some Change
if isscalar(VarMin) && isscalar(VarMax)
dmax = (VarMax-VarMin)*sqrt(nVar);
else
dmax = norm(VarMax-VarMin);
end
%% Bees Algorithm Parameters
MaxIt=Params.MaxIt;
nScoutBee = Params.nScoutBee;                % Number of Scout Bees
nSelectedSite = Params.nSelectedSite;        % Number of Selected Sites
nEliteSite = Params.nEliteSite;              % Number of Selected Elite Sites
nSelectedSiteBee = Params.nSelectedSiteBee;  % Number of Recruited Bees for Selected Sites
nEliteSiteBee = Params.nEliteSiteBee;        % Number of Recruited Bees for Elite Sites
r = Params.r;                                % Neighborhood Radius
rdamp = Params.rdamp;                        % Neighborhood Radius Damp Rate
%% Second Stage
% Empty Bee Structure
empty_bee.Position = [];
empty_bee.Cost = [];
% Initialize Bees Array
bee = repmat(empty_bee, nScoutBee, 1);
% Create New Solutions
for i = 1:nScoutBee
bee(i).Position = unifrnd(VarMin, VarMax, VarSize);
bee(i).Cost = CostFunction(bee(i).Position);
end
% Sort
[~, SortOrder] = sort([bee.Cost]);
bee = bee(SortOrder);
% Update Best Solution Ever Found
BestSol = bee(1);
% Array to Hold Best Cost Values
BestCost = zeros(MaxIt, 1);
%% Bees Algorithm Main Body
for it = 1:MaxIt
% Elite Sites
for i = 1:nEliteSite
bestnewbee.Cost = inf;
for j = 1:nEliteSiteBee
newbee.Position = PerformBeeDance(bee(i).Position, r);
newbee.Cost = CostFunction(newbee.Position);
if newbee.Cost<bestnewbee.Cost
bestnewbee = newbee;
end
end
if bestnewbee.Cost<bee(i).Cost
bee(i) = bestnewbee;
end
end
% Selected Non-Elite Sites
for i = nEliteSite+1:nSelectedSite
bestnewbee.Cost = inf;
for j = 1:nSelectedSiteBee
newbee.Position = PerformBeeDance(bee(i).Position, r);
newbee.Cost = CostFunction(newbee.Position);
if newbee.Cost<bestnewbee.Cost
bestnewbee = newbee;
end
end
if bestnewbee.Cost<bee(i).Cost
bee(i) = bestnewbee;
end
end
% Non-Selected Sites
for i = nSelectedSite+1:nScoutBee
bee(i).Position = unifrnd(VarMin, VarMax, VarSize);
bee(i).Cost = CostFunction(bee(i).Position);
end
% Sort
[~, SortOrder] = sort([bee.Cost]);
bee = bee(SortOrder);
% Update Best Solution Ever Found
BestSol = bee(1);
% Store Best Cost Ever Found
BestCost(it) = BestSol.Cost;
% Display Iteration Information
disp(['In Iteration Number ' num2str(it) '  Bees Algorithm Fittest Value Is = ' num2str(BestCost(it))]);
% Damp Neighborhood Radius
r = r*rdamp;
end
disp('Bees Algorithm Came To End :)');
% Store Res
results.BestSol=BestSol;
results.BestCost=BestCost;
% Plot Bees Algorithm Training Stages
set(gcf, 'Position',  [600, 300, 500, 400])
plot(BestCost,':',...
'LineWidth',2,...
'MarkerSize',8,...
'MarkerEdgeColor','g',...
'Color',[0.1,0.9,0.1]);
title('Bees Algorithm Training')
xlabel('Bees Algorithm Iteration Number','FontSize',10,...
'FontWeight','bold','Color','m');
ylabel('Bees Algorithm Fittest Value','FontSize',10,...
'FontWeight','bold','Color','m');
legend({'Bees Algorithm Train'});
end




