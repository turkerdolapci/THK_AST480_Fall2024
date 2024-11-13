% Conventional AM
%
% Turker Dolapci
% 2024.11.02
%

clear all 	% clears everything in workspace
close all	% closes if there is something (e.g. figures)
clc 		% clears command window

%% Part 1: Modulation

%% Input section
inputselect=1; %0: tone, 1:audiofile

fs=500e3; %sampling rate of carrier signal
fc=100e3; %frequency of the carrier signal

if inputselect>0

    %% Audio signal (message signal)
    [sig_fsaudio,fsaudio] = audioread('audiosample.wav');
    % sound(sig_fsaudio,fsaudio); %playing the signal as sound
    % pause();

    %% Resample the audio signal and name it as message signal
    % resample the audio signal to be equal with the carier signal sampling rate
    mtx=resample(sig_fsaudio,fs,fsaudio);

    %% Time vector
    numsamp=length(mtx); %number of samples in the resampled audio signal
    tvec=(0:(1/fs):((numsamp-1)/fs)).'; %time vector to generate sinusoidal signals
    
    %% Axis for plots
    xaxval=[2.1 2.2];
else

    %% Tone signal (Alternative to audio)
    numsamp=500e3;
    fm=1000;
    Am=1.5;
    tvec=(0:(1/fs):((numsamp-1)/fs)).'; %time vector to generate sinusoidal signals
    mtx=Am*cos(2*pi*fm*tvec);
    
    %% Axis for plots
    xaxval=[0.01 0.02];
end

%% Frequency analysis variables
fftlen=length(tvec); %number of frequency bins of fft
df=fs/fftlen; %frequency resolution of fft
freqaxis= (((-fs/2):df:((fs/2)-df)) + (mod(fftlen,2)*df)/2).'; %frequency axis of shifted fft plot

%% Normalize the message signal
mtx_n=mtx/max(abs(mtx));

%% Multiply the normalized message signal by modulation index and add DC shift
a_m=0.8; %modulation index
mtx_n_a=mtx_n*a_m; %scale
mtx_n_a_dc=mtx_n_a+1; %DC shift

