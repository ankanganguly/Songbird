%Parameters
N = 10;                             %Number of inputs
inputs = rand(N,1);                 %Inputs, for now assumed constant
W = rand(1,N);                      %Initial weights
theta = 0;                          %Initial threshold
output = W*inputs;                  %Initial output
steps = 1000000;                       %Number of steps
dt = 0.001;                         %Time interval
tau_theta = 0.1;                    %Theta time constant
jump = 1000;                          %Period of display
epsilon = 0.1;                      %Weight decay

%Recording variables
Ws = zeros(steps+1,N);
Ws(1,:) = W;                        %Record Weights
thetas = zeros(steps+1,1);          
thetas(1) = theta;                  %Record Theta
outputs = zeros(steps+1,1);
outputs(1) = output;                %Record Outputs
inputset = zeros(N, steps+1);
inputset(:,1) = inputs;             %Record Inputs


for t = 1:steps
    %Update threshold
    theta = theta + (output^2 - theta)*dt/tau_theta;
    %theta = exp(-(t+1 - (1:t))*dt/tau_theta)*(outputs(1:t).^2)*dt/tau_theta;
    thetas(t + 1) = theta;
    
    %Update weights
    W = max(0, W*(1 - epsilon*dt) + inputs'.*output*(output - theta)*dt);
    Ws(t + 1, :) = W;
    
    %Update output
    output = W*inputs;
    outputs(t + 1) = output;
    
    %Update inputs
    inputs(1) = inputs(1) + (output - theta)*dt;
    inputs(2:end) = inputs(2:end) + (theta - output)*dt;
    inputset(:,t+1) = inputs;
    
    if mod(t,10000) == 0
        t
    end
end

figure
for t = 1:jump: steps + 1
    clf
    hold on
    x = linspace(0, 5);
    y = x.*(x - thetas(t));
    plot(x,y);
    y = linspace(0,3);
    x = outputs(t)*ones(1,100);
    plot(x,y,'r');
    x = thetas(t)*ones(1,100);
    plot(x,y,'b');
    scatter(Ws(t, :), linspace(1,3,N));
    title(strcat('t = ', num2str(t)))
    pause(0.00000001);
end