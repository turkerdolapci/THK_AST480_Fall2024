% dB Scale
%
% Turker Dolapci
% 2024.08.10
%

clear all
close all
clc

frequency=linspace(100*1e6,200*1e6,7); %the frequencies where the gain is measured
amplifiergain_lin=[1 2 4 1000 8 1 1/4]; %measured gain values in the selected frequencies
amplifiergain_db=10*log10(amplifiergain_lin); %gain values in dB's

figure;
subplot(1,2,1)
plot(frequency,amplifiergain_lin,'o-','LineWidth',2)
title('Gain (Linear Scale)')
ylabel('Gain')
xlabel('Frequency (Hz)')
grid on

subplot(1,2,2)
plot(frequency,amplifiergain_db,'o-','LineWidth',2)
title('Gain (dB Scale)')
ylabel('Gain (dB)')
xlabel('Frequency (Hz)')
grid on