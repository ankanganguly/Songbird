%% This file runs the integrate-and-burst model, and then save everything.

function IFmodel(rin, rin_min, eta, epsilon)
    %Load inputs
    IFinputs;

    %Derived constants
    FireSet = floor(Tburst/(3*dt));                                     %Interval during burst when we fire
    time_bursting = Tburst/dt;                                          %Time step duration burst    

    %Recording
    Vt = zeros(steps,N);
    burstst = zeros(steps,N);

    rng('default');                                                     %seeding the random number generator
    rng(1);
    %Run for each time step
    for t = 1:steps
        %Update potentiation
        b = rand(N,1) <= rin*dt;                                        %External input, 
        gE = W*s + W0*b;                                                %Set up gE
        gIglob = (Ag/N)*sum(s);                 
        gIada = Aa*s_ada;
        gI = gIglob + gIada;                                            %Set up gI
        V = V-1/Cm*(gL*(V - VL) + gE.*(V - VE) + gI.*(V - VI))*dt;      %Update Potential

        %Update firing list and set reset potentials
        bursts(bursts > 0) = bursts(bursts > 0) + 1;                    %increment bursts
        bursts(and(bursts == 0, V >= Vtheta)) = 1;
        V(bursts > 0) = Vtheta + 0.03;                                  %Fix all bursting potentials
        for j = 0:3                                                     %Record firing uniformly over the burst
            x(t, bursts == j*FireSet + 1) = 1;
        end
        V(bursts > time_bursting) = Vreset;                             %Reset V and bursts when burst period finishes
        bursts(bursts > time_bursting) = 0;

        burstst(t,:) = bursts;                                          %Record bursts

        Vt(t,:) = V';                                                   %Record Potential

        %Update activation
        s = (1 - dt/tau_s)*s;                                           %s decrements exponentially
        s_ada = (1 - dt/tau_ada)*s;
        s(x(t,:) == 1) = s(x(t,:) == 1) + 1;                            %si increments everytime neuron i fires
        s_ada(x(t,:) == 1) = s_ada(x(t,:) == 1) + 1;

        %Learning
        unnormalized_Delta = x(t,:)'*x(t,:)*K(1);
        for j = 0 : min(t-1,lv)
            unnormalized_Delta = unnormalized_Delta + K(j+1)*(x(t,:)'*x(t - j,:) - x(t - j,:)'*x(t,:));
        end
        Delta_STDP = (W/wmax + 0.001).*unnormalized_Delta;              %Calculate Delta_STDP
        %Thetacol = max(0,sum(W + eta*Delta_STDP,2) - wmax*m);               %Incoming
        %Thetarow = max(0,sum(W + eta*Delta_STDP,1) - wmax*m);               %Outgoing
        Thetacol = max(0,sum(W + Delta_STDP,2) - wmax*m);               %Incoming
        Thetarow = max(0,sum(W + Delta_STDP,1) - wmax*m);               %Outgoing
        hLTP = repmat(Thetacol, 1,N) + repmat(Thetarow, N,1);           %Compute unnormalized hLTP
        W = max(0, W + eta*Delta_STDP - epsilon*eta*hLTP);               %Calculate new Weights
        W(W>wmax) = wmax;                                               %hard-limit

        if mod(t,1000) == 0
            t
        end

        if (rin>rin_min)
            rin=rin-1;
        end
    end


    figure()
    imagesc(logical(burstst'))
    Title=strcat('rin=',num2str(rin),' eta=',num2str(eta),' epsilon=',num2str(epsilon));
    title(strcat('Bursts, ',Title))
    figure()
    imagesc(W)
    colorbar
    title(strcat('Weights, ',Title))
    figure()
    imagesc(W*W')
    colorbar
    title(strcat('Weight*Weight, ',Title))


    filename=strcat('rin_',num2str(rin),' eta_',num2str(eta),' epsilon_',num2str(epsilon),'.mat');
    save(filename)
    %save(filename,'rin','eta','epsilon','burstst','W','x','Vt')
end