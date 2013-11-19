%%
% Integrate and fire Neuron model
% Author: Lianne Meah
%% CLEANUP
clc
clear all
%% PARAMETER SETUP
dt = 0.1;
t = 100;
% membrane time constant
tau = 10; %e-3
% the spike threshold
theta = -55; %e-3
Vrest = -70; %e-3
Vreset = -80; %e-3
%  time window
T = round(t/dt);
% voltage matrix
V = zeros(1, round(t/dt));
% refactory period
%% MODEL
time = 1:dt:T-dt;
V(1,1) = Vrest;
% steps must be an integer...
for step = 2:1:T
	V(1, step)= V(1, step-1)+50;
	V(1, step) = 0;
	if V(1, step) > theta
		V(1, step) = Vrest; % DECAY EXPONENTIALLY
	end
end

%% PLOTTING
 figure(1);
 plot(time,V)
 xlabel('Time (ms)');
 ylabel('Membrane potential (mV)');