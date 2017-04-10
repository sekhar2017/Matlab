%% Estimation of velocity and position with KalmanFilter
% Intial state
x0 = 0.0; 
v0 = 0.0;

g = 9.81; % gravity
m = 1;    % mass
k = 10;
dt = 0.01;
samplingTime = 200;

clear s 

% Dynamics modeled by A
s.A = [[1 dt]; ...
[0 (1.0-(k/m)*dt)]];

% Measurement noise variance
MNstd = 0.2;
MNV = MNstd*MNstd;

% Process noise variance
PNstd = 0.01;
PNV = PNstd*PNstd;

% Process noise covariance matrix
s.Q = eye(2)*PNV;

% Define measurement function to return the state
s.H = eye(2);

% Define a measurement error
s.R = eye(2)*MNV; % variance

% Use control to include gravity
s.B = eye(2); % Control matrix

% Disturbance
s.u = [0 -g*m*dt]';

% Initial state:
s.x = [x0 v0]';
s.P = eye(2)*MNV;
s.detP = det(s.P);
s.z = zeros(2,1);

% true dynamics
tru = zeros(samplingTime,2); 
tru(1,:) = [x0 v0];
detP(1,:) = s.detP;

for t=2:samplingTime
tru(t,:) = s(t-1).A*tru(t-1,:)'+ s(t-1).B*s(t-1).u+PNstd *randn(2,1);
s(t-1).z = s(t-1).H * tru(t,:)' + MNstd*randn(2,1); % create a measurement
s(t)=kalmanf(s(t-1)); % perform a Kalman filter iteration
detP(t)=s(t).detP; % keep track of "net" uncertainty
end

figure;
plot(tru)
title(['Falling object k/m = ' num2str(k/m)]);
legend('x','v'); 

function s = kalmanf(s)

% State vector
s.x = s.A*s.x + s.B*s.u;
s.P = s.A * s.P * s.A' + s.Q;

% Compute Kalman gain factor:
K = s.P * s.H' * inv(s.H * s.P * s.H' + s.R);

% Correction based on observation:
s.x = s.x + K*(s.z - s.H *s.x);
s.P = s.P - K*s.H*s.P;
end