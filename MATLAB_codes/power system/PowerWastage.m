function wastage = PowerWastage(power)
if power >= 0.0042
    powerWasting = 0.0042;
    wastage = power - powerWasting;
end