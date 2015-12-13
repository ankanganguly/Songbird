%Plot bursts
h(1) = figure;
imagesc([0 dt*], [logical(burstst'));
%title(['Bursts: rin=',num2str(rin), 'eta=', num2str(eta), 'epsilon=', num2str(epsilon)]);
xlabel('Time (s)')
colorbar       

%Plot weights
h(2) = figure;
imagesc(W/wmax);
title(['Weights: rin=',num2str(rin), 'eta=', num2str(eta), 'epsilon=', num2str(epsilon)]);
colorbar

%Plot W*W'
h(3) = figure;
imagesc(W*W'/wmax^2);
title(['W*W: rin=',num2str(rin), 'eta=', num2str(eta), 'epsilon=', num2str(epsilon)]);
colorbar

%Save the figures
savefig(h, ['figs rin_',num2str(rin), 'eta_', num2str(eta), 'epsilon_', num2str(epsilon), '.fig'], 'compact')
close(h)