% Superposition of sinusoidal waves
%
% Turker Dolapci
% 2024.08.10
%

clear all 	% clears everything in workspace
close all	% closes if there is something (e.g. figures)
clc 		% clears command window

fs= 40*1e3; %sampling rate equals to the number of samples per second (samples per second)
tdur= 0.5; 		% time length of the signal to be generated in seconds
t= (0:(1/fs):tdur).'; 	%time vector
%it is advised for you to create column vectors, rather than row vectors
%because it is the convention, obey the conventions!! 
fc= 1*1e3; 	
T=1/fc;
R=50; 		% impedance of the load (resistor connected to the voltage source)


sig1= (1)*sin(2*pi*fc*t); 	
sig2= (1/3)*sin(2*pi*3*fc*t); 	
sig3= (1/5)*sin(2*pi*5*fc*t); 	
sig4= (1/7)*sin(2*pi*7*fc*t); 	
sig5= (1/9)*sin(2*pi*9*fc*t); 	
totalsig=sig1+sig2+sig3+sig4+sig5;

%to be more neat, you can create a matrix, in which each column includes a
%signal
%signals=[sig1,sig2,sig3,sig4,sig5];
%totalsig=sum(signals,2);

P_avg_sig1=10*log10(mean(sig1.^2/R))+30;
P_avg_sig2=10*log10(mean(sig2.^2/R))+30;
P_avg_sig3=10*log10(mean(sig3.^2/R))+30;
P_avg_sig4=10*log10(mean(sig4.^2/R))+30;
P_avg_sig5=10*log10(mean(sig5.^2/R))+30;
P_avg_totalsig=10*log10(mean(totalsig.^2/R))+30;
P_avg_signals=[P_avg_sig1;P_avg_sig2;P_avg_sig3;P_avg_sig4;P_avg_sig5]

figure
subplot(6,1,1)
plot(t,sig1,'o-','LineWidth',2)
xlim([0,5*T])
title('Signal 1')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(6,1,2)
plot(t,sig2,'o-','LineWidth',2)
xlim([0,5*T])
title('Signal 2')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(6,1,3)
plot(t,sig3,'o-','LineWidth',2)
xlim([0,5*T])
title('Signal 3')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(6,1,4)
plot(t,sig4,'o-','LineWidth',2)
xlim([0,5*T])
title('Signal 4')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(6,1,5)
plot(t,sig5,'o-','LineWidth',2)
xlim([0,5*T])
title('Signal 5')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(6,1,6)
plot(t,totalsig,'o-','LineWidth',2)
xlim([0,5*T])
title('Sum of All Signals')
ylabel('Amplitude')
xlabel('Time')
grid on

%%%%%%%%%%%%%
%filtering
% https://www.mathworks.com/help/signal/ref/bandpass.html
filterbw=fc/10;
filteredsig1=bandpass(totalsig,[fc-filterbw/2 fc+filterbw/2],fs);
filteredsig2=bandpass(totalsig,[3*fc-filterbw/2 3*fc+filterbw/2],fs);
filteredsig3=bandpass(totalsig,[5*fc-filterbw/2 5*fc+filterbw/2],fs);
filteredsig4=bandpass(totalsig,[7*fc-filterbw/2 7*fc+filterbw/2],fs);
filteredsig5=bandpass(totalsig,[9*fc-filterbw/2 9*fc+filterbw/2],fs);

figure;
subplot(6,1,1)
plot(t,filteredsig1,'o-','LineWidth',2)
xlim([0,5*T])
title('Filtered Output 1')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(6,1,2)
plot(t,filteredsig2,'o-','LineWidth',2)
xlim([0,5*T])
title('Filtered Output 2')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(6,1,3)
plot(t,filteredsig3,'o-','LineWidth',2)
xlim([0,5*T])
title('Filtered Output 3')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(6,1,4)
plot(t,filteredsig4,'o-','LineWidth',2)
xlim([0,5*T])
title('Filtered Output 4')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(6,1,5)
plot(t,filteredsig5,'o-','LineWidth',2)
xlim([0,5*T])
title('Filtered Output 5')
ylabel('Amplitude')
xlabel('Time')
grid on


P_avg_filteredsig1=10*log10(mean(filteredsig1.^2/R))+30;
P_avg_filteredsig2=10*log10(mean(filteredsig2.^2/R))+30;
P_avg_filteredsig3=10*log10(mean(filteredsig3.^2/R))+30;
P_avg_filteredsig4=10*log10(mean(filteredsig4.^2/R))+30;
P_avg_filteredsig5=10*log10(mean(filteredsig5.^2/R))+30;
P_avg_filteredsignals=[P_avg_filteredsig1;P_avg_filteredsig2;P_avg_filteredsig3;P_avg_filteredsig4;P_avg_filteredsig5]



sa = spectrumAnalyzer('SampleRate',fs, ...
    'ReferenceLoad',R,...
    'PlotAsTwoSidedSpectrum',false,...
    'SpectrumType','Power');

sa(totalsig)