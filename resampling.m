% Resampling
%
% Turker Dolapci
% 2024.10.15

clear all
close all
clc

%% Generate a sinusoidal signal
fc=1e3; %frequency of the test signal to be generated

fs= 100*1e3 %sampling rate
numsamp=10000;%number of samples to be generated

timedur=(numsamp-1)/fs;
t=0:(1/fs):(timedur); %time vector
y=cos(2*pi*fc*t); %signal

fftlen=length(y);
fft_y=abs(fftshift(fft(y,fftlen)))/fftlen; %magnitude of the fft of x
fft_y_dBscale=20*log10(fft_y); %magnitude of the fft of x in dB scale
df=fs/fftlen; %frequency resolution (frequency bin width)
freqaxis= (((-fs/2):df:((fs/2)-df)) + (mod(fftlen,2)*df)/2).'; %frequency axis

figure;
subplot(2,2,1)
scatter(t,y)
hold on
plot(t,y)
grid on
title('Original Signal')
xlabel('Time (s)')
ylabel('Amplitude')
xlim([5/fc 10/fc])

subplot(2,2,2)
plot(freqaxis,fft_y_dBscale)
grid on
title('Original Signal in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude of Spectrum (dB)')
ylim([-60 0])
xlim([min(freqaxis) max(freqaxis)])

%% Resample the sinusoidal signal by interpolation and decimation
interpratio=5; %interpolation ratio
decratio=50; %decimation ratio

y_resamp = interp(y,interpratio); %interpolation of the data
y_resamp = decimate(y_resamp,decratio); %decimation of the data

% interpolation and decimation in single line
% y_resamp = resample(y,interpratio,decratio); 

fs_resamp=fs*interpratio/decratio %new sampling rate
t_resamp=0:(1/fs_resamp):(timedur); %new time vector

fftlen_resamp=length(y_resamp);
fft_y_resamp=abs(fftshift(fft(y_resamp,fftlen_resamp)))/fftlen_resamp; %magnitude of the fft of x
fft_y_resamp_dBscale=20*log10(fft_y_resamp); %magnitude of the fft of x in dB scale
df_resamp=fs_resamp/fftlen_resamp; %frequency resolution (frequency bin width)
freqaxis_resamp= (((-fs_resamp/2):df_resamp:((fs_resamp/2)-df_resamp)) + (mod(fftlen_resamp,2)*df_resamp)/2).'; %frequency axis

subplot(2,2,3)
scatter(t_resamp,y_resamp)
hold on
plot(t_resamp,y_resamp)
grid on
title('Resampled Signal in Time Domain')
xlabel('Time (s)')
ylabel('Amplitude')
xlim([5/fc 10/fc])

subplot(2,2,4)
plot(freqaxis_resamp,fft_y_resamp_dBscale)
grid on
title('Resampled Signal in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude of Spectrum (dB)')
ylim([-60 0])
xlim([min(freqaxis_resamp) max(freqaxis_resamp)])