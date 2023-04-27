% Transform 2D points by applying a 3x3 matrix to it (last row is padded to ignore third dimenison)
function TformPts = TransformPoints(StartCoordinates, TransformMatrix)
    TformPts = StartCoordinates*TransformMatrix;
end