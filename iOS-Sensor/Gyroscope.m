%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   Fredrik Eilertsen  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%       Gyroscope      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Checks if mobile is facing up or down


% Application properties
port       = 31415;      % Standard port(31415)
password   = 'password';   % Password for iOS app


% Sensor properties:
accelerationSensor = 0;    %0 = off, 1 = on;
orientationSensor  = 1;
angularVelocity    = 0;
magneticSensor     = 0;
positionSensor     = 0;
sampleRate         = 'Low';  %high, medium, low



%%%%% Script starting here. %%%%%%%%%%%%%%%%%%%%%%%%%
clear m;

connector on
m = mobiledev;

m.AccelerationSensorEnabled     = accelerationSensor;
m.AngularVelocitySensorEnabled	= angularVelocity;
m.MagneticSensorEnabled         = magneticSensor;
m.OrientationSensorEnabled      = orientationSensor;
m.PositionSensorEnabled         = positionSensor;
m.SampleRate                    = sampleRate;

m.Logging = 1;


% Run a loop, checking for orientation
for k = 1:250
    
    % Acquire 1 second of data
    pause(0.3)
    [o,t] = orientlog(m);
    discardlogs(m)
    
    %~ not operator
    
    if ~isempty(o)   
        
        % Check Orientation
        z = mean(o(:,3));
        
        % Check Z-axis to determine which way phone is facing
        if (z > 75 && z < 95) || (z < -75 && z > - 95)
            disp('Side')
        elseif z > -100 && z < 100
            disp('Up')
        else
            disp('Down')
        end   
     end
 end


% Clean up
connector off
clear m

