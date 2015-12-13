% Plot the Error Over Entire course of simulation
% need to specify the File as a string;


% Normal run - with annealing, start off with random weight matrix
load(' ')
ErrorOTNormal=zeros(size(Ws,1),1);

for i=1:size(Ws,1)
    W(:,:) = Ws(i,:,:);
    Id_approx = W*W';
    Err = sum(sum(Id_approx(logical(ones(N) - eye(N))))) + N*wmax^2-sum(sum(Id_approx(logical(eye(N)))));
    ErrorOTNormal(i) = Err;
end


% With Annealing, start off with Permutation matrix
load(' ')
ErrorOTPermAnneal=zeros(size(Ws,1),1);

for i=1:size(Ws,1)
    W(:,:) = Ws(i,:,:);
    Id_approx = W*W';
    Err = sum(sum(Id_approx(logical(ones(N) - eye(N))))) + N*wmax^2-sum(sum(Id_approx(logical(eye(N)))));
    ErrorOTPermAnneal(i) = Err;
end


% NO Annealing, start off with Permutation matrix
load(' ')
ErrorOTPermNoAnneal=zeros(size(Ws,1),1);

for i=1:size(Ws,1)
    W(:,:) = Ws(i,:,:);
    Id_approx = W*W';
    Err = sum(sum(Id_approx(logical(ones(N) - eye(N))))) + N*wmax^2-sum(sum(Id_approx(logical(eye(N)))));
    ErrorOTPermNoAnneal(i) = Err;
end



% plot stuff here.