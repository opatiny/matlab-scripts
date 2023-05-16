% Transform 2D points by applying a 3x3 matrix to it (last row is padded to ignore third dimenison)
function result = TransformPointParams(params, points)
xOffset = params(1);
yOffset = params(2);
angle = params(3);
scale = params(4);

matrix = [cos(angle)*scale, -sin(angle)*scale, xOffset;
                    sin(angle)*scale, cos(angle)*scale, yOffset;
                    0 0 1];
                
    result = matrix* points;
end