
clc; clear;
rng(1); 

functions = {@F1_sphere, @F6_rosenbrock, @F14_expanded_scaffer};
function_names = {'F1', 'F6', 'F14'};

% Dimensions 
dimensions = [2, 10];

% Number of runs 
nRuns = 15;

% Tuning for SA
options = optimoptions('simulannealbnd', ...
    'Display','off', ...
    'MaxIterations', 5000, ...
    'InitialTemperature', 500, ...
    'TemperatureFcn', @temperatureexp, ...
    'AnnealingFcn', @annealingfast, ...
    'ReannealInterval', 50, ...
    'TolFun', 1e-8);

% Loop through each function
for fIdx = 1:length(functions)
    fun = functions{fIdx};
    fname = function_names{fIdx};

    % Loop through each dimension
    for dIdx = 1:length(dimensions)
        D = dimensions(dIdx);
        lb = -100 * ones(1, D);
        ub = 100 * ones(1, D);
        fitness_vals = zeros(nRuns, 1);

        fprintf('\n  Running SA on %s | D = %d -\n', fname, D);

        % Perform 15 runs
        for run = 1:nRuns
            x0 = lb + rand(1, D) .* (ub - lb);  % Random initial point
            [~, fval] = simulannealbnd(fun, x0, lb, ub, options);
            fitness_vals(run) = fval;
            fprintf('Run %d: %.4f\n', run, fval);
        end

        % Summary stats
        mean_val = mean(fitness_vals);
        std_val = std(fitness_vals);
        best_val = min(fitness_vals);
        worst_val = max(fitness_vals);

        fprintf('Results for %s, D = %d:\n', fname, D);
        fprintf('Mean: %.4f | Std: %.4f | Best: %.4f | Worst: %.4f\n', ...
            mean_val, std_val, best_val, worst_val);

        % Save results
        filename = sprintf('SA_%s_D%d_results.mat', fname, D);
        save(filename, 'fitness_vals', 'mean_val', 'std_val', 'best_val', 'worst_val');
    end
end
