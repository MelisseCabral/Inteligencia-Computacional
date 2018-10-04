%{
    Melisse Pontes Cabral - 406643
    1ª TR
%}

% Questão 1

load aerogerador;

speed_wind = aerogerador(:,1);
pot = aerogerador(:,2);
[M N]= size(aerogerador);
lambda = 0.000001;

X_2 = [ones(M,1) speed_wind speed_wind.^2];
X_3 = [ones(M,1) speed_wind speed_wind.^2 speed_wind.^3];
X_4 = [ones(M,1) speed_wind speed_wind.^2 speed_wind.^3 speed_wind.^4];
X_5 = [ones(M,1) speed_wind speed_wind.^2 speed_wind.^3 speed_wind.^4 speed_wind.^5];

ordem = 0;

while 1 >= ordem || ordem > 5
    ordem= input('Digite o grau do polinomio de 2 a 5: ');
end

switch ordem ~= 0
    case ordem == 2
        X = X_2;
    case ordem == 3
        X = X_3;        
    case ordem == 4
        X = X_4;
    case ordem == 5
        X = X_5;       
end

[m n] = size(X); 
mat = ordem + 1;
beta = (inv((X'*X + lambda*mat)))*(X'*pot);
disp('Valores Betas para a regressao polinomial: ');
disp(beta);
new_value = X*beta;

hold on;
plot(speed_wind, pot, 'd');
title('Regressao aerogerador');
xlabel('Velocidade m/s');
ylabel('Potencia KW');

plot(speed_wind, new_value, 'k');

for i = 1:M
        sqe(i) = (pot(i) - new_value(i))^2;
        syy(i) = (pot(i) - mean(pot))^2;
end

    error = sum(sqe)/sum(syy);
    r_2 = 1 - error;
    disp('Metrica R^2:');
    disp(r_2);
    
    for i = 1:M
        sqe_n(i) = (((pot(i) - new_value(i))^2))/(m - mat);
        syy_m(i) = (((pot(i) - mean(pot))^2)/(m-1));
    end
    
    val_2aj = sum(sqe_n)/sum(syy_m);
    
    r_2aj = 1 - val_2aj;
    disp('Metrica R^2aj:');
    disp(r_2aj);    