%Plot bursts
h(1) = figure;
imagesc([0 dt*steps], [1 N], logical(burstst'));
title(['Bursts: rin=',num2str(rin), ' eta=', num2str(eta), ' epsilon=', num2str(epsilon)]);
xlabel('Time (s)')
ylabel('Neuron ID')
       

%Plot weights
h(2) = figure;
imagesc([1,N], [1 N], W/wmax);       % normalized
title(['Weights: rin=',num2str(rin), ' eta=', num2str(eta), ' epsilon=', num2str(epsilon)]);
xlabel('Neuron ID')
ylabel('Neuron ID')
colorbar

%Plot W*W'
h(3) = figure;
imagesc(W*W'/wmax^2);                       % normalized
title(['W*W: rin=',num2str(rin), ' eta=', num2str(eta), ' epsilon=', num2str(epsilon)]);
xlabel('Neuron ID')
ylabel('Neuron ID')
colorbar

%Save the figures
savefig(h, ['figs rin_',num2str(rin), ' eta_', num2str(eta), ' epsilon_', num2str(epsilon), '.fig'], 'compact')
close(h)