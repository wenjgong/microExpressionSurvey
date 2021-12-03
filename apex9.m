%9个标签  将所有的顶点帧和标签得到

maindir = 'E:\shujuku\input'; %自己修改需要的路径
  k = 1; 
  %%用来训练的test的计数
  E = 1;
  %%用来测试的train的计数
  e = 1;

  all2_C = zeros(28,28,3,640);
  
  A = 1;M =10;
% 一、SAMM 灰度图像 有顶点帧   
f=1;F = 2;  bian = 2;
for k1 = 1:31 
    subdir =  dir( maindir );
     if( isequal( subdir( k1 ).name, '.' ) ||  isequal( subdir( k1 ).name, '..' ) || ~subdir(k1 ).isdir )   % 如果不是目录跳过
        continue; 
     end  
     subpath = [ maindir,'\',subdir( k1 ).name];
    subsubdir = dir(subpath);

for i = 1 : length( subsubdir ) 
    if( isequal( subsubdir( i ).name, '.' ) ||  isequal( subsubdir( i ).name, '..' ) || ~subsubdir( i ).isdir )   % 如果不是目录跳过
        continue; 
    end      
    subsubdirpath = [ maindir,'\',subdir(k1).name '\',subsubdir(i).name,'\',subdir(k1).name,'_']; %得到图片所处的位置
   %%得到顶点帧，初始帧为1.jpg
   [NUM1,TXT1,RAW1] = xlsread('E:\samm.xls');
   [subsubdirpath,num2str(NUM1(f,2)),'.jpg'] 
  Image2 = imresize(imread([subsubdirpath,num2str(NUM1(f,2)),'.jpg']),[28 28]);
  all2_C(:,:,1,e)= Image2;

  %%标签
  all2_label(e,:) = [cell2mat(TXT1(F,5)),zeros(1,M-length(cell2mat(TXT1(F,5))))];
 
  e = e+1;
  f =f+1;
     %标签
  F = F+1;
end

    
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
%     n = floor((N+1)/2);
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
   

Maindir = 'E:\database\CASME2\CASME2_preprocessed_small_Li Xiaobai\input';
%三、CASME2  有顶点帧  初始帧 彩色图片
z = 1;
for k3 = 1:27
    subdir =  dir( Maindir ); 
     if( isequal( subdir( k3 ).name, '.' ) ||  isequal( subdir( k3 ).name, '..' ) || ~subdir(k3 ).isdir )   % 如果不是目录跳过
        continue; 
     end  
     subpath = [ Maindir,'\',subdir( k3 ).name];
    subsubdir = dir(subpath);

 for i = 1 : length( subsubdir ) 
    if( isequal( subsubdir( i ).name, '.' ) ||  isequal( subsubdir( i ).name, '..' ) || ~subsubdir( i ).isdir )   % 如果不是目录跳过
        continue; 
    end      
    subsubdirpath = [ Maindir,'\',subdir(k3).name '\',subsubdir(i).name,'\reg_img'];
   
    %%得到xlsx里面的中间帧，标签
    [NUM3,TXT3,RAW3] = xlsread('E:\casme2.xls');
    [subsubdirpath,num2str(NUM3(z,2)),'.jpg']
   
    Image6 = imresize(imread([subsubdirpath,num2str(NUM3(z,2)),'.jpg']),[28 28]);
    all2_C(:,:,:,e)= Image6;
    
     z = z+1;
  %%标签
   all2_label(e,:) = [cell2mat(TXT3(z,4)),zeros(1,M-length(cell2mat(TXT3(z,4))))];
   e = e+1;
  end

 end



%四、CASME 灰度图像
[NUM4,TXT4,RAW4] = xlsread('E:\database\CASME\CASME.xls');

maindir2 = 'E:\2\CASME';  
D = 1; 
for g = 2:190  
    subpath2 = [maindir2,'\','sub',num2str(NUM4(g-1,1)),'\', cell2mat(RAW4(g,2)),'\',cell2mat(RAW4(g,2)),'-',num2str(NUM4(g-1,4)),'.jpg']
    Image8 = imresize(imread(subpath2),[28 28]);  
    all2_C(:,:,1,e)= Image8;

  %%标签
  all2_label(e,:) = [cell2mat(TXT4(g,5)),zeros(1,M-length(cell2mat(TXT4(g,5))))];
  e = e+1;
 end 

      

%%五、CAS(ME)2 彩色图像
[NUM5,TXT5,RAW5] = xlsread('E:\database\CAS(ME)2\CAS(ME)2.xls');

maindir3 = 'E:\database\CAS(ME)2\cropped'; 
H = 1;
for h = 1:54
    subpath2 = [maindir3,'\',num2str(NUM5(h,1)),'\', cell2mat(RAW5(h,2)),'\img',num2str(NUM5(h,4)),'.jpg']
    Image10 = imresize(imread(subpath2),[28 28]);
   all2_C(:,:,:,e)= Image10;
     
  %%标签
  all2_label(e,:) = [cell2mat(TXT5(h,5)),zeros(1,M-length(cell2mat(TXT5(h,5))))];
  e = e+1;
end 
%数据库输入结束

 %大写变小写
for i = 1:640
    if all2_label(i)>='A' && all2_label(i)<='Z'
      all2_label(i)= char(all2_label(i)+32);
    end    
end
for i = 1:640
    if strncmp(all2_label(i,:),'others    ',4)
      all2_label(i,:)= 'other     ';
    end    
end

j = 1;
for i= 1:640
if strncmp(all2_label(i,:),'anger     ',5)|| strncmp(all2_label(i,:), 'sadness   ',5)|| strncmp(all2_label(i,:),'surprise  ',5)||strncmp(all2_label(i,:),'fear      ',4) || strncmp(all2_label(i,:),'other     ',5)|| strncmp(all2_label(i,:), 'happiness ',5)||strncmp(all2_label(i,:),'disgust   ',5) || strncmp(all2_label(i,:),'repression',5)|| strncmp(all2_label(i,:),'tense     ',5)
    all_label(j,:) = all2_label(i,:);
    all_C(:,:,:,j) = all2_C(:,:,:,i);
    j=j+1;   
end   
end    



