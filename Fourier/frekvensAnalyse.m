% Frekvensanalyse
clear
close all

% Vi les inn alle lydfilene vha scriptet "les_inn_vokalar.m"
les_inn_vokalar

y = yA;

% Grunnfrekvensen
f0    =  220; % [Hz] 

% Funksjonen FourierCoef reknar ut fourierkoeffisientane numerisk.
[~, a, b, freq] = FourierCoef(y,Fs,f0);

% Vi reknar ut amplitudene til kvar av overtonane.
ampl = sqrt(a.^2+b.^2);

figure(1)
stem(freq,ampl), grid on, hold on
xlabel('f [Hz]')
xlim([0 4000])

%%

% Vi prøver med ein ny grunnfrekvensen ved å dele den gamle grunnfrekvensen
% på eit heilt tall.
[~, a, b, freq] = FourierCoef(y,Fs,f0/32);

% Nye amplituder
ampl = sqrt(a.^2+b.^2);

plot(freq,ampl,'--') %, hold off

% Som vi ser av grafen er det berre eit heilt tall ganger f0 som gjev
% noko særleg utslag. Dette kan vi bruke til å finne ut kva frekvensar 
% som faktisk fins i lyden.

%%

% Det er vanleg å bruke ei rask metode for å rekne ut
% fourierkoeffisientane. Til dette brukar vi funksjonen fft (Fast Fourier
% Transform). Denne reknar ut alle koeffisientane som eksempla over, men
% med så liten grunnfrekvens som mogleg. FFT brukar komplekse
% koeffisientar.

% FFT
Y    = fft(y)/length(y);
N    = length(Y);
freq = (0:N-1)*(Fs/N);

plot(freq, abs(Y) ), hold off

legend('Original fourierrekke','fourierrekke med grunnfrekvens f0/32','fft')