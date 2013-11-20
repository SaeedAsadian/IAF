%%
% Leaky Integrate and fire Neuron model
% Author: Lianne Meah
%
%% CLEANUP
clear all
clc
%% PARAMETER SETUP
tau = 10e-3; % membrane time constant
Rm = 3e7;
dt = 0.001; % time step
T = 0.5; %time of simulation
totalSteps = round(T/dt);
time = 0:dt:T;
Vrest = -7e-3;
theta = -5e-3;
Vmat = zeros(1, totalSteps+1);
%% MODEL
Vmat(1,1) = Vrest;
for step = 2:1:T
    dV = (-1./tau).*Vmat(1, step).*dt;
    %Vmat(1, step+1) = Vmat(1, step) + dV;
    Vmat(1, step)= Vmat(1, step-1)+dV;
    %if Vmat(1, step) > theta
     %   Vmat(1, step) = Vrest;
    %end
end
%% PLOTTING
clf;
figure(1);
plot(time,Vmat);
xlabel('Time (ms)');
ylabel('Membrane potential (mV)');