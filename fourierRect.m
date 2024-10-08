% Rectangular Signal - Fourier Series Representation
% Turker Dolapci
% 2024.07.28

clear all 	% clears everything in workspace
close all	% closes if there is something (e.g. figures)
clc 		% clears command window

%% Sampling rate, signal length, and time vector
fs= 1e3; %sampling rate equals to the number of samples per second (samples per second)
numsamp=5000; %number of samples to be generated
t= (0:(1/fs):((numsamp-1)/fs)).'; 	%time vector
%it is advised for you to create column vectors, rather than row vectors
%because it is the convention, obey the conventions!! 

%% Signal frequency
fc= 50;%fundamental frequency of the periodic signal to be generated	
T=1/fc;%period of the sinal to be generated

%% Generate a rectangular signal
rectpulse=[0;ones(round(T*fs)/2-1,1);0;-ones(round(T*fs)/2-1,1)]; %single period rectangular signal

figure;
plot(0:(1/fs):((length(rectpulse)-1)/fs),rectpulse)
grid on
title('Rectangular Signal, Single Period')
xlabel('Time (sec)')
ylabel('Amplitude')
xlim([-0.1 0.1])
pause

rectsig=repmat(rectpulse,round(length(t)/length(rectpulse)),1); %repeating the single period to have a longer signal

figure;
plot(0:(1/fs):((length(rectsig)-1)/fs),rectsig)
grid on
title('Rectangular Signal, Multiple Periods')
xlabel('Time (sec)')
ylabel('Amplitude')
xlim([0 0.1])
pause

%% Attempt to generate the same rectangular signal by Fourier series, up to 9th harmonics
sinsig1= (4/pi)*(1)*sin(2*pi*fc*t); %sinusoidal signal with fundamental	frequency
sinsig3= (4/pi)*(1/3)*sin(2*pi*3*fc*t); %sinusoidal signal with 3rd harmonic frequency	
sinsig5= (4/pi)*(1/5)*sin(2*pi*5*fc*t); %sinusoidal signal with 5th harmonic frequency		
sinsig7= (4/pi)*(1/7)*sin(2*pi*7*fc*t); %sinusoidal signal with 7th harmonic frequency		
sinsig9= (4/pi)*(1/9)*sin(2*pi*9*fc*t); %sinusoidal signal with 9th harmonic frequency		
sumsinsig=sinsig1+sinsig3+sinsig5+sinsig7+sinsig9; %sum of the fundamental and odd harmonics till 9th

hold on;
plot(0:(1/fs):((length(sumsinsig)-1)/fs),sumsinsig)
title('Rectangular Signal')
legend('Orig. Rect.', 'Fourier Odd Harmonics, Till 9th')
xlim([0 0.1])
pause
%% Attempt to generate the same rectangular signal by Fourier series, up to 99th harmonics
infsumsinsig=0;
for n=1:2:99 %(all harmonics sawtooth)
    infsumsinsig=infsumsinsig+4/pi*(1/n)*sin(2*pi*n*fc*t);
end

plot(0:(1/fs):((length(infsumsinsig)-1)/fs),infsumsinsig)
title('Rectanular Signal')
legend('Orig. Rect.', 'Fourier Odd Harmonics, Till 9th', 'Fourier Odd Harmonics, Till 99th')
xlim([0 0.1])
