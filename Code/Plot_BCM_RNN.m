%% plot the results from file BCM_RNN()



load('BCM_RNN.mat')
jump = 1;


%% weight
% figure();
% hold on
% for t=1:jump:steps
%     Wcur(:,:) = Ws(t,:,1,:);
%     
%     subplot(2,1,1)
%     imagesc(Wcur);
%     title(sprintf('Weight; t=%d',t));
%     colorbar;
%     
%     subplot(2,1,2)
%     imagesc(Wcur*Wcur');
%     title(sprintf('Weight*Weight; t=%d',t))
%     colorbar;
%     drawnow;
%     
% end
% hold off
%save(h(1),'Weight.fig')


%% BCM neurons output
figure();
hold on
for t=1:jump:steps
    outcur(:) = outs(t,:);
    plot(outcur,'*');
    title(sprintf('BCM neurons Output; t=%d',t))
    pause(0.1);
    drawnow
end
hold off
% save(h(2), 'Output.fig')


%% Sliding
figure();
hold on
for t=1:jump:steps
    thetacur(:) = thetas(t,:);
    outcur(:) = outs(t,:);
    
    x = outcur;
    y = x.*(x - thetacur);
    plot(x,y);                  % Phi = output*(output-theta)
    
    y = linspace(1,10,N);
    x = outcur;
    plot(x,y,'*');              % BCM neurons outputs.
    
    x = thetas(t)*ones(1,100);
    plot(x,0,'bo');              % threshold.
    pause(0.1);
    
end
hold off
% save(h(3), 'Sliding.fig')
