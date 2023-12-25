function MovingForward = moveForward(power, direction)
if power >= 0.0083
if strcmp(direction, 'forward')
    MovingForward = 'Already Going Forward';
else
    MovingForward = 'forward';
end
else
    MovingForward = 'low power';
end
end