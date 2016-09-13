%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   Fredrik Eilertsen  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%       Pedometer      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Application properties
port       = 31415;      % Standard port(31415)
password   = 'password';   % Password for iOS app


% Sensor properties:
accelerationSensor = 1;    %0 = off, 1 = on;
orientationSensor  = 0;
angularVelocity    = 0;
magneticSensor     = 0;
positionSensor     = 0;
sampleRate         = 'medium';  % low=1hz, medium=10hz, high=100hz



%%%%% Script starting here. %%%%%%%%%%%%%%%%%%%%%%%%%
connector('on', 'password', password, 'port', port);
m = mobiledev;

m.AccelerationSensorEnabled     = accelerationSensor;
m.AngularVelocitySensorEnabled	= angularVelocity;
m.MagneticSensorEnabled         = magneticSensor;
m.OrientationSensorEnabled      = orientationSensor;
m.PositionSensorEnabled         = positionSensor;
m.SampleRate                    = sampleRate;


% Start logging
m.Logging = 1;

% Log data, 15 seconds
disp('Walk Around...')
pause(15)

% Disable sensor
m.AccelerationSensorEnabled = 0;
m.Logging = 0;


[logdata, timestamp] = accellog(m);

% Change vectors to scalars
% Removes dependency on Orientation
x = logdata(:,1);
y = logdata(:,2);
z = logdata(:,3);

% Fucntion of three variables
magnitude = sqrt(sum(x.*x + y.*y + z.*z, 2));


% Subtracting the mean removes constants like gravity.
magnitudeNoG = magnitude - mean(magnitude);


plot(timestamp, magnitudeNoG);

% Standard deviation
minPeakHeight = std(magnitudeNoG);

% Use findpeaks from signal processing toolbox
[pks, locs] = findpeaks(magnitudeNoG, 'MINPEAKHEIGHT', minPeakHeight);


hold on;
plot(timestamp(locs), pks, 'r', 'Marker', 'o', 'LineStyle', 'none');
title('Counting Steps');
xlabel('Time (s)');
ylabel('Acceleration Magnitude, No Gravity (m/s^2)');
hold off;


% Count numer of elements in array, steps
disp(numel(pks))