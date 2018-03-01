%%

% Fourier-rekka til eit lydsignal
clear
close all

[yA,Fs] = audioread('docs/vokalar/a.wav');
yE      = audioread('docs/vokalar/e.wav');
yI      = audioread('docs/vokalar/i.wav');
yO      = audioread('docs/vokalar/o.wav');
yU      = audioread('docs/vokalar/u.wav');
yY      = audioread('docs/vokalar/y.wav');
yAE     = audioread('docs/vokalar/æ.wav');
yOE     = audioread('docs/vokalar/ø.wav');
yAA     = audioread('docs/vokalar/å.wav');

%% 

% Vi vel ut ein vokal og speler av lyden
yy = yY;
soundsc(yy,Fs)

%%

% Vi vel ut ei periode av signalet og viser dette grafisk

f0 = 220;             % Grunnfrekvensen i Hz
m  = round(Fs/f0);    % Antall samplingar i ei periode

L = 1/(2*f0);         % Reknar ut L 
t = linspace(-L,L,m); % Tidsrommet
N = 20;               % Antall ledd i fourier-rekka

y  = yy(1:m)';

% Grafisk framstilling av 3 perioder
figure(1)
plot(t,y), hold on, grid on

%%

% Vi reknar ut fourierkoeffisientane nummerisk

a = zeros(1,N);
b = zeros(1,N);

a0 = 1/(2*L)*trapz(t,y);
for n = 1:N
    a(n) = 1/L*trapz(t,y.*cos(n*pi/L*t));
    b(n) = 1/L*trapz(t,y.*sin(n*pi/L*t));
end

%%

% Vi vil no bruke dei utrekna koeffisientane til � generere eit lydsignal lyd.
T = 0:1/Fs:1;
Y = 0*T + a0;
for n = 1:N
    Y = Y + a(n)*cos(n*pi/L*T) + b(n)*sin(n*pi/L*T);
end
plot(T(1:3*m),Y(1:3*m)), hold off

%%

% Viser koeffisientane grafisk

figure(2)
plot([0 1:N], [a0 a], 'o', 1:N, b,'.'), grid on

%%

% Reknar koeffisientane om til amplityder. 

A = sqrt(a.^2 + b.^2);

figure(3)
stem((1:N)*f0,A), grid on
xlabel('freq [Hz]')

%%
soundsc(Y,Fs)