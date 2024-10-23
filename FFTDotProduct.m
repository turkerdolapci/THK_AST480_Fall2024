% Orthogonality of FFT frequency bins
% FFT as a dot product
%
% Turker Dolapci
% 2024.09.10
%

clear all
close all
clc

fs= 1e3; %sampling rate
numsamp=1024;%number of samples to be generated
t= (0:(1/fs):((numsamp-1)/fs)).'; %time vector
fftlen=128; %length of fft, can be selected equal to length(t) (number of time domain samples) for full resolution
df=fs/fftlen; %frequency resolution of fft

f_values= (((-fs/2):df:((fs/2)-df)) + (mod(fftlen,2)*df)/2).'; %frequency values of fft outputs, -0.5fs to 0.5fs

%nth column of the sig is the compex exponential with nth frequency of the fourier analysis
for n=1:length(f_values)
    sig(:,n)=exp(j*2*pi*f_values(n)*t);
end

%correlation matrix which shows the correaltion between the complex sinusoidals of the fourier analysis
for n=1:length(f_values)
    for nn=1:length(f_values)
        corrMatrix(n,nn)=dot(sig(:,n),sig(:,nn))/length(t);
    end
end

figure;
surf(f_values,f_values,abs(corrMatrix))
colorbar
xlabel(['Signal with Frequency Bin 1 (Hz)'])
ylabel(['Signal with Frequency Bin 2 (Hz)'])
zlabel('Correlation')
grid on
title('Correlation of FFT Frequency Bins to Each Other')

pause();

%%%%%%%%%%%%%%%%%%%%%%%%

% Generate a test signal
fTest= f_values(20) %frequency of the test signal
phaseTest_deg=90 %phase fof the test signal
sigTest= exp(j*2*pi*fTest*t+j*deg2rad(phaseTest_deg)); %generated test signal

% correlation matrix which shows the correlation between the complex
%sinusoidals of the fourier analysis and the test signal
for n=1:length(f_values)
    corrMatrixFFT(n,1)=dot(sig(:,n),sigTest)/length(t);
end

figure;
tiledlayout(2,1)
ax1 = nexttile;
plot(f_values,abs(corrMatrixFFT))
colorbar
xlabel(['Signal with Frequency Bin (Hz)'])
ylabel(['Magnitude of Correlation of Test Signal with FFT Bins'])
grid on
title('Correlation of FFT Frequency Bins with Test Signal')

ax2 = nexttile;
plot(f_values,rad2deg(angle(corrMatrixFFT)))
colorbar
xlabel(['Signal with Frequency Bin (Hz)'])
ylabel(['Phase of Correlation of Test Signal with FFT Bins (^\circ)'])
grid on
% title('Correlation of FFT Frequency Bins with Test Signal')
linkaxes([ax1,ax2],'x')