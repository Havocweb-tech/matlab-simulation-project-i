function battery_percent = CalcBatteryPercent(power)
division = power / 120;
untouchablepercent = division * 100;
battery_percent = round(untouchablepercent);
end