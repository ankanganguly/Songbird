%Constants that do not change during simulation
dt = 0.00002;       %Timesteps in seconds
Cm = 0.01;          %Capacitance constant in F/m^2
VL = -0.06;         %Rest Potential in V
VE = 0;             %Ceiling Potential in V
VI = -0.07;         %Floor Potential in V
gL = 4;             %Leak Conductance in S/m^2
W0 = 5;             %Conductance of external excitatory input in S/m^2
Vtheta = -0.05;     %Activation threshold in V
Vreset = -0.055;    %Reset Potential in V
Tburst = 0.006;     %Burst window in s
tau_s   = 0.004;    %Time constant of synaptic activity in s
%rin    = 10000;         %Mean firing rate of external input in Hz
%rin_min = 6000;

N = 50;             %Number of neurons
wmax = 0.14;        %Individual maximal weight
m = 1;              %Wmax/wmax
%eta = 0.002;        %Learning step size
%eta = 0.2;        %Learning step size
%epsilon = 72.5;     %Strength of the heterosynaptic constraint
%epsilon=0.0725;
Ag = 4;             %Inhibitory global multiplier in S/m^2
Aa = 9;             %Inhibitory adaptation multiplier in S/m^2
tau_STDP = 0.02;    %Time constant of learning in s
tau_ada = 0.015;    %Inhibitary adaptation time constant

%Initial variable values
steps = 20000; 
s = zeros(N,1);             %Activation 
s_ada = zeros(N,1);         %Adaptation activation
K = exp(0:-dt/tau_STDP:-(steps-1)*dt/tau_STDP)';
K(1) = 0;                   %STDP Kernel, K(t) = K(t - 1)
V = ones(N,1)*Vreset;       %Initial potential set to reset potential
bursts = zeros(N,1);        %Bursting neurons and steps into burst

lv = 2000;                  %memory of the system
x = sparse(zeros(steps,N)); %Spike state
%x(1:lv,:) = rand(lv,N) < (4/3750);

%Creating a permutation matrix
%W = eye(N);
%idx = randperm(N);
%W = W(idx,:)*wmax;
%W = ones(N)*wmax/N;               %Initial weights
W = zeros(N);
W(logical(eye(N))) = wmax;         % diagonal matrix
W = circshift(W,1);


% add noise to Weight
noise=wmax/10;
W(7,1)=noise;
W(8,2)=noise;

