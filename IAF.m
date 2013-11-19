%%
% Integrate and fire model 
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
theta = -55; %e-3
Vrest = -70; %e-3
Vreset = -80; %e-3
%  time window
T = round(t/dt);
% voltage matrix
V = zeros(1, round(t/dt));
% refactory period
ref;

%% MODEL
V(1,1) = Vrest;

%% PLOTTING
% figure(1);