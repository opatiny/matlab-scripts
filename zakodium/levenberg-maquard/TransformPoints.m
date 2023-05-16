% Transform 2D points by applying a 3x3 matrix to it (last row is padded to ignore third dimenison)
function TformPts = TransformPoints(matrix, points)
    TformPts = matrix*points;
end