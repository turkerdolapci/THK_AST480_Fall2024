% singleTone
%
% Sinusoidal voltage signal,  RMS voltage, power
%
% Turker Dolapci
% 2024.08.10
%
clear all 	% clears everything in workspace
close all	% closes if there is something (e.g. figures)
clc 		% clears command window

fs= 20*1e3; % sampling rate (we will learn how to select sapmling rate)
%sampling rate equals to the number of samples per second (samples per second)

tdur= 0.5; 		% time length of the signal to be generated in seconds
t= 0:(1/fs):tdur; 	%time vector

fc= 1*1e3; 	% frequency of the signal to be generated
T=1/fc; 	% period of the signal

Vpeak=10; 	% peak voltage of the signal
R=50; 		% impedance of the load (resistor connected to the voltage source)

V= Vpeak*sin(2*pi*fc*t); 	% instantaneous voltage of the signal
I=V/R; 						% current passing through resistor
P=V.^2/R; 					%power dissipated in R, because of V
%P is also equals to V.*I, you can insert equation of R in line 23 into line 24

figure
subplot(2,1,1)
plot(t,V,'-*')
xlim([0,5*T])
title('Voltage of Signal')
ylabel('Voltage (V)')
xlabel('Time (s)')
grid on

subplot(2,1,2)
plot(t,P,'-*')
xlim([0,5*T])
title('Instantaneous Power Dissipated on Resistor')
ylabel('Power (W)')
xlabel('Time (s)')
grid on

%Value of R is constant in time (50 ohms in our case). But the voltage changes very
%rapidly (its amplitude changes from -V_peak to V_peak, fc times in a second!)
%It is not easy to measure the power instantaneously!
%So, we calculate the average power!
%While calculating the value of Pavg, we sum all P=V^2/R values in time,
%then divide the result to the number of values (taking average of V^2/R).
Pavg_1=mean(P) %average power
%or you can code as follows:
%Pavg_1=sum(P)/length(P);

%As an easy convention, we use root-mean square values of sinusoidal
%signals while calculating the average values, which is calculated as
%folllows:
Vrms=Vpeak/sqrt(2);
Pavg_2=Vrms.^2/R

%Think about your electricity in home:
%-Its frequency is 50 Hz.
%-How about its voltage, is it Vrms=220 or Vpeak=220?
%
%https://en.wikipedia.org/wiki/Root_mean_square#Average_electrical_power