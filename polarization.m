% Polarization of Waves
%
% Turker Dolapci
% 2024.11.25
%
clear all
close all
clc

f=1e6;%frequeny of e field
fs=100*f; %sampling rate
tend=5/f; %time duration
t=0:1/fs:tend; %time vector


%CCW (LHCP)
hor1=cos(2*pi*f*t);
ver1=cos(2*pi*f*t+pi/2);

%CW (RHCP)
hor2=cos(2*pi*f*t+pi/2);
ver2=cos(2*pi*f*t);



figure;

subplot(2,2,1)
plot3(t,hor1,ver1)
xlabel('t')
ylabel('hor')
zlabel('ver')
title('LHCP (CCW)')
axis tight

subplot(2,2,2)
plot3(t,hor2,ver2)
xlabel('t')
ylabel('hor')
zlabel('ver')
title('RHCP (CW)')
axis tight

subplot(2,2,3)
plot3(t,hor1,0*ver1)
xlabel('t')
ylabel('hor')
zlabel('ver')
title('Horizontal Polarization')
axis tight

subplot(2,2,4)
plot3(t,0*hor1,ver1)
xlabel('t')
ylabel('hor')
zlabel('ver')
title('Vertical Polarization')
axis tight
