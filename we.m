vid = videoinput('macvideo',1,'YCbCr422_1280x720');
set(vid,'FramesPerTrigger',Inf);
vid.FrameGrabInterval = 5;
set(vid, 'ReturnedColorspace', 'rgb');
figure; 
start(vid)
while(vid.FramesAcquired<=1) 
    data1 = getdata(vid,1);
end
while(vid.FramesAcquired<=100) 
    data2 = getdata(vid,1);
    diff_im = imsubtract(data1,data2);
    diff_im = rgb2gray(diff_im);
    diff_im = medfilt2(diff_im, [8 8]);
    level= graythresh(data2);
    diff_im = im2bw(diff_im,level);
    bw = bwlabel(diff_im, 8);
    stats = regionprops(bw, 'BoundingBox');
    imshow(data2);
    hold on
        for object = 1:length(stats)
        bb = stats(object).BoundingBox;
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
        end
     hold off
     flushdata(vid);
   
end;
stop(vid);
delete(vid);
