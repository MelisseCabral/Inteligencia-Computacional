%{
Melisse Pontes Cabral - 406643
1ª TR
%}

% Questão 2

D =[122 139 0.115;
114 126 0.120;
086 090 0.105;
134 144 0.090;
146 163 0.100;
107 136 0.120;
068 061 0.105;
117 062 0.080;
071 041 0.100;
098 120 0.115];

x = D(:,1);
y = D(:,2);
z = D(:,3);

[M N]= size(D);

title('Regressão');
xlabel('x');
ylabel('y');
zlabel('z');

hold on;
grid on;

plot3(x, y, z, 'd');

X=[ones(10,1),D(:,1), D(:,2)];

beta=((X'*X)^(-1)*X'*D(:,3));

[X1,X2]=meshgrid(40:0.6:150,40:0.6:150);

y_c = beta(1)+beta(2).*X1+beta(3).*X2;
y_c1= beta(1)+beta(2).*D(:,1)+beta(3).*D(:,2);

mesh(X1, X2, y_c);

y = (D(:,3));

for i= 0:length(y)
   error = y(1:i,1)-y_c1(1:i,1); 
end
 

sqe = sum((error).^2);

syy = sum((y-mean(y)).^2);

R2= 1 - (sqe/syy);

display(R2)