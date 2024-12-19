# Bees CNN Algorithm
- [![View Bees CNN Evolutionary Algorithm on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/105510-bees-cnn-evolutionary-algorithm)

- Bees CNN Algorithm (A Fuzzy Evolutionary Deep Learning) - Created in 20 Jan 2022 by Seyed Muhammad Hossein Mousavi

<div align="justify">
 
- It is possible to fit deep learning weights and bias using evolutionary algorithm, right after training stage. Here, CNN is used to classify 8 face classes. After CNN train, initial fuzzy model is created to aid the learning process. Finally, CNN network weights (from Fully Connected Layer) trains using Bees algorithm to be fitted in a nature inspired manner (here behavior of Bees). You can used your data with any number of samples and classes. Remember, code's parameters are adjusted for this data and if you want to replace your data you may have to change the parameters. Image data is in 64*64 size and in 2 dimensions and stored in 'CNNDat' folder. So, important parameters are as below:

</div>

![Bees CNN](https://user-images.githubusercontent.com/11339420/150426815-417019d7-f7af-4de2-890e-582411724840.jpg)
 
- 1.
- 'numTrainFiles' = you have to change this based on number of your samples in each class. for example if each class has 120 sample, 90 is good enough as 90 samples considered for train and others for test.
- 2.
- 'imageInputLayer' = it is size of your image data like [64 64 1]
- 3.
- 'fullyConnectedLayer' = it is number of your classes like (8)
- 4.
- 'MaxEpochs' = the more the better and more computation run time like 40
- 5.
- 'ClusNum' = Fuzzy C Means (FCM) Cluster Number like 3 or 4 is nice
- 6.
- These two are from "BEEFCN.m" function :
- 'Params.MaxIt' = it is iteration number in Bees algorithm. 20 is good 'Params.nScoutBee' = it is population number in Bees algorithm. Like 10.


- Feel free to contact me if you find any problem using the code: 
- Author: SeyedMuhammadHosseinMousavi
- My Email: mosavi.a.i.buali@gmail.com 
- Hope it help you, enjoy the code and wish me luck :)


