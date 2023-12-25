function Power_Reduction = PowerReduction(power)
if power > 5
    randomNumber = randi([1, 5]);
    Power_Reduction = power - randomNumber;
else
    Power_Reduction = power;
end
end