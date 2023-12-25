function usage = PowerUsage(power)
% Simulate battery discharge
 if power >= 0.0083
    power_consumed = 0.0083; 
    usage = power - power_consumed;
 else
     usage = power;

end