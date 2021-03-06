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
