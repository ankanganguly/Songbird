%% The 2nd-Order BCM RNN with Lateral Inhibition
% Finite-State Reber Automaton and the Recurrent Neural Networks Trained in
% Supervised and Unsupervised Manner 
%   Michal Cernansky and Lubica Benuskova

function BCM_RNN()

Sigmoid = @(v) 1/(1+exp(-0.4* v));
d_Sigmoid = @(v) 0.4*exp(-0.4*v)/(exp(-0.4*v)+1)^2;  %derivative


%Sigmoid = @(v) 1/(1+exp(-v));
%d_Sigmoid = @(v) exp(v)/(exp(v)+1)^2;

% For each output neuron, there are (N-1) input neurons.
% input are composed of two components:
% 1. other BCM neurons, for lateral inhibition.
% 2. constant external signal
N = 8;          % N BCM neurons.
N_in = 1;        % N_in external inputs.
steps = 1000;
dt = 0.01;


% first index is time. t
% second index is BCM neuron. i
% third index is external input. j
% fourth index is the other BCM neuron. k
Ws=zeros(steps+1,N,N_in,N);         % weights, record
W=ones(N,N_in,N);                   % weight, initial, 3D matrix 
Ws(1,:,:,:) = W;                          
outs = zeros(steps+1,N);            % outputs, record, which are BCM neurons. 
out = rand(N,1);                    % outputs, initial
outs(1,:) = out;                    
ins = zeros(steps+1,N_in);          % inputs, record
in = 1.0;                           % inputs, initial
ins(1,:) = in;
thetas = zeros(steps+1,N);          % threshold, record
theta = out.*out;                   % threshold, initial, but will be overwritten by update_theta() when t=1;
thetas(1,:) = theta;
phi = zeros(N,1);               


mu = 1/N;                           % inhibition strength
eta = 0.1;
tau = steps;
X = zeros(N,1);                     % argument of Sigmoid function

for t = 1:(steps+1)
    update_output();
    update_theta();
    update_phi();
    update_weight();
end



save('BCM_RNN.mat')


%% 
% -------------------------------------------------------------------------
    function  update_output()
        X = zeros(N,1);
        for i=1:N
            for j=1:N_in
                for k=1:N
                    
                    li=0;
                    for beta=1:N
                        if beta~=i
                            li = li + W(beta,j,k);
                        end
                    end
                    X(i) = X(i) + (W(i,j,k) - mu * li) * in(j) * out(k);

                end
            end
        end
        outs(t+1,:) = Sigmoid(X);               
        out(:) = outs(t+1,:);
    end

% -------------------------------------------------------------------------
    function update_theta()

        tprime = 1:(t+1);
        
        % trapezoidal rule
        temp_sum = zeros(1,N);
        for k=1:((t+1)-1)
                temp_sum = temp_sum + outs(tprime(k+1),:).^2 * exp(-(t-tprime(k+1))/tau) + outs(tprime(k),:).^2 * exp(-(t-tprime(k))/tau);        
        end
        
        theta = 1/2 * temp_sum /tau;
        thetas(t+1,:) = theta;
    end

% -------------------------------------------------------------------------
    function update_phi()
        phi = times(out, (out-theta'));
    end

% -------------------------------------------------------------------------
    function update_weight()
        dW = zeros(N,N_in,N);
        
        for i=1:N
            for j=1:N_in
                for k=1:N
                    for alpha=1:N
                       
                        if alpha==i
                            dW(i,j,k) = dW(i,j,k) + d_Sigmoid(X(i))*phi(i)*in(j)*out(k);
                        else
                            dW(i,j,k) = dW(i,j,k) - d_Sigmoid(X(i))*phi(i)*mu*in(j)*out(k); 
                        end
                        
                    end
                end
            end
        end
        
        W(:,:,:) = W(:,:,:) + dW(:,:,:) * eta * dt;
        Ws(t+1,:,:,:) = W(:,:,:);
    end

end
