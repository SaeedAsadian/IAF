%%
% Leaky integrate and fire model
% Author: Lianne Meah
%% CLEANUP
clc
clear all
%% PARAMETER SETUP
dt = 0.01;
t = 20;
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
% keep track of time for plotting
time = 0:dt:(t-dt);
%% MODEL
% initially set voltage to rest
Vmat(1,1) = Vrest;
% for calculating the new voltage
alpha = dt/tau;
Xj = 0;
% simulation
for step = 2:1:T
	eta = sum((Vrest*Xj)/tau);
	%eta = 0;
	% calculate new voltage
	Vmat(1, step) = (1-alpha).*Vmat(1, step-1) + eta;
	if Vmat(1, step) > theta
		% spike
		Vmat(1, step-1) = 1;
		% voltage reset
		Vmat(1, step) = Vrest;
		Xj = 1;
	else
		% no spike
		Xj = 0;
	end
end
%% PLOTTING
figure(1);
plot(time,Vmat, 'r')
title('Spiking for leaky integrate and fire model');
xlabel('Time (ms)');
ylabel('Membrane potential (mV)');