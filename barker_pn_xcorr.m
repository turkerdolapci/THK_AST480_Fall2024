% Barker sequence, pn sequence, and fiding the lag with xcorr
%
% Turker Dolapci
% 2024.10.14
%

clear all
close all
clc

barker13seq=[1 1 1 1 1 -1 -1 1 1 -1 1 -1 1]; %length 13 barker code sequence
pn13seq=[(-1).^(randi([0 1],1,13))]; %length 13 pseudo noise sequence

[xcorrBarker13,lagsBarker13]=xcorr(barker13seq); %autocorrelation of barker13 sequence
[xcorrpn13,lagspn13]=xcorr(pn13seq); %autocorrelation of length 13 pseudo noise sequence

figure
plot(lagsBarker13,xcorrBarker13)
hold on
plot(lagspn13,xcorrpn13)
xlabel('Lag (Samples)')
ylabel('Autocorrelation Result')
legend('Barker 13 Sequence','Length 13 PN Sequence')
title('Autocorrelation of Length 13 Sequences')
grid on

%random binary signal sequence followed by barker 13 code
insertrandsamp=70;
rx_seq=[[(-1).^(randi([0 1],1,insertrandsamp))]  barker13seq];
[R,lags]=xcorr(rx_seq,barker13seq);
figure
plot(lags,R)
xlabel('Lag (Samples)')
ylabel('Cross Correlation Result')
title('Cross Correlation Result of Original Signal and Lagged Signal')
grid on

