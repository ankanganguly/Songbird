%% This files plots Error function over time.


% load('ErrorFunctOverTime_6000Hz_normal.mat')
% 
% ErrHistory = zeros(size(Ws,1),1);
% Time = zeros(size(Ws,1),1);
% for ii=1:size(Ws,1);
%     W(:,:) = Ws(ii,:,:);
%     Id_approx = W*W';
%     ErrHistory(ii) = sum(sum(Id_approx(logical(ones(N) - eye(N))))) + N*wmax^2-sum(sum(Id_approx(logical(eye(N)))));
%     Time(ii) = ii*dt;
% end
% 
% figure()
% plot(Time,ErrHistory)
% xlabel('Time (s)')
% ylabel('Error')
% title('Error vs. Time; 6000Hz, normal') 




% load('ErrorFunctOverTime_6000Hz_Perm.mat')
% 
% ErrHistory = zeros(size(Ws,1),1);
% Time = zeros(size(Ws,1),1);
% for ii=1:size(Ws,1);
%     W(:,:) = Ws(ii,:,:);
%     Id_approx = W*W';
%     ErrHistory(ii) = sum(sum(Id_approx(logical(ones(N) - eye(N))))) + N*wmax^2-sum(sum(Id_approx(logical(eye(N)))));
%     Time(ii) = ii*dt;
% end
% 
% figure()
% plot(Time,ErrHistory)
% xlabel('Time (s)')
% ylabel('Error')
% title('Error vs. Time; 6000Hz, Permutation') 





load('rin_6000 eta_0.2 epsilon_0.0725 wmax_0.14 Hebbian.mat')

ErrHistory = zeros(size(Ws,1),1);
Time = zeros(size(Ws,1),1);
for ii=1:size(Ws,1);
    W(:,:) = Ws(ii,:,:);
    Id_approx = W*W';
    ErrHistory(ii) = sum(sum(Id_approx(logical(ones(N) - eye(N))))) + N*wmax^2-sum(sum(Id_approx(logical(eye(N)))));
    Time(ii) = ii*dt;
end

figure()
plot(Time,ErrHistory)
xlabel('Time (s)')
ylabel('Error')
title('Error vs. Time; 6000Hz, Hebbian') 

