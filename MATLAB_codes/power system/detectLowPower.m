function CheckingVoltage = detectLowPower(percent)
if percent < 26
    CheckingVoltage = 'Battery Low';
else
    CheckingVoltage = 'okay';
end