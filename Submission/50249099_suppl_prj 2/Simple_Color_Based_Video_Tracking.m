%code
clear all; 
close all; 
clc ;
%xyloObj = VideoReader('traffic.mj2');
xyloObj = VideoReader('car.mp4');
n = xyloObj.NumberOfFrames;
vidFrames = read(xyloObj);
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;
mov(1:n) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);
for k = 1 : n
    video(k).cdata = read(xyloObj, k);
end
temp = zeros(size(video(1).cdata));
[M,N] = size(temp(:,:,1));
for i = 1:10 
    temp = double(video(i).cdata) + temp;
end
imbkg = temp/10;
centroidx = zeros(n,1);
centroidy = zeros(n,1);
th = 38;
for i=1:n
  imshow(video(i).cdata);
  hold on
  imcurrent = double(video(i).cdata);
  diffimg = zeros(M,N); 
  diffimg = (abs(imcurrent(:,:,1)-imbkg(:,:,1))>th) ...
      | (abs(imcurrent(:,:,2)-imbkg(:,:,2))>th) ...
      | (abs(imcurrent(:,:,3)-imbkg(:,:,3))>th); 
  labelimg = bwlabel(diffimg,4);
  markimg = regionprops(labelimg,['basic']);
  [MM,NN] = size(markimg);
  for nn = 1:MM
      if markimg(nn).Area > markimg(1).Area
          tmp = markimg(1);
          markimg(1)= markimg(nn);
          markimg(nn)= tmp;
      end
  end 
  bb = markimg(1).BoundingBox;
  xcorner = bb(1);
  ycorner = bb(2);
  xwidth = bb(3);
  ywidth = bb(4);
  cc = markimg(1).Centroid;
  centroidx(i)= cc(1);
  centroidy(i)= cc(2); 
  hold on
  rectangle('Position',[xcorner ycorner xwidth ywidth],'EdgeColor','b');
  hold on
  plot(centroidx(i),centroidy(i), 'bx'); 
   drawnow;
end
