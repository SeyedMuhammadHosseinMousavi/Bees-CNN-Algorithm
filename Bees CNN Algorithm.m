%% Bees CNN Algorithm (A Fuzzy Evolutionary Deep Leaning) - Created in 20 Jan 2022 by Seyed Muhammad Hossein Mousavi
% It is possible to fit deep learning weights and bias using evolutionary
% algorithm, right after training stage. Here, CNN is used to classify 8
% face classes. After CNN train, initial fuzzy model is created to aid the
% learning process. Finally, CNN network weights (from Fully Connected Layer)
% trains using Bees algorithm
% to be fitted in a nature inspired manner (here behavior of Bees). You can
% used your data with any number of samples and classes. Remember, code's
% parameters are adjusted for this data and if you want to replace your
% data you may have to change the parameters. Image data is in 64*64 size and
% in 2 dimensions and stored in 'CNNDat' folder. So, important parameters 
% are as below:
% 1.
% 'numTrainFiles' = you have to change this based on number of your samples
% in each class. for example if each class has 120 sample, 90 is good
% enough as 90 samples considered for train and others for test.
% 2.
% 'imageInputLayer' = it is size of your image data like [64 64 1]
% 3.
% 'fullyConnectedLayer' = it is number of your classes like (8)
% 4.
% 'MaxEpochs' = the more the better and more computation run time like 40
% 5.
% 'ClusNum' = Fuzzy C Means (FCM) Cluster Number like 3 or 4 is nice
% 6.
% These two are from "BEEFCN.m" function :
% 'Params.MaxIt' = it is iteration number in Bees algorithm. 20 is good
% 'Params.nScoutBee' = it is population number in Bees algorithm. Like 10.
% ------------------------------------------------ 
% Feel free to contact me if you find any problem using the code: 
% Author: SeyedMuhammadHosseinMousavi
% My Email: mosavi.a.i.buali@gmail.com 
% My Google Scholar: https://scholar.google.com/citations?user=PtvQvAQAAAAJ&hl=en 
% My GitHub: https://github.com/SeyedMuhammadHosseinMousavi?tab=repositories 
% My ORCID: https://orcid.org/0000-0001-6906-2152 
% My Scopus: https://www.scopus.com/authid/detail.uri?authorId=57193122985 
% My MathWorks: https://www.mathworks.com/matlabcentral/profile/authors/9763916#
% my RG: https://www.researchgate.net/profile/Seyed-Mousavi-17
% ------------------------------------------------ 
% Hope it help you, enjoy the code and wish me luck :)

%% Cleaning
 clear;
 clc;
 warning('off');
 
%% CNN Deep Neural Network
% Load the deep sample data as an image datastore. 
deepDatasetPath = fullfile('CNNDat');
imds = imageDatastore(deepDatasetPath, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
% Divide the data into training and validation data sets
numTrainFiles = 90;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');
% Define the convolutional neural network architecture.
layers = [
% Image Input Layer An imageInputLayer 
    imageInputLayer([64 64 1])
% Convolutional Layer 
convolution2dLayer(3,8,'Padding','same')
% Batch Normalization 
    batchNormalizationLayer
% ReLU Layer The batch
    reluLayer
% Max Pooling Layer  
    % More values means less weights
    maxPooling2dLayer(4,'Stride',4)
    %------------------------------
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(5,'Stride',5)
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
% Fully Connected Layer (Number of Classes) 
    fullyConnectedLayer(8)
% Softmax Layer 
    softmaxLayer
% Classification Layer The final layer 
    classificationLayer];
% Specify the training options
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.001, ...
    'MaxEpochs',20, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',8, ...
    'Verbose',false, ...
    'Plots','training-progress');
% Train the network 
[net,info]= trainNetwork(imdsTrain,layers,options);

%% Bees Algorithm Weight Fitting
% Converting Serial Network to an Object
netobj = net.saveobj;
% Extracting Fully Connected Layer's Weights To Evolve
FullConn=netobj.Layers(13, 1).Weights;
netbias=netobj.Layers(13, 1).Bias;

%% Data for Each Weight
sizefinal=size(FullConn);
sizefinal=sizefinal(1,1);
for i=1:sizefinal
Inputs=FullConn(i,:);
Targets=Inputs;
data.Inputs=Inputs;
data.Targets=Targets;
datam{i}=JustLoad(data);
end;

%% Making Basic Fuzzy Model for Each Class Weight
% Fuzzy C Means (FCM) Cluster Number
ClusNum=3; 
% Creating Initial Fuzzy Model to Employ for Each Class Weight
for i=1:sizefinal
fism{i}=GenerateFuzzy(datam{i},ClusNum);
end

%% Tarining Bees Algorithm
% Fitting Fully Connected Layer's Weights with Bees Algorithm
for i=1:sizefinal
disp(['Bees Are Working on Weights of Class # (' num2str(i) ')']);
BeesFISm{i}=BEEFCN(fism{i},datam{i}); 
end;

%% Train Output Extraction
for i=1:sizefinal
TrTar{i}=datam{i}.TrainTargets;
TrInp{i}=datam{i}.TrainInputs;
TrainOutputs{i}=evalfis(TrInp{i},BeesFISm{i});
end;
% Train Errors
for i=1:sizefinal
tmp=datam{i};
tt=tmp.TrainTargets;
tp=TrainOutputs{i};
Errors{i}=tt-tp;
MSE{i}=mean(Errors{i}.^2);
RMSE{i}=sqrt(MSE{i});  
error_mean{i}=mean(Errors{i});
error_std{i}=std(Errors{i});
end;
% Convereting Output Cell to Matrix
for i=1:sizefinal
EvolvedFullConn(i,:)=TrainOutputs{i}';
end;

%% Replacing Evolved Weights
netobj.Layers(13, 1).Weights=EvolvedFullConn;
% New Network
Newnet=netobj.Layers;
% Converting Network to Serial Network
BeesNet = assembleNetwork(Newnet);

%% Predict The Labels 
% Common CNN Accuracy
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;
CNNaccuracy = sum(YPred == YValidation)/numel(YValidation);
% Bees CNN Accuracy
YPredbee = classify(BeesNet,imdsValidation);
YValidationbee = imdsValidation.Labels;
Beesaccuracy = sum(YPredbee == YValidationbee)/numel(YValidationbee);

%% Confusion Matrix
figure;
plotconfusion(YPred,YValidation);
title(['CNN Accuracy  =  ' num2str(CNNaccuracy)]);
figure;
plotconfusion(YPredbee,YValidationbee);
title(['Bees-CNN Accuracy  =  ' num2str(Beesaccuracy)]);

%% Statistics
fprintf('The CNN Accuracy Is =  %0.4f.\n',CNNaccuracy*100)
fprintf('The Bees CNN Accuracy Is =  %0.4f.\n',Beesaccuracy*100)

