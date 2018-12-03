vid = videoinput('macvideo',1,'YCbCr422_1280x720');

set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb');

vid.FrameGrabInterval=5;


%while(vid.FramesAcquired<=1000)
ch1=input('enter choice','s');
if strcmp(ch1,'c')
    start(vid)
    data1=getsnapshot(vid);
    stop(vid)
    g1=rgb2gray(data1);
       
ch2=input('enter choice','s');
if strcmp(ch2,'c')
        start(vid)
        data2=getsnapshot(vid);
        stop(vid)
        g2=rgb2gray(data2);
        objdet1=imsubtract(g2,g1);
        binobj=im2bw(objdet1,0.18);
        imshow(binobj)
end
end
