%%
% Integrate and fire Neuron model
% Author: Lianne Meah
%% CLEANUP
clc
clear all
%% PARAMETER SETUP
dt = 1;
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
Vmat = zeros(1, round(t/dt));
% refactory period
ref = 0;
%% MODEL
Vmat(1,1) = Vrest;
for step = 2:1:T
	Vmat(1, step)= Vmat(1, step-1)+1;
	if Vmat(1, step) > theta
		Vmat(1, step) = Vrest; % DECAY EXPONENTIALLY
	end
end
time = 0:dt:T-dt;
%% PLOTTING
 figure(1);
 plot(time,Vmat)
 xlabel('Time (ms)');
 ylabel('Membrane potential (mV)');