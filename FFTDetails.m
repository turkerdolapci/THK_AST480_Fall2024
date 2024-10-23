% Turker's notebook on FFT
%
% Turker Dolapci
% 2024.05.29
%
clear all 	% clears everything in workspace
close all	% closes if there is something (e.g. figures)
clc 		% clears command window
fs= 20*1e6; %sampling rate

numsamp=4000;%number of samples to be generated
t= (0:(1/fs):((numsamp-1)/fs)).'; %time vector

%t_dur= 2*1e-4; %time length of the signal
%t= (0:(1/fs):t_dur).'; %time vector

fftlen=length(t); %length of fft, equal to number of samples for full resolution
df=fs/fftlen; %frequency resolution of fft

faxis=(0:df:(fs-df)).'; %frequency values of fft outputs, 0 to fs

%fc= 4e6; % frequency of the signal to be generated
fc= faxis(250) % frequency of the signal to be generated

real_tone= exp(j*2*pi*fc*t)+exp(-j*2*pi*fc*t); %cos(2*pi*fc*t) (LEARN EULER'S FORMULA)
fftof_real_tone=abs(fft(real_tone,fftlen))/fftlen;

figure;
subplot(3,2,1)
plot(faxis,fftof_real_tone)
title('FFT of Real Tone Signal, Freq. Axis: [0, fs/2]')
ylabel('Amplitude')
xlabel('Frequency')
xlim([0,fs/2])
grid on;
pause;
title('FFT of Real Tone Signal, Freq. Axis: [0, fs]')
xlim([0,fs])
grid on;
pause;

complex_tone_pos= exp(j*2*pi*fc*t);
fftof_complex_tone_pos=abs(fft(complex_tone_pos,fftlen))/fftlen;

subplot(3,2,3)
plot(faxis,fftof_complex_tone_pos)
title('FFT of Complex Positive Tone Signal, Freq. Axis: [0, fs]')
ylabel('Amplitude')
xlabel('Frequency')
grid on;
pause;

complex_tone_neg= exp(-j*2*pi*fc*t);
fftof_complex_tone_neg=abs(fft(complex_tone_neg,fftlen))/fftlen;

subplot(3,2,5)
plot(faxis,fftof_complex_tone_neg)
title('FFT of Complex Negative Tone Signal, Freq. Axis: [0, fs]')
ylabel('Amplitude')
xlabel('Frequency')
grid on;
pause;

%% FFTSHIFT
a_oddnumel=1:5 %random vector, odd number of elements
fftshift_a_oddnumel=fftshift(a_oddnumel) %see what happens with fftshift
pause;

b_evennumel=1:6 %random vector, even number of elements
fftshift_b_evennumel=fftshift(b_evennumel) %see what happens with fftshift

faxis_shifted= (((-fs/2):df:((fs/2)-df)) + (mod(fftlen,2)*df)/2).'; %frequency values of fft outputs, -0.5fs to 0.5fs
fftof_real_tone_shifted=fftshift(fftof_real_tone);
fftof_complex_tone_pos_shifted=fftshift(fftof_complex_tone_pos);
fftof_complex_tone_neg_shifted=fftshift(fftof_complex_tone_neg);

subplot(3,2,2)
plot(faxis_shifted,fftof_real_tone_shifted)
title('FFT of Real Tone Signal, Freq. Axis: [-fs/2, fs/2]')
ylabel('Amplitude')
xlabel('Frequency')
grid on;
pause;

subplot(3,2,4)
plot(faxis_shifted,fftof_complex_tone_pos_shifted)
title('FFT of Complex Positive Tone Signal, Freq. Axis: [-fs/2, fs/2]')
ylabel('Amplitude')
xlabel('Frequency')
grid on;
pause;

subplot(3,2,6)
plot(faxis_shifted,fftof_complex_tone_neg_shifted)
title('FFT of Complex Negative Tone Signal, Freq. Axis: [-fs/2, fs/2]')
ylabel('Amplitude')
xlabel('Frequency')
grid on;

%I always prefer to plot the spectrum by using fftshift
%It is sometimes confusing to understand whether it is shifted or not
% x is the signal to be analyzed and sampling rate is fs
% fftlen=length(x); %number of fft bins for full resolution
% fft_x=abs(fftshift(fft(x,fftlen)))/fftlen; %magnitude of the fft of x
% fft_x_dBscale=20*log10(fft_x); %magnitude of the fft of x in dB scale
% df=fs/fftlen; %frequency resolution (frequency bin width)
% freqaxis= (((-fs/2):df:((fs/2)-df)) + (mod(fftlen,2)*df)/2).'; %frequency axis
