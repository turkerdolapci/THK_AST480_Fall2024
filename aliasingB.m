% Aliasing - Script B
%
% Turker Dolapci
% 2024.09.15
%

clear all 	% clears everything in workspace
close all	% closes if there is something (e.g. figures)
clc 		% clears command window

%% Input section
fc= 10; %frequency of the tone to be generated
T=1/fc; %period of the tone to be generated
tdur= 6*T; % time length of the tone to be generated in seconds

fs_high=20*fc; %very fine smpling rate that can represent the signal correctly
fs_nyquist=2*fc; %critical sampling rate, edge of aliasing
fs_low= fs_nyquist*0.6; %slower than the nyquist rate, aliasing will occur

%% Plot a tone with different sampling rates 

t_fine= (0:(1/fs_high):tdur).'; 	%time vector for different sampling rates
t_critical= (0:(1/fs_nyquist):tdur).'; 
t_coarse= (0:(1/fs_low):tdur).'; 

sig_fine= cos(2*pi*fc*t_fine); %generating the tone with same frequency with different sampling rates
sig_critical= cos(2*pi*fc*t_critical);
sig_coarse= cos(2*pi*fc*t_coarse);

figure;
plot(t_fine, sig_fine)
hold on
plot(t_critical, sig_critical,'-*')
plot(t_coarse, sig_coarse,'-*')
legend('Fine Sampling','Critical (Nyquist) Sampling','Coarse Sampling')
ylabel('Amplitude')
xlabel('Time (s)')
grid on
xlim([0 tdur])
ylim([-1 1])