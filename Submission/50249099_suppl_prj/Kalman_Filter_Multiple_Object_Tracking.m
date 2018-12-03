%code
clear all; 
close all; 
clc ;
xyloObj = VideoReader('traffic.mj2');
%xyloObj = VideoReader('car.mp4');
%xyloObj = VideoReader('Meet_Crowd.mp4');

n = xyloObj.NumberOfFrames;
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;
 
for k = 1 : n
    video(k).cdata = read(xyloObj, k);
end
    imbkg = zeros(size(video(1).cdata));
    [M,N] = size(imbkg(:,:,1));
    imbkg =(video(1).cdata);
    centroidx = zeros(n,1);
    centroidy = zeros(n,1);
    predicted = zeros(n,4);
    actual = zeros(n,4); 
    R=[[0.2845,0.0045]',[0.0045,0.0455]'];
    H=[[1,0]',[0,1]',[0,0]',[0,0]'];
    Q=0.01*eye(4);
    P = 100*eye(4);
    dt=50;
    A=[[1,0,0,0]',[0,1,0,0]',[dt,0,1,0]',[0,dt,0,1]']; 
    kfinit = 0;
    for i=2:n
      imshow(video(i).cdata);
      hold on
      imcurrent = (video(i).cdata);
      diffimg = zeros(M,N); 
      diffimg = imabsdiff(imcurrent,imbkg);
      diffimg = rgb2gray(diffimg);
      diffimg = medfilt2(diffimg, [8 8]);
      level= graythresh(diffimg);
      diffimg = im2bw(diffimg,level);
      labelimg = bwlabel(diffimg,4);
     markimg = regionprops(labelimg,['basic']);
     [MM,NN] = size(markimg);
     
    for object = 1:length(markimg)
        if markimg(object).Area >150
      bb = markimg(object).BoundingBox;
      xcorner = bb(1);
      ycorner = bb(2);
      xwidth = bb(3);
      ywidth = bb(4);
      cc = markimg(object).Centroid;
      centroidx(i)= cc(1);
      centroidy(i)= cc(2); 
      hold on
      rectangle('Position',[xcorner ycorner xwidth ywidth],'EdgeColor','b');
      hold on
      plot(centroidx(i),centroidy(i), 'bx'); 
      kalmanx = centroidx(i)- xcorner;
      kalmany = centroidy(i)- ycorner; 
      if kfinit == 0
          predicted =[centroidx(i),centroidy(i),0,0]' ;
      else
          predicted = A*actual(i-1,:)';
      end
      kfinit = 1; 
      Ppre = A*P*A' + Q;
      K = Ppre*H'/(H*Ppre*H'+R);
      actual(i,:) = (predicted + K*([centroidx(i),centroidy(i)]' - H*predicted))';
      P = (eye(4)-K*H)*Ppre;
      hold on
      rectangle('Position',[(actual(i,1)-kalmanx) (actual(i,2)-kalmany) xwidth ywidth], 'EdgeColor', 'r','LineWidth',1.5);
      hold on
      plot(actual(i,1),actual(i,2), 'rx','LineWidth',1.5);
        end
      drawnow;
        
    end
    end
