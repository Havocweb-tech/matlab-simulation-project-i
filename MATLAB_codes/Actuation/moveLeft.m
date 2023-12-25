function MovingLeft = moveLeft(power, direction)
if power > 0.0083
if strcmp(direction, 'left')
    MovingLeft = 'Already Going Left';
else
    MovingLeft = 'left';
end
else
    MovingLeft = 'low power';
end
end