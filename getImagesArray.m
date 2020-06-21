function [images] = getImagesArray(delay, imageCount)
    cam = webcam(1);
    images = {};
    for i=1:imageCount
        image= snapshot(cam); 
        images{i} = image;
        pause(delay);
    end
    clear('cam')
    clear('image')
end