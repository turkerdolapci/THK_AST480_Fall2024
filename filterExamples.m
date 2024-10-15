% Filter examples
%
% Turker Dolapci
% 2024.10.07
%

clear all
close all
clc

fs= 50*1e3; %sampling rate
numsamp=10*1e3;%number of samples to be generated
fftlen=1024; %length of fft

f1=5*1e3;
f2=10*1e3;
f3=15*1e3;

t= (0:(1/fs):((numsamp-1)/fs)).'; %time vector
df=fs/fftlen;
f_values= (((-fs/2):df:((fs/2)-df)) + (mod(fftlen,2)*df)/2).'; %frequency values of fft outputs, -0.5fs to 0.5fs

sin1=sin(2*pi*f1*t);
sin2=sin(2*pi*f2*t);
sin3=sin(2*pi*f3*t);

totalsig=sin1+sin2+sin3;

filteredsig1=lowpass(totalsig,7*1e3,fs);
filteredsig2=lowpass(totalsig,12*1e3,fs);
filteredsig3=highpass(totalsig,12*1e3,fs);
filteredsig4=bandpass(totalsig,[7*1e3 12*1e3],fs);
filteredsig5=bandstop(totalsig,[7*1e3 12*1e3],fs);

totalsig_fftdB=20*log10(abs(fftshift(fft(totalsig,fftlen))));
filteredsig1_fftdB=20*log10(abs(fftshift(fft(filteredsig1,fftlen))));
filteredsig2_fftdB=20*log10(abs(fftshift(fft(filteredsig2,fftlen))));
filteredsig3_fftdB=20*log10(abs(fftshift(fft(filteredsig3,fftlen))));
filteredsig4_fftdB=20*log10(abs(fftshift(fft(filteredsig4,fftlen))));
filteredsig5_fftdB=20*log10(abs(fftshift(fft(filteredsig5,fftlen))));

figure;
subplot(6,1,1)
plot(f_values,totalsig_fftdB);
grid on;
ylim([20 50])
xlim([-0.5*fs 0.5*fs])
title('all pass')
xlabel('Frequency (Hz)')
ylabel('Amp. (dB)')

subplot(6,1,2)
plot(f_values,filteredsig1_fftdB);
grid on;
ylim([20 50])
xlim([-0.5*fs 0.5*fs])
title('low pass 7khz')
xlabel('Frequency (Hz)')
ylabel('Amp. (dB)')

subplot(6,1,3)
plot(f_values,filteredsig2_fftdB);
grid on;
ylim([20 50])
xlim([-0.5*fs 0.5*fs])
title('low pass 12khz')
xlabel('Frequency (Hz)')
ylabel('Amp. (dB)')

subplot(6,1,4)
plot(f_values,filteredsig3_fftdB);
grid on;
ylim([20 50])
xlim([-0.5*fs 0.5*fs])
title('high pass 12khz')
xlabel('Frequency (Hz)')
ylabel('Amp. (dB)')

subplot(6,1,5)
plot(f_values,filteredsig4_fftdB);
grid on;
ylim([20 50])
xlim([-0.5*fs 0.5*fs])
title('band pass 7khz-12khz')
xlabel('Frequency (Hz)')
ylabel('Amp. (dB)')

subplot(6,1,6)
plot(f_values,filteredsig5_fftdB);
grid on;
ylim([20 50])
xlim([-0.5*fs 0.5*fs])
title('band stop 7khz-12khz')
xlabel('Frequency (Hz)')
ylabel('Amp. (dB)')
