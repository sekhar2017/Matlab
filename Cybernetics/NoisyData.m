%% Simulate some noisy data
% can be used for applying filters etc.
x = 1:.1:10;
T = 0.1*x + 1;
Tn = T + 0.1*randn(size(x));
plot(x, Tn, '.');

%% Simulate drag coefficient d = kv^2
% this data replicates what you migth expect in a wind tunnel.
v = 0:1:60;
d = 0.1234*v.^2;
dn = d + 0.4*v.*randn(size(v));
plot(v, dn, '*');