%% Convergence 
% The convergence metric is basically (# of spikes)/(400 timesteps)
load('files_names.mat')


% figure()
% hold on
% bin = 4000;              % dt=2e-5
% for file = 1:length(files_names)
%     filename = files_names{file};
%     load(filename);
%     
%     %if rin==2000
%     if true
%         rate = [];
%         tick = [];
%         for i = 1:bin:(size(burstst,1)-bin)
%             temp = sum(sum(x(i:i+bin,:)))/N/4/bin;     % x represents a burst which has 4 spikes.
%             rate = [rate; temp];
%             tick = [tick; mean([i,i+bin])];
%         end
%         
%         plot(tick*dt,rate/dt)
%     end
% end
% xlabel('Time (s)')
% ylabel('Rate (burst/s)')
% title(sprintf('Convergence; Bin=%d',bin))





figure()
hold on
xlim([0.2 2.0])
Leg=cell(1,1); counter=0;
for file = 1:length(files_names)
    filename = files_names{file};
    load(filename);
    
    if (eta==0.2 | eta==2) & epsilon==0.0725 & rin~=2000 & rin~=10000
        rate = [];
        tick = [];
        for i = 1:bin:(size(burstst,1)-bin)
            temp = sum(sum(x(i:i+bin,:)))/N/4/bin;
            rate = [rate; temp];
            tick = [tick; mean([i,i+bin])];
        end
        indx=find((tick*dt)>0.2);
        plot( tick(indx) * dt , rate(indx) / dt)
        counter=counter+1;
        Leg{counter} = strcat('r_{in}=',num2str(rin),' \eta=',num2str(eta),' \epsilon=',num2str(epsilon));
    end
end

xlabel('Time (s)')
ylabel('Rate (burst/s)')
title(sprintf('Convergence; Bin=%d',bin))
legend(Leg)
