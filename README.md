# microExpressionSurvey
1.The programming software used for the code is MATLAB, preferably the version of MATLAB R2018b or above.

2.Change all paths in the code to your file paths.

3.According to the Excel table given, all the pictures in the database are corresponding to the labels in the table. The pictures are required to be processed into the format of 28x28x3, and the grayscale images are processed into the format of 28x28.

4.Run the apex4.m and apex9.m files to get the apex frame and the corresponding label in the database.

5.Run main4.m and main9.m files for training and testing, and the verification method used is LOVO.

6.Before running, you need to randomly sample the data to ensure that all labels are equal. C4.mat and C9.mat store the apex frames we have randomly selected, and label4.mat and label9.mat store the labels corresponding to the apex frames.

7.Before running, you need to load net4.mat and net9.mat.

8.The trained network is saved in net4.rar and net9.rar, which can reproduce the results in the paper.
