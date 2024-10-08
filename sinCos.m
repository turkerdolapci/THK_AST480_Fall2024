% sin and cos signals
%
% Turker Dolapci
% 2024.08.12
%

clear all 	% clears everything in workspace
close all	% closes if there is something (e.g. figures)
clc 		% clears command window

%% Input section
fs= 10*1e3; %sampling rate equals to the number of samples per second (samples per second)
tdur= 1; 		% time length of the signal to be generated in seconds
fc1= 0.4*1e3;
fc2= 3*1e3;

%% Plot a sin and cos signal with the same amplitude and frequency in the same figure
t= (0:(1/fs):tdur).'; 	%time vector

sin1= sin(2*pi*fc1*t);
cos1= cos(2*pi*fc1*t);

figure;
plot(t, sin1)
hold on
plot(t, cos1)
title('sin and cos signals')
ylabel('Amplitude')
xlabel('Time (s)')
grid on
legend('sin(2*pi*f*t)', 'cos(2*pi*f*t)')
xlim([0 0.01])
pause();
%% Dot product https://www.mathworks.com/help/matlab/ref/dot.html
dot_sin1cos1= dot(sin1,cos1) %dot product of the sin signal with the cos signal
dot_selfsin1= dot(sin1,sin1); %dot product of the sin signal with itself (its energy or its norm^2)
dot_selfcos1= dot(cos1,cos1); %dot product of the cos signal with itself (its energy or its norm^2)

ampsin1=3; %amplitude of sin1 for the summation
ampcos1=2; %amplitude of cos1 for the summation

sumsincos=ampsin1*sin1+ampcos1*cos1; %sum of sin and cos signals

plot(t, sumsincos)
legend('sin(2*pi*f*t)', 'cos(2*pi*f*t)','ampsin1*sin(2*pi*f*t)+ampcos1*cos(2*pi*f*t)')

dot_sumsincos_with_sin= dot(sumsincos,sin1)/dot_selfsin1 %dot product of summation with sin1
dot_sumsincos_with_cos= dot(sumsincos,cos1)/dot_selfcos1 %dot product of summation with cos1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sin2= sin(2*pi*fc2*t);
cos2= cos(2*pi*fc2*t);

dot_selfsin2= dot(sin2,sin2); %dot product of the sin signal with itself (its energy or its norm^2)
dot_selfcos2= dot(cos2,cos2); %dot product of the cos signal with itself (its energy or its norm^2)


ampsin2=1.5; %amplitude of sin2 for the summation
ampcos2=-0.67; %amplitude of cos2 for the summation

sumall=ampsin1*sin1+ampcos1*cos1+ampsin2*sin2+ampcos2*cos2; %sum of sin and cos signals

figure;
plot(t, sumall)
title('sum of sin and cos signals')
ylabel('Amplitude')
xlabel('Time (s)')
grid on
xlim([0 0.02])

dot_sumall_with_sin1= dot(sumall,sin1)/dot_selfsin1 %dot product of summation with sin1
dot_sumall_with_cos1= dot(sumall,cos1)/dot_selfcos1 %dot product of summation with cos1
dot_sumall_with_sin2= dot(sumall,sin2)/dot_selfsin2 %dot product of summation with sin2
dot_sumall_with_cos2= dot(sumall,cos2)/dot_selfcos2 %dot product of summation with cos2
