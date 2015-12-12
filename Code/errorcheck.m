function error = errorcheck(N,W, wmax)
    Id_approx = W*W';
    error = sum(sum(Id_approx(logical(ones(N) - eye(N))))) + sum(sum(abs(wmax - Id_approx(logical(eye(N))))));
end