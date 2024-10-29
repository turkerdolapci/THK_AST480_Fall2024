% AM DSB-SC - Simple Script
%
% Turker Dolapci
% 2024.10.29
%

clear all 	% clears everything in workspace
close all	% closes if there is something (e.g. figures)
clc 		% clears command window

%% Input section
fs=500e3; %sampling rate
tdur=1; %duration of the message signal and carrier signal

fm1=2e3; %frequency of the first tone in the message signal
fm2=5e3; %frequency of the second tone in the message signal
ampm1=1; %amplitude of the first tone in the message signal
ampm2=0.6; %amplitude of the second tone in the message signal

fc=100e3; %frequency of the carrier signal

%% Time and frequency vectors
tvec=0:(1/fs):tdur; %time vector to generate sinusoidal signals
fftlen=length(tvec); %number of frequency bins of fft
df=fs/fftlen; %frequency resolution of fft
freqaxis= (((-fs/2):df:((fs/2)-df)) + (mod(fftlen,2)*df)/2).'; %frequency axis of shifted fft plot

%% Generation of the message signal and the carrier signal
mtx=ampm1*cos(2*pi*fm1*tvec)+ampm2*cos(2*pi*fm2*tvec); %message signal
ctx=cos(2*pi*fc*tvec); %carrier signal

fft_mtx=abs(fftshift(fft(mtx,fftlen)))/fftlen; %fft of message signal
fft_ctx=abs(fftshift(fft(ctx,fftlen)))/fftlen; %fft of carrier signal

%% AM DSB-SC Modulation
mctx=mtx.*ctx; %modulated signal
fft_mctx=abs(fftshift(fft(mctx,fftlen)))/fftlen;%fft of modulated signal

%Time Domain Plots
figure;
subplot(3,2,1)
plot(tvec,mtx)
title('Message Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim([0.1 0.1+2e-3])

subplot(3,2,3)
plot(tvec,ctx)
title('Carrier Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim([0.1 0.1+2e-3])

subplot(3,2,5)
plot(tvec,mtx)
hold on
plot(tvec,mctx)
legend('Message Signal','Modulated Signal')
title('Message Signal and Modulated Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim([0.1 0.1+2e-3])

%Frequency Domain Plots
subplot(3,2,2)
plot(freqaxis,fft_mtx)
title('FFT of the Message Signal')
ylabel('Amplitude')
xlabel('Frequency')
grid on;

subplot(3,2,4)
plot(freqaxis,fft_ctx)
title('FFT of the Carrier Signal')
ylabel('Amplitude')
xlabel('Frequency')
grid on;

subplot(3,2,6)
plot(freqaxis,fft_mctx)
title('FFT of the Modulated Signal')
ylabel('Amplitude')
xlabel('Frequency')
grid on;
%it is suggested to observe the modulated signal (passband) only in
% positive frequencies
xlim([0 fs/2]) 

pause();

%% AM DSB-SC Demodulation
ffilter=10*1e3; %cut-off frequency of the filter
thetadeg=0; %phase difference between the carrier signals in the modulator and the demodulator
crx=2*cos(2*pi*fc*tvec+deg2rad(thetadeg)); %carrier signal in the demodulator side

mmix=mctx.*crx; %signal at the output of mixer (before lpf)
mrecov=lowpass(mmix,ffilter,fs); %recovered message signal (after lpf)

fft_mmix=abs(fftshift(fft(mmix,fftlen)))/fftlen; %fft of the signal at the output of mixer (before lpf)
fft_mrecov=abs(fftshift(fft(mrecov,fftlen)))/fftlen; %fft of recovered message signal (after lpf)

figure;
subplot(3,1,1)
plot(freqaxis,fft_mmix)
title('FFT of the Signal at the Output of the Mixer')
ylabel('Amplitude')
xlabel('Frequency')
grid on;

subplot(3,1,2)
plot(freqaxis,fft_mrecov)
title('FFT of the Recovered Message Signal')
ylabel('Amplitude')
xlabel('Frequency')
grid on;

subplot(3,1,3)
plot(tvec,mtx)
hold on
plot(tvec,mrecov,'--')
legend('Original Message Signal','Recovered Message Signal')
title('Original Message Signal and Recovered Message Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim([0.1 0.1+2e-3])