% Concatenation of vectors
%
% Turker Dolapci
% 2024.08.24
%

clear all 	% clears everything in workspace
close all	% closes if there is something (e.g. figures)
clc 		% clears command window

fs= 5*1e3; %sampling rate equals to the number of samples per second (samples per second)

%% Tone 1
tdur_tone1= 3; 		% time length of the signals to be generated in seconds
t_tone1=(0:(1/fs):(tdur_tone1-(1/fs))).';

f_tone1= 1*1e3; 
amp_tone1= 7; 	

tone1=amp_tone1*sin(2*pi*f_tone1*t_tone1);

figure;
plot(t_tone1, tone1)
grid on
title('Tone 1')
xlabel('Time (s)')
ylabel('Amplitude')

%% Silence 1
tdur_silence1= 2;
numsamp_silence1=tdur_silence1*fs;
silence1=zeros(numsamp_silence1,1);
%% Multitone
tdur_multitone= 1;
t_multitone=(0:(1/fs):(tdur_multitone-(1/fs))).';

%Tone1
f_multitone1= 300; 	
amp_multitone1= 3; 	
multitone1=amp_multitone1*sin(2*pi*f_multitone1*t_multitone);

%Tone2
f_multitone2= 400;
amp_multitone2= 5; 	
multitone2=amp_multitone2*sin(2*pi*f_multitone2*t_multitone);

%Multitone
multitone=multitone1+multitone2;
figure;
plot(t_multitone, multitone)
grid on
title('Multitone')
xlabel('Time (s)')
ylabel('Amplitude')

%% Silence 2
tdur_silence2= 4;
numsamp_silence2=tdur_silence2*fs;
silence2=zeros(numsamp_silence2,1);

%% Tone 2
tdur_tone2= 5; 		% time length of the signals to be generated in seconds
t_tone2=(0:(1/fs):(tdur_tone2-(1/fs))).';

f_tone2= 500; 
amp_tone2= 2; 		

tone2=amp_tone2*sin(2*pi*f_tone2*t_tone2);

figure;
plot(t_tone2, tone2)
grid on
title('Tone 2')
xlabel('Time (s)')
ylabel('Amplitude')

%% Concatenation Tone1 - Silence 1 - Multi Tone - Silence 2 - Tone 2
sig=[tone1;silence1;multitone;silence2;tone2];
t_sig=0:(1/fs):((length(sig)-1)*(1/fs));

% You have to normalize (limit the range between -1 to +1)
sig = sig/max(abs(sig));

figure;
plot(t_sig, sig)
grid on
title('Concatenation of The Signals')
xlabel('Time (s)')
ylabel('Amplitude')

% sound(sig, fs);

audiowrite('myaudiofile.wav',sig,fs);
[Sig, Fs] = audioread('myaudiofile.wav');

sound(Sig, Fs);
