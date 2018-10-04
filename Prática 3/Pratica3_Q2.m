%{
    Melisse Pontes Cabral - 406643
    3ª TR
%}
 
% Questão 2
    
clear all;
clc;

load iris_log.dat

global base percent total_acertos m n aux_num_test num_rodadas ;

base = iris_log;

disp('REDE NEURAL RBF - CCOM TAXA MAX DE TESTES 40% (0.4)');
disp('Percentual da amostra de testes?');
percent = input(' ');
while percent == 0 || percent >= 0.4
    clc
    disp('REDE NEURAL RBF - CCOM TAXA MAX DE TESTES 40% (0.4)');
    disp('Percentual da amostra de testes?');
    percent = float(input('  '));
    
end

disp('Quantas vezes deseja executar para tirar a media ?');
num_rodadas = input('');
total_acertos = 0;
[m, n] = size(base);    
aux_num_test =  m * percent;

while num_rodadas == 0 
    num_rodadas = input('Percentual da amostra de testes?  : ');
    
end

%base de testes e treino
[base_test, base_training]  = getBaseTest();
X = base_training(:,1:4);
D = base_training(:,5:7);
    
for it  = 1:num_rodadas
    net = feedforwardnet([]);
    
    net = newrb(X', D');
    
    y = net(base_test(:,1:4)');
    
    [l c] = size(base_test(:,5:7)');  
    class_test = base_test(:,5:7)'; 

    acertos = 0;

    for i = 1: c  

        if class_test(1, i) == 1
            aux = 1;
        end
        if class_test(2, i) == 1
            aux = 2;
        end
        if class_test(3, i) == 1
            aux = 3;
        end

        for j = 1:3        
            if (y(j,i) == max(y(:,i)) && j == aux)
                acertos = acertos + 1;
            end
        end
    end
    total_acertos = acertos + total_acertos;
    clearvars -except base percent total_acertos cont m n aux_num_test base_test base_training X D num_rodadas;
end
taxa_acerto = total_acertos / (aux_num_test * num_rodadas) * 100;
fprintf('Taxa media de acerto é : %.2f %% \n',taxa_acerto);

function teste_sample = randomTraining_Tester()
    global m aux_num_test;   
    test = [];
    
    for i = 1:aux_num_test
        r = cast(((m + 1) *rand() ) , 'uint32');
        for k = 1:length(test)
            while (test(k) == r)
                r = cast((m*rand() ) , 'uint32');
            end
        end
        test = [test r];
    end
    teste_sample = test;
end
 
function [base_test, base_training ] = getBaseTest()
    test_ind = randomTraining_Tester();
    test_ind = sort(test_ind, 'descend');
    
    global base  aux_num_test;
    
    base_test = [];
    base_training = base;
    
    for j = 1:aux_num_test
        aux = test_ind(1,j) - 1;
        b = base(aux,:);
        base_test = [base_test; b];
        base_training(abs(aux), :) = [];
    end
end