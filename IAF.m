%%
% Integrate and fire Neuron model
% Author: Lianne Meah
%% CLEANUP
clc
clear all
%% PARAMETER SETUP
dt = 0.01;
t = 100;
% membrane time constant
tau = 10; %e-3
% the spike threshold
theta = -50; %e-3
Vrest = -70; %e-3
%  time window - maxsteps
T = round(t/dt);
% voltage matrix
Vmat = zeros(1, T);
% refactory period
ref = 0;
%% MODEL
Vmat(1,1) = Vrest;
for step = 2:1:T
	Vmat(1, step)= Vmat(1, step-1)+(0.3/tau);
	if Vmat(1, step) > theta
		Vmat(1, step) = Vrest; % DECAY EXPONENTIALLY
		Vmat(1, step-1) = 1;
	end
end
time = 0:dt:(t-dt);
%% PLOTTING
 figure(1);
 plot(time,Vmat)
 xlabel('Time (ms)');
 ylabel('Membrane potential (mV)');