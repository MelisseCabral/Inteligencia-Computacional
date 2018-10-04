
%{
    Melisse Pontes Cabral - 406643
    3ª TR
%}
 
% Questão 3
global population f tam_cromossomo taxa_crossover taxa_mutacao;

t=input('Digite o tamanho da population inicial: ');

for i = 1:t 
    population(i) = 0;
    for j = 1:20
        population(i,j) = round(rand);
    end
end

tam_cromossomo = 20;

taxa_crossover   = 1;
taxa_mutacao = 1;
best_individuo = maximo();

fprintf('O maximo valor da funcao encontrado %.2f: ', f);
function result = aptidao()
    global population f;

    [i_total,j_total] = size(population);

    % Calcular o f(x) de cada entrada
    for i=1:i_total     
        k = 1;    
        for j=1:j_total     
            % Cada elemento da population inicial
            x = population(i,j);

            % Funcao objetivo
            f = abs(i*sin((k*3.14)/4) + k*sin((i*3.14)/4));       
            k = k+1;
        end
    end

    % Calcular a aptidao
    p_i = (f / sum(f)) * 100;

    % Retorno da funcao
    result =p_i;

end

function result = crossover(parent_1,parent_2, nchildren, tam_cromossomo, taxa_crossover)

    % Transformar em binario
    parent_1 = dec2bin(parent_1,tam_cromossomo);
    parent_2 = dec2bin(parent_2,tam_cromossomo);

    % Aplicar o crossover?
    cross = roleta([taxa_crossover 100-taxa_crossover], 1);
    
    if cross(1,1) == 1        
        cut = floor(tam_cromossomo * rand(1,1))+1;

        children(1, 1:cut) = parent_1(1, 1:cut);
        children(1, cut+1:tam_cromossomo) = parent_2(1, cut+1:tam_cromossomo);

        if nchildren == 2
            children(2, 1:cut) = parent_2(1, 1:cut);
            children(2, cut+1:tam_cromossomo) = parent_1(1, cut+1:tam_cromossomo);
        end
        
    else
        children(1,:) = parent_1(1,:);
        children(2,:) = parent_2(1,:);
    end
    
    children = bin2dec(children);
    
    result = children;

end

function result = maximo()
    global population tam_cromossomo taxa_crossover taxa_mutacao;
    
    [m n] = size(population);

    prob_seletion = aptidao();

    for i = 1:100
        
        k = 1;
        while k <= m
            parent_1 = selecao(prob_seletion);
            parent_2 = selecao(prob_seletion);
            
            nchildren = 2;
            children(k:k+1,:) = crossover(parent_1, parent_2, nchildren, tam_cromossomo, taxa_crossover);

            k = k+2;
        end

        children = mutacao(children, tam_cromossomo, taxa_mutacao);

        elite_population  = max(population);
        elitechildren     = max(children);
        if elite_population > elitechildren
            [m_menor, n_menor] = min(children);
            children(n_menor,1) = elite_population;
        end
        population = children;

    end

    result = children;
end
function result=selecao(probSelecao)
    global population;

    if pi == 0
       
    else
        resp = roleta(probSelecao',1);
        selecionado = find(resp);
        
    end
    
    % Retorna o resultado
    result = population(selecionado,1);

end

function result=roleta(area, nJogadas)

    [lin nArea] = size(area);
    min = zeros(lin,nArea);
    max = zeros(lin,nArea);

    % Frequencia dos resultados em cada area
    y = zeros(lin,nArea);

    for i=1:nArea
        if(i == 1)
            min(i) = 1;
            max(i) = area(i);
        else
            min(i) = max(i-1) +1;
            max(i) = min(i)+area(i) -1;
        end    
    end

    min = ceil(min);
    max = ceil(max);

    for i=1:nJogadas
        rodada = ceil(rand*100);
        for k=1:nArea
            if ( (rodada >= min(k)) && (rodada <= max(k)))
                y(k) = y(k)+1;
            end
        end

    end

    result = y;
end
function result=mutacao(filhos, tamCromossomo, taxaMutacao)

    mut = roleta([taxaMutacao 100-taxaMutacao], 1);
    [nFilhos nJ] = size(filhos);
    filhos = dec2bin(filhos,tamCromossomo);
    
    % Aplicar a mutacao?
    if mut(1,1) == 1       
        % Escolher um filho para ser mutado
        mutante = floor(nFilhos * rand(1,1))+1;
        nBit = floor(tamCromossomo * rand(1,1))+1;
        bitAtual = filhos(mutante, nBit);
        
        % Fazer a mutacao em apenas um bit
        if bitAtual == dec2bin(1)
            bitMutante = dec2bin(0);
        else
            bitMutante = dec2bin(1);
        end
        
        % Alterando um bit no filho escolhido
        filhos(mutante, nBit) = bitMutante;
    end
    
    % Transformar de binario para decimal
    filhos = bin2dec(filhos);
    
    % Retorno da funcao
    result =filhos;

end