load('twomoons.dat');

%{
    Melisse Pontes Cabral - 406643
    3 TR
%}

% Questao 1

base = twomoons;

neuro_ocultos = 7;
params = 2;

% Vetor de entrada
X = base(:,1:2)';
% Vetor de sa�da
D = base(:,3)';

for i = 1:2
    X(i,:) = (X(i,:)-mean(X(i,:)))/std(X(i,:));
end

% Bias.
X = [(-1)*ones(1,1001);X];

W = 0.1*rand(neuro_ocultos,(params+1));

u = W*X;
z = 1./(1+exp(-u));
z = [(-1)*ones(1,1001);z];

M = D*z'*inv(z*z');

x_teste = zeros(3,1);
z = zeros(3,1);

for i = -2:0.05:2
    for j = -2.5:0.05:2.5
        x_teste = [-1;j;i];
        u = W*x_teste;
        z = 1./(1+exp(-u));
        z = [-1;z];
        a_teste = M*z;

        if (a_teste>=-0.1)&&(a_teste<=0.1)

            scatter(x_teste(2),x_teste(3),3,'d', 'black'), hold on
        end
    end
end
%plota pontos das classes
scatter(X(2,:), X(3,:), 4, D>0 ,'d');