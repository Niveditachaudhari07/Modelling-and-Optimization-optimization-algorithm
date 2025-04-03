clc; clear;
rng(1); 

functions = {@F1_sphere, @F6_rosenbrock, @F14_expanded_scaffer};
function_names = {'F1', 'F6', 'F14'};
dimensions = [2, 10];
nRuns = 15;

options = optimoptions('particleswarm', ...
    'Display','off', ...
    'SwarmSize', 30, ...
    'MaxIterations', 100);

for fIdx = 1:length(functions)
    fun = functions{fIdx};
    fname = function_names{fIdx};

    for dIdx = 1:length(dimensions)
        D = dimensions(dIdx);
        lb = -100 * ones(1, D);
        ub = 100 * ones(1, D);
        fitness_vals = zeros(nRuns, 1);

        fprintf('\n--- Running PSO on %s | D = %d ---\n', fname, D);

        for run = 1:nRuns
            [~, fval] = particleswarm(fun, D, lb, ub, options);
            fitness_vals(run) = fval;
            fprintf('Run %d: %.4f\n', run, fval);
        end

        mean_val = mean(fitness_vals);
        std_val = std(fitness_vals);
        best_val = min(fitness_vals);
        worst_val = max(fitness_vals);

        fprintf('Results for %s, D = %d:\n', fname, D);
        fprintf('Mean: %.4f | Std: %.4f | Best: %.4f | Worst: %.4f\n', ...
            mean_val, std_val, best_val, worst_val);

        save(sprintf('PSO_%s_D%d_results.mat', fname, D), ...
            'fitness_vals', 'mean_val', 'std_val', 'best_val', 'worst_val');
    end
end
