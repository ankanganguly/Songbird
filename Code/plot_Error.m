%% This file plots Error related graphes.


load('Errfunct.mat')
rin=Error(:,1);
eta=Error(:,2);
epl=Error(:,3);
E=Error(:,4);


figure()
scatter(rin,E)
label = strcat(' (',num2str(eta),', ',num2str(epl),')');
text(rin,E,label,'HorizontalAlignment','left')
xlabel('r_{in}')
ylabel('Error')
title('All runs')
xlim([2000 14000])
legend('(\eta, \epsilon)','Location','southeast')


prod=Error(:,2).*Error(:,3);
c_prod = 0.1450;                        % the constant product
indx = find(prod==c_prod);
figure()
scatter(rin(indx),E(indx))
label = strcat(' (',num2str(eta(indx)),', ',num2str(epl(indx)),')');
text(rin(indx),E(indx),label,'HorizontalAlignment','left')
title('Selected Runs; Constant=(\epsilon*\eta')
xlabel('r_{in}')
ylabel('Error')
xlim([2000 14000])
legend('(\eta, \epsilon)','Location','southeast')

% 
% % ONLY CARE ABOUT eta=2 or 0.2 and epsilon=0.0725
% figure()
% eta_b = 2;
% indx = find(eta==eta_b & epl==0.0725);
% scatter(epl(indx),E(indx))
% label = strcat('  \leftarrow (',num2str(rin(indx)),', ',num2str(eta(indx)),')');
% text(epl(indx),E(indx),label,'HorizontalAlignment','left')
% 
% eta_b = 0.2;
% indx = find(eta==eta_b & epl==0.0725);
% hold on
% scatter(epl(indx),E(indx),'d')
% label = strcat(' (',num2str(rin(indx)),', ',num2str(eta(indx)),') \rightarrow ');
% text(epl(indx),E(indx),label,'HorizontalAlignment','right')
% 
% xlabel('\epsilon')
% ylabel('Error')
% %legend('(r_{in}, \eta)','Location','northeast')
% title('\eta=0.2   or   \eta=2   and   \epsilon=0.0725')









