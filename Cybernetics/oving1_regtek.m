% �ving 2 - Regtek
R2 =  10e3; % k[ohm]
R1 = 100e3; % k[ohm]
C1 = 30e-6; % mic[F]

s = tf('s');
t = 0:pi/100:2*pi;

% Krets A)  
A_h = 1 / (R1 * C1 *s + 1);

% Krets B)
B_h = (R1 * C1 * s) / (R1 * C1 *s + 1);

% Krets C)
C_h = R2 * (1 + s * C1 * R1) / (R1 + R2 * (1 + s * C1 * R1));

% Plott er flott
% Oppgave 1d)
hold on;
legend('show');
impulse(A_h);
impulse(B_h);
impulse(C_h);
hold off;

% Sinuser
v1 = 5*sin(2*pi*0.2*t); % A = 5, f = 0.2
v2 = 5*sin(2*pi*1.0*t); % A = 5, f = 1.0

% Oppgave 1e)
figure;
%lsim(A_h, B_h, C_h, v1, t)