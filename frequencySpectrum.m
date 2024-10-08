% Frequency Spectrum
%
% Turker Dolapci
% 2024.08.24
%
clear all 	% clears everything in workspace
close all	% closes if there is something (e.g. figures)
clc 		% clears command window

fs= 5*1e3; %sampling rate equals to the number of samples per second (samples per second)
tdur= 1; 		% time length of the signals to be generated in seconds
t=(0:(1/fs):(tdur-(1/fs))).';

%% Tone 1
f_tone1= 1e3; 
amp_tone1= 7; 	

tone1=amp_tone1*sin(2*pi*f_tone1*t);

%% Tone 2
f_tone2= 500; 
amp_tone2= 2; 		

tone2=amp_tone2*sin(2*pi*f_tone2*t);

%% Complex Tone
f_comptone= 800; 
amp_comptone= 1; 
comptone= amp_comptone*exp(j*2*pi*f_comptone*t);

%% Frequency Spectrum by MATLAB Spectrum Analyzer
% https://www.mathworks.com/help/dsp/ref/spectrumanalyzer.html
%Single Sided SA Object
saSingleSided = spectrumAnalyzer('InputDomain','time',...
    'SampleRate',fs, ...
    'FrequencyResolutionMethod','rbw',...
    'RBWSource','property',...
    'RBW',10,...
    'VBWSource','property',...
    'VBW',10,...
    'PlotAsTwoSidedSpectrum',false,...
    'SpectrumType','rms',...
    'SpectrumUnits','Vrms');
% 'SpectrumUnits','dBV');

%Double Sided SA Object
saDoubleSided = spectrumAnalyzer('InputDomain','time',...
    'SampleRate',fs, ...
    'FrequencyResolutionMethod','rbw',...
    'RBWSource','property',...
    'RBW',10,...
    'VBWSource','property',...
    'VBW',10,...
    'PlotAsTwoSidedSpectrum',true,...
    'SpectrumType','rms',...
    'SpectrumUnits','Vrms');
% 'SpectrumUnits','dBV');

%Single Sided Spectrum
saSingleSided(tone1);
pause();
release(saSingleSided);
saSingleSided(tone2);
pause();
release(saSingleSided);
saSingleSided(tone1+tone2);
pause();

%Double Sided Spectrum
saDoubleSided(tone1);
pause();
release(saDoubleSided);
saDoubleSided(tone1+tone2);
pause();
release(saDoubleSided);
saDoubleSided(comptone);


