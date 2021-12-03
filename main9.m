%样本数量相同的9类放到网络结构里
%%模型
%%Load Net
% load ('net.mat')
%%Network configuration 
opts = trainingOptions('adam', 'InitialLearnRate', 0.00005, 'MaxEpochs', 150, 'MiniBatchSize', 256, 'Plots','training-progress');
i=1;l = 1;num = 1;acu = zeros(1,144);
ii = 1;
while i<= 144
    m = 1; n=1;
    train_label = strings(144-1,1); test_label = strings(1,1);train_C = zeros(28,28,3,144-1);test_C = zeros(28,28,3,1);
    for k = 1:i-1
        train_label(m,:) = qutrain_label(k,:);
        train_C(:,:,:,m) = qutrain_C(:,:,:,k);
        m = m+1;
    end 
    for k = i+1:144
        train_label(m,:) = qutrain_label(k,:);
        train_C(:,:,:,m) = qutrain_C(:,:,:,k);
        m = m+1;
    end    
    for k = i
        test_label(1,:) = qutrain_label(k,:);
        test_C(:,:,:,1) = qutrain_C(:,:,:,k);
    end   
    train_label=categorical(cellstr (train_label)); 
    test_label=categorical(cellstr (test_label)); 
%   Train model
    myNet = trainNetwork(train_C,train_label,net,opts);
  
%   Test images using trained model
    predictedLabels = classify(myNet,test_C);
    acu(1,num) = sum(predictedLabels == test_label)
    predictedLabels=string(predictedLabels);
    test_label=string(test_label);
   
    i = i+1;
   
    num = num+1
end

sum1 = 144;
accurac = sum(acu)/sum1
