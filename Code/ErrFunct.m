%% This file calculates the Error Function, and then saves the Error.

Id_approx = W*W';
Errfunct = sum(sum(Id_approx(logical(ones(N) - eye(N))))) + N*wmax^2-sum(sum(Id_approx(logical(eye(N)))));


% Concatenate if the file already exists.
if exist('Errfunct.mat', 'file')
    load('Errfunct.mat')
    Error = cat(1, Error, [rin, eta, epsilon, Errfunct]);
    Error = unique(Error,'rows');
    save('Errfunct.mat', 'Error');
else
    Error = [rin, eta, epsilon, Errfunct];
    save('Errfunct.mat', 'Error');
end

