% LIF MATLAB model - based on code
% and lecture slides of Prof. Kevin Gurney

%% CLEANUP
clear all
clc
clf

%% PARAMETER SETUP
% membrane constants
tau = 0.020;
R = 3e7;
% resting potential
E = -0.070;
% threshold for a spike
theta = -0.035;
% change in time - window
dt = 0.0001;
% total milliseconds to run for
T = 0.16;
% total number of steps
no_steps = round(T ./ dt);
% time - for plotting
time = linspace(0, T, no_steps + 1);
% external events array
psc = [];
% set up PSC events - external current give rise to inc v.  
psc(1) = 0.05;
psc(2) = 0.07;
%psc(3) = 0.09;
% number of external events
no_pcs = length(psc);
tau_s = 0.003;
Q = 40e-12;
I_0 = Q ./ tau_s;
% index for each ext. event? IE psc(1)/dt, psc(2)/dt...
index_pscs = round(psc ./ dt);

% voltage matrix
V = zeros(1, no_steps + 1);
% initial voltage of membrane - put at rest
V(1) = -0.07;
% current
I = zeros(1, no_steps + 1);
% initial current
I(1) = 0;
% noise - sampling from norm/Gaussian dist, 1*no_steps matrix
% random(A,B,C,[D,E])- what does B do!?
randI = 3e-9 .* random('Normal', 0, 1.5, [1, no_steps]);
% time since last spike
t_spike = 0;
% absolute refactory period
arp = 0.02; %this being 0.02 doesn't work.
% total number of spikes
no_spikes = 0;

%% SIMULATION
for i=1:no_steps
    for k=1:no_pcs;
        % if step sits on an external event step...
        if i == index_pscs(k)
            % increase the current
            I(i) = I(i) + I_0;
        end
    end
    I(i+1) = I(i)-(dt/tau_s).*I(i);
    
    dV =(dt/tau).*(E-V(i)+I(i).*R + randI(i).*R);
    % update without noise
    % dV =(dt/tau).*(E-V(i)+I(i).*R);
    V(i+1) = V(i) + dV;
    % spike
    if (V(i+1) > theta) 
        if no_spikes>0
            % check we're not in absolute refac period
            if (time(i)>=(t_spike+arp))
                % reset voltage
                V(i+1) = E;
                % Eleni's trick of making spikes look nice
                V(i) = -0;
                % record spike
                t_spike = time(i);
                % increment spike count
                no_spikes = no_spikes+1;
            end
        else
            % no spikes yet - no need to check
            V(i+1) = E;
            % Eleni's trick of making spikes look nice
            V(i) = -0;
            % record spike
            t_spike = time(i);
            % increment spike count
            no_spikes = no_spikes+1;
        end
    end
end
%% PLOTTING
figure(1)
plot(time, V, 'color', 'black');
hold on
plot(time, theta, '--r');
title(sprintf('LIF with noise; theta is %.3fV, refactory is %.2fs',theta, arp));
xlabel('time (s)')
ylabel('voltage (V)')
grid on