% Comparison of Zero Mean and DC Shift Signals
%
% Turker Dolapci
% 2024.11.05
%

clear all 	% clears everything in workspace
close all	% closes if there is something (e.g. figures)
clc 		% clears command window

%% Input section
fs=500e3; %sampling rate of carrier signal
fc=100e3; %frequency of the carrier signal

numsamp=500e3; %number of samples to be generated
fm=1000; %frequency of tone
Am=1.5; %amplitude of tone

%% Message signal
tvec=(0:(1/fs):((numsamp-1)/fs)).'; %time vector to generate sinusoidal signals
mtx=Am*cos(2*pi*fm*tvec); %Tone signal

%% Scale the message signal
a_m=0.6; %modulation index
mtx_n=mtx/max(abs(mtx)); %normalize
mtx_n_a=mtx_n*a_m; %scale

%% Add DC shift
mtx_n_a_dc=mtx_n_a+1; %DC shift

%% Carrier signal
ctx=cos(2*pi*fc*tvec); %carrier signal

%% Time domain plots
figure;
subplot(1,2,1)
plot(tvec,mtx_n_a_dc.*ctx)
hold on
plot(tvec,mtx_n_a_dc,'LineWidth',2)
title('Modulation of a Tone Shifted with a Non-Zero DC Value')
legend('Multiplied by Carrier','DC Shifted Tone')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim([0.01 0.015])

subplot(1,2,2)
plot(tvec,mtx.*ctx)
hold on
plot(tvec,mtx,'LineWidth',2)
title('Modulation of a Zero-Mean Tone')
legend('Multiplied by Carrier','Zero-Mean Tone')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim([0.01 0.015])

%Envelope of the signal is clearly represents the message signaal, if
%message signal is scaled and shiftd before mixing process!