%% Simulate some noisy data, can be used for applying filters etc.

x = 1:.1:10;
T = 0.1*x + 1;
Tn = T + 0.1*randn(size(x));
plot(x, Tn, '.');
hold on;
plot(x, medfilt1(Tn), '*');
legend('Unfiltered', 'Filtered', 'location', 'best')