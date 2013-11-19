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
tau = 10;
% the spike threshold
theta = -50;
Vrest = -70;
%  time window - max time
T = round(t/dt);
% voltage matrix
Vmat = zeros(1, T);
% refactory period
ref = 0;
%% MODEL
% initially set voltage to rest
Vmat(1,1) = Vrest; 
for step = 2:1:T
	% Vnew = Vold(1-(dt/tau) + sum((Wij)/tau)*xj
	% currently only updating linearly
	Vmat(1, step)= Vmat(1, step-1)+(0.3/tau);
	if Vmat(1, step) > theta
		% voltage reset - needs to decay exponentially
		Vmat(1, step) = Vrest;
		% apparently this makes the spikes look nice
		Vmat(1, step-1) = 1;
	end
end
% keep track of time for plotting
time = 0:dt:(t-dt);
%% PLOTTING
figure(1);
plot(time,Vmat)
xlabel('Time (ms)');
ylabel('Membrane potential (mV)');