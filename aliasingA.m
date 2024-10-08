% Aliasing - Script A
%
% Turker Dolapci
% 2024.08.12
%

clear all 	% clears everything in workspace
close all	% closes if there is something (e.g. figures)
clc 		% clears command window

%% Input section
fs= 100; %sampling rate equals to the number of samples per second (samples per second)
fc= 20; %frequency of the genearted sinusoidal
T=1/fc; %period of the genearted sinusoidal
tdur= 6*T; % time length of the signal to be generated in seconds

%% Generate sinusoidals with different frequencies with constant sampling rate.
t= (0:(1/fs):tdur).'; 	%time vector

freqs=0:1:100; %frequencies of the sinusoiadls being generated

figure;
for n=1:length(freqs)
plot(t,sin(2*pi*freqs(n)*t),'-*')
title({'Sinusoidal Signal',strcat('f= ',num2str(freqs(n)),' Hz'),strcat('fs= ',num2str(fs),' sps')})
ylabel('Amplitude')
xlabel('Time (s)')
grid on
xlim([0 tdur])
ylim([-1 1])
drawnow
pause(0.4)
end

pause();

figure;
plot(t,sin(2*pi*freqs(6)*t),'-*')
hold on
plot(t,sin(2*pi*freqs(96)*t),'-*')
legend(strcat('Sinusoidal Frequency=',num2str(freqs(6)),'Hz'), strcat('Sinusoidal Frequency=',num2str(freqs(96)),'Hz'))
title(strcat('Generating Two Sinusoidals by fs=',num2str(fs),'Hz'))
ylabel('Amplitude')
xlabel('Time (s)')
grid on
xlim([0 tdur])
ylim([-1 1])