figure;
subplot(4,1,1)
plot(tvec,mtx)
title('Message Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
% ylim([-2 2])
xlim(xaxval)

subplot(4,1,2)
plot(tvec,mtx_n)
title('Normalized Message Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
% ylim([-2 2])
xlim(xaxval)

subplot(4,1,3)
plot(tvec,mtx_n_a)
title('Normalized Message Signal Scaled by Modulation Index')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
% ylim([-2 2])
xlim(xaxval)

subplot(4,1,4)
plot(tvec,mtx_n_a_dc)
title('Normalized Message Signal Scaled by Modulation Index and DC Shifted')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
% ylim([-2 2])
xlim(xaxval)

%% Generation of the carrier signal
ctx=cos(2*pi*fc*tvec); %carrier signal

fft_mtx=20*log10(abs(fftshift(fft(mtx,fftlen)))/fftlen); %fft of message signal
fft_mtx_n_a_dc=20*log10(abs(fftshift(fft(mtx_n_a_dc,fftlen)))/fftlen); %fft of scaled and dc shifted message signal
fft_ctx=20*log10(abs(fftshift(fft(ctx,fftlen)))/fftlen); %fft of carrier signal

%% Conventional AM modulation
mtx_am=mtx_n_a_dc.*ctx; %modulated signal
fft_mtx_am=20*log10(abs(fftshift(fft(mtx_am,fftlen)))/fftlen);%fft of modulated signal

%Time domain plots
figure;
subplot(3,2,1)
plot(tvec,mtx_n_a_dc)
title('Scaled and DC Shifted Message Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim(xaxval)

subplot(3,2,3)
plot(tvec,ctx)
title('Carrier Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim(xaxval)

subplot(3,2,5)
plot(tvec,mtx_n_a_dc,'LineWidth',3)
hold on
plot(tvec,mtx_am,'--')
legend('Scaled and DC Shifted Message Signal','Modulated Signal','Location','southeast')
title('Scaled and DC Shifted Message Signal and Modulated Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim(xaxval)

%Frequency domain plots
subplot(3,2,2)
plot(freqaxis,fft_mtx)
title('FFT of the Original Message Signal')
ylabel('Amplitude')
xlabel('Frequency')
grid on;
ylim([-100 0])
xlim([-fs/2 fs/2])

subplot(3,2,4)
plot(freqaxis,fft_mtx_n_a_dc)
hold on
plot(freqaxis,fft_ctx)
legend('Scaled and DC Shifted Message','Carrier','Location','southeast')
title('FFT of the Scaled and DC Shifted Message Signal and Carrier Signal')
ylabel('Amplitude')
xlabel('Frequency')
grid on;
ylim([-100 0])
xlim([-fs/2 fs/2])

subplot(3,2,6)
plot(freqaxis,fft_mtx_am)
title('FFT of the Modulated Signal')
ylabel('Amplitude')
xlabel('Frequency')
grid on;
ylim([-100 0])
xlim([-fs/2 fs/2])

%it is suggested to observe the modulated signal (passband) only in
% positive frequencies
xlim([0 fs/2])


% pause();

%% Part 2: Demodulation by envelope detector
% Envelope detector: diode and slowly discharging parallel RC circuit
R=1e3; %resistor of RC circuit
C=100e-9; %capacitor of RC circuit
tau=R*C; %time constant of parallel RC circuit
dt=1/fs; %time difference between two samples in the simulation

Vc=mtx_am(1); %initial capacitor voltage
for k=2:length(tvec)
    if mtx_am(k)-Vc(k-1)>=0 %diode is short circuit
        Vc(k)=mtx_am(k);
    else %diode is open circuit
        Vc(k)=Vc(k-1)*exp(-dt/tau);
    end
end

% Lowpass filter to smooth the output of envelope detector
f_lpf=10e3;
Vcfilt=lowpass(Vc,f_lpf,fs);

% DC removal
mrecov=Vcfilt-mean(Vcfilt); %recovered message signal
fft_mrecov=20*log10(abs(fftshift(fft(mrecov,fftlen)))/fftlen); %fft of recovered message signal

%% Demodulated signal in time domain
figure;
subplot(2,2,1)
plot(tvec,Vc)
hold on
plot(tvec,Vcfilt)
% plot(tvec,mtx_n_a_dc)
title('Envelope Detector with LPF')
legend('Output of envelope detector','Output of LPF')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim(xaxval)

subplot(2,2,3)
plot(tvec,mtx)
hold on
plot(tvec,mrecov)
% plot(tvec,mtx_n_a_dc)
title('Message Recovery')
legend('Original Message Signal','Recovered Message Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim(xaxval)

%% Demodulated signal in freqency domain
subplot(2,2,2)
plot(freqaxis,fft_mtx)
title('FFT of the Original Signal')
ylabel('Amplitude')
xlabel('Frequency')
grid on;
ylim([-80 -50])
xlim([-fs/2 fs/2])

subplot(2,2,4)
plot(freqaxis,fft_mrecov)
title('FFT of the Recovered Signal')
ylabel('Amplitude')
xlabel('Frequency')
grid on;
ylim([-80 -50])
xlim([-fs/2 fs/2])

% Listen the recovered signal by envelope detector
decimrate=25; %decimation rate
mrecov_decim=decimate(mrecov,decimrate); %decimation
sound(mrecov_decim,fs/decimrate); %playing the recovered signal as sound

%% Part 3: Demodulation by coherent mixing

ffilter=10*1e3; %cut-off frequency of the filter
thetadeg=0; %phase difference between the carrier signals in the modulator and the demodulator
crx=2*cos(2*pi*fc*tvec+deg2rad(thetadeg)); %carrier signal in the demodulator side
mmix=mtx_am.*crx; %signal at the output of mixer (before lpf)
mrecov_coh=lowpass(mmix,ffilter,fs); %recovered message signal (after lpf)
mrecov_coh=mrecov_coh-mean(mrecov_coh);

fft_mmix=20*log10(abs(fftshift(fft(mmix,fftlen)))/fftlen); %fft of the signal at the output of mixer (before lpf)
fft_mrecov_coh=20*log10(abs(fftshift(fft(mrecov_coh,fftlen)))/fftlen); %fft of recovered message signal (after lpf)

%% Demodulated signal in time domain
figure;
subplot(2,2,1)
plot(tvec,mtx)
hold on
plot(tvec,mrecov)
title('Message Recovery by Envelope Detector')
legend('Original Message Signal','Recovered Message Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim(xaxval)

subplot(2,2,3)
plot(tvec,mtx)
hold on
plot(tvec,mrecov_coh)
title('Message Recovery by Coherent Demodulation')
legend('Original Message Signal','Recovered Message Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
xlim(xaxval)

%% Demodulated signal in freqency domain
subplot(2,2,2)
plot(freqaxis,fft_mtx)
title('FFT of the Original Signal')
ylabel('Amplitude')
xlabel('Frequency')
grid on;
xlim([-fs/2 fs/2])
ylim([-100 -50])

subplot(2,2,4)
plot(freqaxis,fft_mrecov_coh)
title('FFT of the Recovered Signal by Coherent Demodulation')
ylabel('Amplitude')
xlabel('Frequency')
grid on;
xlim([-fs/2 fs/2])
ylim([-100 -50])

%% Listen the recovered signal by envelope detector
decimrate=25; %decimation rate
mrecov_coh_decim=decimate(mrecov_coh,decimrate); %decimation
sound(mrecov_coh_decim,fs/decimrate); %playing the recovered signal as sound