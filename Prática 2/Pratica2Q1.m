load database_pap.dat
%{
    Melisse Pontes Cabral - 406643
    2ª TR
%}
 
% Questão 1
 
hits=0;
S=size(database_pap,2);
 
Z1=zeros(242,1);
O1=ones(242,1);
Z2=zeros(675,1); 
O2=ones(675,1);
 
class= [Z1 O1;O2 Z2]'; 
 
fprintf('A taxa de acertos de com leave one out: ')
 
base = database_pap';
 
for x=1:917
    base_training=base;
    base_training(:,x)=[];
    class_training=class;
    class_training(:,x)=[];
    M=(class_training*base_training')/(base_training*base_training');
    P=(M*base(:,x));
     
    result=[0;0]; 
     
    if P(1)>P(2)
        result(1)=1;
    else   
        result(2)=1;
    end
    if result==class(:,x); 
        hits=hits+1; 
    end
end
 
porcent=100*hits/917; 
fprintf('%G%%\n',porcent)
 
% Questão 2
 
k = 0;  
k = input('Qual valor de k voce deseja analisar?');
 
metodo = input('1. Vetores Brutos\n2.Vetores Normalizados\nEscolha os tipos de vetores que deseja utilizar [1 ou 2]: ');
 
if metodo == 2 
    for h=1:8
        database_pap(:,h)=(database_pap(:,h)-mean(database_pap(:,h)))/std(database_pap(:,h));
    end
 
else metodo == 1
    database_pap = database_pap;
end 
 
 
 
base = database_pap;
X = base(1,:);
 
test_indexs = randomTraining_Tester(base);
training_knn = getBaseTraining(test_indexs, base);
test_base = getBaseTest(test_indexs, base);
 
aux_dist_1 = getDE(2, 241, X, training_knn);
aux_dist_2 = getDE(242,916, X, training_knn);
 
m = sort(aux_dist_1);
m1 = sort (aux_dist_2);
 
cont = 0 ;
cont_1 = 0;
 
for w = 1:k  
    aux_dist_1(:,w)
    if aux_dist_1(:,w) < aux_dist_2(:, w)
          cont = cont+1;
    end
       aux_dist_2(:, w)
    if aux_dist_2(:,w) <  aux_dist_1(:,w)
          cont_1 = cont_1 + 1;
    end
end 
 
if cont > cont_1
    fprintf ( 'Pertence a classe 1')
end
if cont_1 > cont
    fprintf ( 'Pertence a classe 2')
end
 
function teste_sample = randomTraining_Tester(base)
    [m n] = size(base);
    aux = cast( m *0.30 , 'uint16')
    test = [];
    disp(base(1));
    for i = 1:aux
        r = cast((917*rand() ) , 'uint32');
        for j = 1:length(test)
            while (test(j) == r)
                r = cast((916*rand() ) , 'uint32');
            end
        end
        test = [test r];
    end
    teste_sample = test;
end
 
function base_test = getBaseTest(test_ind, base)
    base_test = [];
    for i = 1:275
        aux = test_ind(i);
        b = base(i,:);
        base_test = [base_test; b];
    end
    base_test = sort(base_test);
end
 
function base_training = getBaseTraining(test_ind, base)
    base_training = base;
    test_ind = sort(test_ind, 'descend');
    disp(test_ind);
    for i = 1:275
        aux = test_ind(i);
        base_training(aux, :) = [];
    end
end
 
 function aux_dist_= getDE(j, k, x, training_knn)
    for i = j:k
        DE = 0;
            for l = 1:8
                %Calculo da distancia euclidiana
                dist = sqrt(sum(((x(l) - training_knn(i,l))^2)));
                DE = DE + dist;
                 
            end
        aux_d(i) = DE;
    end
    aux_dist_ = aux_d;
 end