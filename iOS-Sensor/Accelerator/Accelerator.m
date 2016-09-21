%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   Fredrik Eilertsen  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%     Acceleration     %%%
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
sampleRate         = 'Medium';           % Sampling frequency (HZ)



%%%%% Script starting here. %%%%%%%%%%%%%%%%%%%%%%%%%
clear m;
connector off;


connector('on', 'password', password, 'port', port);



m = mobiledev;

m.AccelerationSensorEnabled     = accelerationSensor;
m.AngularVelocitySensorEnabled	= angularVelocity;
m.MagneticSensorEnabled         = magneticSensor;
m.OrientationSensorEnabled      = orientationSensor;
m.PositionSensorEnabled         = positionSensor;
m.SampleRate                    = sampleRate;

m.Logging = 1;

for



[a, t] = accellog(m);

plot(t, a);

end;

clear m
connector off

