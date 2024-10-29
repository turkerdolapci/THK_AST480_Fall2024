% AM DSB-SC - Script with human audio and SNR
%
% Turker Dolapci
% 2024.10.29
%

clear all 	% clears everything in workspace
close all	% closes if there is something (e.g. figures)
clc 		% clears command window

%% Input section
[sig_fsaudio,fsaudio] = audioread('audiosample.wav'); 
sound(sig_fsaudio,fsaudio); %playing the signal as sound
pause();

fs=500e3; %sampling rate of carrier signal
fc=100e3; %frequency of the carrier signal

%% Resample the audio signal 
%resample the audio signal to be equal with the carier signal sampling rate
mtx=resample(sig_fsaudio,fs,fsaudio); 
numsamp=length(mtx); %number of samples in the resampled audio signal

%% Time and frequency vectors
tvec=(0:(1/fs):((numsamp-1)/fs)).'; %time vector to generate sinusoidal signals
fftlen=length(tvec); %number of frequency bins of fft
df=fs/fftlen; %frequency resolution of fft
freqaxis= (((-fs/2):df:((fs/2)-df)) + (mod(fftlen,2)*df)/2).'; %frequency axis of shifted fft plot

%% Generation of the carrier signal
ctx=cos(2*pi*fc*tvec); %carrier signal

fft_mtx=abs(fftshift(fft(mtx,fftlen)))/fftlen; %fft of message signal
fft_ctx=abs(fftshift(fft(ctx,fftlen)))/fftlen; %fft of carrier signal

%% AM DSB-SC modulation
mctx=mtx.*ctx; %modulated signal
fft_mctx=abs(fftshift(fft(mctx,fftlen)))/fftlen;%fft of modulated signal

%Time domain plots
figure;
subplot(3,2,1)
plot(tvec,mtx)
title('Message Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim([1.02 1.03])

subplot(3,2,3)
plot(tvec,ctx)
title('Carrier Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim([1.02 1.03])

subplot(3,2,5)
plot(tvec,mtx,'LineWidth',3)
hold on
plot(tvec,mctx)
legend('Message Signal','Modulated Signal')
title('Message Signal and Modulated Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim([1.02 1.03])

%Frequency domain plots
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

%% Noise addition
SNRdB=-20; %signal to noise ratio at the receiver before the demodulation
mcrx=awgn(mctx,SNRdB,'measured'); %signal entering the demodulator
fft_mcrx=abs(fftshift(fft(mcrx,fftlen)))/fftlen;%fft of the signal entering the demodulator

figure;
subplot(2,2,1)
plot(freqaxis,fft_mctx)
title('FFT of the Modulated Signal Without Noise')
legend(strcat('SNR=Inf'))
ylabel('Amplitude')
xlabel('Frequency')
grid on;
xlim([0 fs/2]) 

subplot(2,2,3)
plot(freqaxis,fft_mcrx)
title('FFT of the Modulated Signal With Noise')
legend(strcat('SNR=',num2str(SNRdB),'dB'))
ylabel('Amplitude')
xlabel('Frequency')
grid on;
xlim([0 fs/2]) 

subplot(2,2,2)
plot(tvec,mctx)
title('Modulated Signal Without Noise')
legend(strcat('SNR=Inf'))
ylabel('Amplitude')
xlabel('Time (s)')
grid on;
xlim([1.02 1.03])

subplot(2,2,4)
plot(tvec,mcrx)
title('Modulated Signal With Noise')
legend(strcat('SNR=',num2str(SNRdB),'dB'))
ylabel('Amplitude')
xlabel('Time (s)')
grid on;
xlim([1.02 1.03])

pause();

%% AM DSB-SC demodulation
ffilter=10*1e3; %cut-off frequency of the filter
thetadeg=0; %phase difference between the carrier signals in the modulator and the demodulator
crx=2*cos(2*pi*fc*tvec+deg2rad(thetadeg)); %carrier signal in the demodulator side
mmix=mcrx.*crx; %signal at the output of mixer (before lpf)
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
xlim([1.02 1.03])

pause();

%% Listen the recovered signal
%try the following line, it is not possible to play audio with
%this high sampling rate
% sound(mrecov,fs); 
%So, we need to decimate the signal to pay with our speakers and listen it
decimrate=25; %decimation rate
mrecov_decim=decimate(mrecov,decimrate); %decimation
sound(mrecov_decim,fs/decimrate); %playing the signal as sound