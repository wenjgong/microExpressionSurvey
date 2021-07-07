%每个for代表了一个数据库
%在保存上动手脚  
%其实完全可以不动数据库，在代码里进行切割，大小改变
%在文件夹里随机生成一个数，把它放到测试集里
%%第一个测试
maindir = 'E:\shujuku\input'; %自己修改需要的路径
  k = 1; 
  %%用来训练的test的计数
  E = 1;
  %%用来测试的train的计数
  e = 1;

  all_C = zeros(28,28,3,715);
  
  A = 1;M =10;c=1;
% 一、SAMM 灰度图像 有顶点帧   
f=1;F = 2;  bian = 2;
for k1 = 1:31 
    subdir =  dir( maindir );
     if( isequal( subdir( k1 ).name, '.' ) ||  isequal( subdir( k1 ).name, '..' ) || ~subdir(k1 ).isdir )   % 如果不是目录跳过
        continue; 
     end  
     subpath = [ maindir,'\',subdir( k1 ).name];
    subsubdir = dir(subpath);
   G(c)=length( subsubdir )-2;
   c = c+1;
for i = 1 : length( subsubdir ) 
    if( isequal( subsubdir( i ).name, '.' ) ||  isequal( subsubdir( i ).name, '..' ) || ~subsubdir( i ).isdir )   % 如果不是目录跳过
        continue; 
    end      
    subsubdirpath = [ maindir,'\',subdir(k1).name '\',subsubdir(i).name,'\',subdir(k1).name,'_']; %得到图片所处的位置
   %%得到顶点帧，初始帧为1.jpg
   [NUM1,TXT1,RAW1] = xlsread('E:\Shallow Triple Stream Three-dimensional CNN (STSTNet) for\STSTNet-master\samm.xls');
    %%根据得到的两个帧计算光流
   load opticalFlowTest;
  Image1 = imresize(imread([subsubdirpath,num2str(NUM1(f,1)),'.jpg']),[28 28]);
  Image2 = imresize(imread([subsubdirpath,num2str(NUM1(f,2)),'.jpg']),[28 28]);
  [Vx,Vy]=opticalFlow(Image1,Image2,'smooth',1,'radius',10,'type','LK');
  m = abs(sqrt(Vx^2+Vy^2));

  %%光流信息放到train
  all2_C(:,:,1,e)=Vx;
  all2_C(:,:,2,e)=Vy;
  all2_C(:,:,3,e)=m;
  %%标签
  all2_label(e,:) = [cell2mat(TXT1(F,5)),zeros(1,M-length(cell2mat(TXT1(F,5))))];
  
  e = e+1;
  f =f+1;
end
   %标签
    F = F+1;
    
end

% e
% % 二、SMIC 彩色图片  没有顶点帧
% B = 1;
% for k2 = 32:47 
%    
%     subdir =  dir( maindir ); 
%      if( isequal( subdir( k2 ).name, '.' ) ||  isequal( subdir( k2 ).name, '..' ) || ~subdir(k2 ).isdir )   % 如果不是目录跳过
%         continue; 
%      end  
%      subpath = [ maindir,'\',subdir( k2 ).name];
%     subsubdir = dir(subpath);
%      G(c)=length( subsubdir )-2;
%      c = c+1;
%  for i = 1 : length( subsubdir ) 
%     if( isequal( subsubdir( i ).name, '.' ) ||  isequal( subsubdir( i ).name, '..' ) || ~subsubdir( i ).isdir )   % 如果不是目录跳过
%         continue; 
%     end      
%     subsubdirpath = [ maindir,'\',subdir(k2).name '\',subsubdir(i).name,'\'];
%     all_imgs=dir([subsubdirpath,  '*.jpg']);
%     %%得到初始帧和顶点帧
%     Imagepath2 = fullfile( subsubdirpath,  '*.jpg' );
%     images2 = dir( Imagepath2 );
%     N=length(images2); %图像的长度
%     n = floor(N/2);
%     %%计算光流
%     load opticalFlowTest;
%     imagepath3 = [subsubdirpath,all_imgs(1).name];
%     imagepath4 = [subsubdirpath, all_imgs(n).name];
%     Image3 = imread(imagepath3);
%     Image4 = imread(imagepath4);
%     [Vx,Vy]=opticalFlow(rgb2gray(Image3),rgb2gray(Image4),'smooth',1,'radius',10,'type','LK');
%     m = abs(sqrt(Vx^2+Vy^2));
%    [NUM2,TXT2,RAW2] = xlsread('E:\shujuku\SMIC.xls');
%     
%  
%   %%光流信息放到all
%   all_C(:,:,1,e)=Vx;
%   all_C(:,:,2,e)=Vy;
%   all_C(:,:,3,e)=m;
%   %%标签
%   all_label(e,:) = cell2mat(TXT2(B,1));
%    e = e+1;
% 
%   B = B+1;
%  end
% 
% end
   
   
   


%三、CASME2  有顶点帧  初始帧
z = 1;
for k3 = 48:71
    subdir =  dir( maindir ); 
     if( isequal( subdir( k3 ).name, '.' ) ||  isequal( subdir( k3 ).name, '..' ) || ~subdir(k3 ).isdir )   % 如果不是目录跳过
        continue; 
     end  
     subpath = [ maindir,'\',subdir( k3 ).name];
    subsubdir = dir(subpath);
    %%G记录文件夹的个数
     G(c)=length( subsubdir )-2;
     c = c+1;
 for i = 1 : length( subsubdir ) 
    if( isequal( subsubdir( i ).name, '.' ) ||  isequal( subsubdir( i ).name, '..' ) || ~subsubdir( i ).isdir )   % 如果不是目录跳过
        continue; 
    end      
    subsubdirpath = [ maindir,'\',subdir(k3).name '\',subsubdir(i).name,'\reg_img'];
    %%得到xlsx里面的初始帧，中间帧，标签
    [NUM3,TXT3,RAW3] = xlsread('E:\Shallow Triple Stream Three-dimensional CNN (STSTNet) for\STSTNet-master\casme2.xls');
    Image5 = imread([subsubdirpath,num2str(NUM3(z,1)),'.jpg']);
    Image6 = imread([subsubdirpath,num2str(NUM3(z,2)),'.jpg']);
    %%计算光流
     [Vx,Vy]=opticalFlow(rgb2gray(Image5),rgb2gray(Image6),'smooth',1,'radius',10,'type','LK');
      m = abs(sqrt(Vx^2+Vy^2));
    %%光流存储
     z = z+1;
 
  %%光流信息放到all
  all2_C(:,:,1,e)=Vx;
  all2_C(:,:,2,e)=Vy;
  all2_C(:,:,3,e)=m;
  %%标签
  all2_label(e,:) = [cell2mat(TXT3(z,4)),zeros(1,M-length(cell2mat(TXT3(z,4))))];
  e = e+1;
  end

 end




%四、CASME 灰度图像
[NUM4,TXT4,RAW4] = xlsread('E:\database\CASME\CASME.xls');
%计算文件夹个数
G(c)=0;
  bi = 1;
 for ai = 1:189
    if NUM4(ai,1) == bi
        G(c)=G(c)+1;
    else
        bi = bi+1;
        c = c+1;
        G(c) = 1;
    end
 end
maindir2 = 'E:\2\CASME';  
D = 1; 
for g = 2:190  
    subpath1 = [maindir2,'\','sub',num2str(NUM4(g-1,1)),'\', cell2mat(RAW4(g,2)),'\',cell2mat(RAW4(g,2)),'-',num2str(NUM4(g-1,3)),'.jpg'];
    subpath2 = [maindir2,'\','sub',num2str(NUM4(g-1,1)),'\', cell2mat(RAW4(g,2)),'\',cell2mat(RAW4(g,2)),'-',num2str(NUM4(g-1,4)),'.jpg'];
    Image7 = imresize(imread(subpath1),[28 28]);
    Image8 = imresize(imread(subpath2),[28 28]);
     %%计算光流
    load opticalFlowTest;
    [Vx,Vy]=opticalFlow(Image7,Image8,'smooth',1,'radius',10,'type','LK');
    m = abs(sqrt(Vx^2+Vy^2));
    %%光流存储
 
 %光流信息放到all
  all2_C(:,:,1,e)=Vx;
  all2_C(:,:,2,e)=Vy;
  all2_C(:,:,3,e)=m;
  %%标签
  all2_label(e,:) = [cell2mat(TXT4(g,5)),zeros(1,M-length(cell2mat(TXT4(g,5))))];
  e = e+1;
 end 

      

%%五、CAS(ME)2 彩色图像
[NUM5,TXT5,RAW5] = xlsread('E:\database\CAS(ME)2\CAS(ME)2.xls');
%计算文件夹个数
c = c+1;
G(c)=0;
  bi = 1;
 for ai = 1:54
    if NUM5(ai,6) == bi
        G(c)=G(c)+1;
    else
        bi = bi+1;
        c = c+1;
        G(c) = 1;
    end
 end
maindir3 = 'E:\database\CAS(ME)2\cropped'; 
H = 1;
for h = 1:54
    subpath1 = [maindir3,'\',num2str(NUM5(h,1)),'\', cell2mat(RAW5(h,2)),'\img',num2str(NUM5(h,3)),'.jpg'];
    subpath2 = [maindir3,'\',num2str(NUM5(h,1)),'\', cell2mat(RAW5(h,2)),'\img',num2str(NUM5(h,4)),'.jpg'];
    Image9 = imresize(imread(subpath1),[28 28]);
    Image10 = imresize(imread(subpath2),[28 28]);
     %%计算光流
    load opticalFlowTest;
    [Vx,Vy]=opticalFlow(rgb2gray(Image9),rgb2gray(Image10),'smooth',1,'radius',10,'type','LK');
    m = abs(sqrt(Vx^2+Vy^2));
    %%光流存储
      %%光流存储
    %%如果想换下一个当训练集，就在原基础上加一
    
   
      %光流信息放到all2
  all2_C(:,:,1,e)=Vx;
  all2_C(:,:,2,e)=Vy;
  all2_C(:,:,3,e)=m;
  %%标签
  all2_label(e,:) = [cell2mat(TXT5(h,4)),zeros(1,M-length(cell2mat(TXT5(h,4))))];
  e = e+1;
 end 

for i = 1:545
    if all2_label(i)>='A' && all2_label(i)<='Z'
      all2_label(i)= char(all2_label(i)+32);
    end    
end
for i = 1:545
    if strncmp(all2_label(i,:),'others    ',4)
      all2_label(i,:)= 'other     ';
    end    
end

j = 1;
for i= 1:545
if strncmp(all2_label(i,:),'anger     ',5)|| strncmp(all2_label(i,:), 'sadness   ',5)|| strncmp(all2_label(i,:),'surprise  ',5)||strncmp(all2_label(i,:),'fear      ',4) || strncmp(all2_label(i,:),'other     ',5)|| strncmp(all2_label(i,:), 'happiness ',5)||strncmp(all2_label(i,:),'disgust   ',5) || strncmp(all2_label(i,:),'repression',5)|| strncmp(all2_label(i,:),'tense     ',5)
all_label(j,:) = all2_label(i,:);
all_C(:,:,:,j) = all2_C(:,:,:,i);
j=j+1;
else
%     i
%     num = 1;num2 = zeros(1,85);
%       for l = 1:85
%         if i >= num && i <= num+G(1)-1
%             num2(l) = num2(l)+ 1;
%         end 
%         num = num + G(l);
%       end    
      
end   
end    
% for l = 1:85
%     G(l) = G(1)-num2(l);
% end
%%去除标签个数比较少的文件
G(75) = G(75)-2;
G(73) = G(73)-1;
G(59) = G(59)-1;
G(54) = G(54)-1;

%%模型
%%Load Net
load ('net.mat')
%%Network configuration 
opts = trainingOptions('adam', 'InitialLearnRate', 0.00005, 'MaxEpochs', 100, 'MiniBatchSize', 256);

i=1;l = 1;num = 1;acu = zeros(1,85);
while i<= 540
    m = 1; n=1;
    train_label = strings(540-G(l),1); test_label = strings(G(l),1);train_C = zeros(28,28,3,540-G(l));test_C = zeros(28,28,3,G(l));
   
    for k = 1:i-1
        train_label(m,:) = all_label(k,:);
        train_C(:,:,:,m) = all_C(:,:,:,k);
        m = m+1;
    end 
    for k = i+G(l):540
        train_label(m,:) = all_label(k,:);
        train_C(:,:,:,m) = all_C(:,:,:,k);
        m = m+1;
    end    
    for k = i:i+G(l)-1
        test_label(n,:) = all_label(k,:);
        test_C(:,:,:,n) = all_C(:,:,:,k);
        n = n+1;
    end   
    train_label=categorical(cellstr (train_label)); 
    test_label=categorical(cellstr (test_label)); 
    % Train model
    myNet = trainNetwork(train_C,train_label,net,opts);
    %  Test images using trained model
    predictedLabels = classify(myNet,test_C);
    acu(1,num) = sum(predictedLabels == test_label)
    i = i+G(l);
    l = l+1;
    num = num+1
end

sum1 = 540;
accurac = sum(acu)/sum1
