%% Padé approximation of a transfer function with delay
close, clear, clc

K = 1.8;
Kp = .5;
T = 2;
tau = 6;

H1 = tf(K, [T 1], 'ioDelay', tau);
Hr = feedback(pid(Kp) * H1, 1);
Hp = pade(Hr, 1);

step(Hp)

