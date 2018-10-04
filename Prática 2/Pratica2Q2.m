load database_pap.dat

for i=1:8
    database_pap(:,i)=(database_pap(:,i)-mean(database_pap(:,i)))/std(database_pap(:,i));
end

base=database_pap';
Z1=zeros(242,1);
O1=ones(675,1);
classe= [Z1;O1]';

S=size(base,1);

total=0; 

net = perceptron; 
net.trainparam.lr = input('Taxa de aprendizagem: ');
net.trainparam.epochs=input('Epocas de treinamento: ');
N=round(917*0.7);

for P=1:10 
    W=randn(1,S); 
    j=randperm(917);
    
    for i=1:N
        X(:,i)=base(:,j(i));
        D(:,i)=classe(:,j(i));
    end
    
    for i=N+1:917 
        test(:,i-N)=base(:,j(i));
        result(:,i-N)=classe(:,j(i));
    end
    
    test=test';
    hits=0; 
    [net,tr] = train(net,X,D);
    net.IW{1,1}=W;
    
    for i=1:917-N
        found(i) = net(test(i,:)');
        e=result(i)-found(i);
        W=W+e*0.01*test(i,:);
        
        if found(i) == result(:,i);
            hits=hits+1;
        end
    end
    
    total=total+hits; 
    test=test';
end
porcent=10*total/(917-N); 
fprintf('A taxa de acerto foi de %G%%\n',porcent)