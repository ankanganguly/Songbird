%Load inputs
IFinputs;

%Derived constants
FireSet = Tburst/3;                                                 %Interval during burst when we fire
time_bursting = Tburst/dt;                                          %Time step duration burst    

%Run for each time step
for t = 1:steps
    %Update potentiation
    b = rand(N,1) <= rin*dt;                                        %External input
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
    
    %Update activation
    s = (1 - dt/tau_s)*s;                                           %s decrements exponentially
    s_ada = (1 - dt/tau_ada)*s;
    s(x(t,:) == 1) = s(x(t,:) == 1) + 1;                            %si increments everytime neuron i fires
    s_ada(x(t,:) == 1) = s_ada(x(t,:) == 1) + 1;
    
    %Learning
    unnormalized_Delta = x(t,:)'*x(t,:)*K(1);
    for j = 0:t-1
        unnormalized_Delta = unnormalized_Delta + K(j+1)*(x(t,:)'*x(t - j,:) - x(t - j,:)'*x(t,:));
    end
    Delta_STDP = (W/wmax + 0.001).*unnormalized_Delta;              %Calculate Delta_STDP
    Thetacol = sum(W + Delta_STDP,2) - wmax*m;                      %Incoming
    Thetarow = sum(W + Delta_STDP,1) - wmax*m;                      %Outgoing
    hLTP = repmat(Thetacol, 1,N) + repmat(Thetarow, N,1);           %Compute unnormalized hLTP
    W = W + eta*Delta_STDP - epsilon*eta*hLTP;                      %Calculate new Weights
    
end
    