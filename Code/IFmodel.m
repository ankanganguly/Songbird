%Load inputs
IFinputs;

%Derived constants
FireSet = Tburst/3;                                                 %Interval during burst when we fire
time_bursting = Tburst/dt;                                          %Time step duration burst    

%Run for each time step
for i = 1:steps
    %Update potentiation
    b = rand(N,1) <= rin*dt;                                        %External input
    gE = W*s + W0*b;                                                %Set up gE
    gIglob = (Ag/N)*sum(s);                 
    gIada = Aa*s_ada;
    gI = gIglob + gIada;                                            %Set up gI
    V = V-1/Cm*(gL*(V - VL) + gE*(V - VE) + gI*(V - VI))*dt;        %Update Potential
    
    %Update firing list and set reset potentials
    bursts(bursts > 0) = bursts(bursts > 0) + 1;                    %increment bursts
    bursts(and(bursts == 0, V >= Vtheta)) = 1;
    V(bursts > 0) = Vtheta + 0.03;                                  %Fix all bursting potentials
    for j = 0:3                                                     %Record firing uniformly over the burst
        x(i, bursts == j*FireSet + 1) = 1;
    end
    V(bursts > time_bursting) = Vreset;                             %Reset V and bursts when burst period finishes
    bursts(bursts > time_bursting) = 0;
    
    %Update activation
    s(x(i,:) == 1) = s(x(i,:) == 1) + 1;
end
    