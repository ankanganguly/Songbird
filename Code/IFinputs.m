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
rin    = 4;         %Mean firing rate of external input in Hz

N = 50;             %Number of neurons
wmax = 0.14;        %Individual maximal weight
m = 1;              %Wmax/wmax
eta = 0.002;        %Learning step size
epsilon = 72.5;     %Strength of the heterosynaptic constraint
Ag = 4;             %Inhibitory global multiplier in S/m^2
Aa = 9;             %Inhibitory adaptation multiplier in S/m^2
tau_STDP = 0.02;    %Time constant of learning in s
tau_ada = 0.015;    %Inhibitary adaptation time constant

%Initial variable values
steps = 200000; 
W = zeros(N);               %Initial weights
s = zeros(N,1);             %Activation
s_ada = zeros(N,1);         %Adaptation activation
x = zeros(steps,N);         %Spike state
K = exp(0:-1/tau_STDP:-(step-1)/tau_STDP)';
K(1) = 0;                   %STDP Kernel, K(t) = K(t - 1)


