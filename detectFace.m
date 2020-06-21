function [outputImage, bbox] = detectFace(a, fname)
%Takes an input image and detects if a  face is present here
% Returns image with box & a bbox with image info
    detector = vision.CascadeObjectDetector;
    detector.MergeThreshold = 7;
    bbox = step(detector, a);
    out = insertObjectAnnotation(a, 'rectangle', bbox, 'detection' );
    imwrite(out, fname, 'png');
    outputImage = imread(fname, 'png');
end

