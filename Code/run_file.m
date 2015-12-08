eta_array=[0.002, 0.02, 0.2, 2];
epsilon_array=[72.5, 7.25, 0.725, 0.0725];
for iii=1:4
    eta=eta_array(iii);
    epsilon=epsilon_array(iii);
    rin=10000;
    rin_min=6000;
    IFmodel(rin, rin_min, eta, epsilon);
end


eta_array=[0.2, 0.2, 0.2, 0.2, 0.2];
epsilon_array=[72.5, 7.25, 0.725, 0.0725, 0.00725];
for iii=1:length(eta_array)
    eta=eta_array(iii);
    epsilon=epsilon_array(iii);
    rin=10000;
    rin_min=6000;
    IFmodel(rin, rin_min, eta, epsilon);
end


rin_min_array=2000:2000:10000;
eta_array=[0.02, 0.2, 2];
epsilon_array=[0.725, 0.0725, 0.00725];
for iii=1:length(eta_array)
    for jjj=1:length(epsilon_array)
        for kkk=1:length(rin_min_array)
            eta=eta_array(iii);
            epsilon=epsilon_array(jjj);
            rin=10000;
            rin_min=rin_min_array(kkk);
            IFmodel(rin, rin_min, eta, epsilon);
        end
    end
end
