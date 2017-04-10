clear, close, clc

Kp = 1;
Hs = tf(1.8, [0 15 1], 'ioDelay', 6);


for i = [.1 .2 .3 .5]
hold on
P = pid(i);
Hr = feedback(P*Hs, 1);
step(Hr);
end




