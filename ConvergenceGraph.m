% Convergence Graph - Genetic Algorithm (GA) Optimality
numGen = 50;        % total generations
popSize = 20;       % population size
numGenes = 5;       % number of genes (policy attributes)

% Fitness function: maximize sum of genes (security+precision proxy)
fitnessFunction = @(x) (sum(x)/numGenes) + rand()*0.02;

% Initialize population (binary chromosomes)
population = randi([0,1], popSize, numGenes);
bestFitness = zeros(1, numGen);

for gen = 1:numGen
    % Evaluate fitness
    fitness = zeros(1, popSize);
    for i = 1:popSize
        fitness(i) = fitnessFunction(population(i,:));
    end
    
    % Track best fitness
    bestFitness(gen) = max(fitness);
    
    % Selection (top half)
    [~, idx] = sort(fitness, 'descend');
    parents = population(idx(1:floor(popSize/2)), :);
    
    % Crossover
    offspring = parents;
    for i = 1:2:size(parents,1)-1
        point = randi([1 numGenes-1]);
        offspring(i,point:end)   = parents(i+1,point:end);
        offspring(i+1,point:end) = parents(i,point:end);
    end
    
    % Mutation
    for i = 1:size(offspring,1)
        if rand < 0.1
            pos = randi(numGenes);
            offspring(i,pos) = ~offspring(i,pos);
        end
    end
    
    % Update population
    population = [parents; offspring];
end

% Plot Convergence
figure;
plot(1:numGen, bestFitness, 'b-o','LineWidth',2,'MarkerSize',5);
xlabel('Generations');
ylabel('Best Fitness Value');
title('GA Convergence Curve - Proof of Optimality');
grid on;
