clear, close, clc

Kp = 2;
Hs = tf(1.8, [0 15 1], 'ioDelay', 6);

Hr = pid(Kp)
T = feedback(Hr*Hs, 1)
step(T);

