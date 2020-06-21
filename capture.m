function [a, fname] = capture(x)
%x = videoInput object
%Captures and returns an image for further Processing 
    set(x, 'ReturnedColorSpace', 'RGB'); 
    img = getsnapshot(x);
    fname = 'image';
    imwrite(img, fname, 'png');
    a = imread(fname);
    a = imresize(a, 2);
end

