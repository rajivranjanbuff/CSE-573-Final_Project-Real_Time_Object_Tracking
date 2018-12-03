%code
vid = videoinput('macvideo',1,'YCbCr422_1280x720'); 
 
 
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb')
 
 
centroidx = zeros(250,1);
centroidy = zeros(250,1);
predicted = zeros(250,4);
actual = zeros(250,4);
 
% % Initialize the Kalman filter parameters
% R - measurement noise,
% H - transform from measure to state
% Q - system noise,
% P - the status covarince matrix
% A - state transform matrix
 
R=[[0.56,0.0090]',[0.0045,0.0455]'];
H=[[1,0]',[0,1]',[0,0]',[0,0]'];
Q=0.01*eye(4);
P = 100*eye(4);
dt=50;
A=[[1,0,0,0]',[0,1,0,0]',[dt,0,1,0]',[0,dt,0,1]'];
 
kfinit = 0;
th = 38;
 
 
ch1=input('enter choice','s');
if strcmp(ch1,'c')
 start(vid)
 imbkg = getsnapshot(vid);
 stop(vid)
end
start(vid)
 
while(vid.FramesAcquired<=500)
    i=2;
   
    
    imcurrent = getsnapshot(vid);
     imshow(imcurrent);
    hold on
     diffimg = (abs(imcurrent(:,:,1)-imbkg(:,:,1))>th) ...
      | (abs(imcurrent(:,:,2)-imbkg(:,:,2))>th) ...
      | (abs(imcurrent(:,:,3)-imbkg(:,:,3))>th);
  
   labelimg = bwlabel(diffimg,4);
  markimg = regionprops(labelimg,['basic']);
  [MM,NN] = size(markimg);
  
 for object = 1:length(markimg)
        if markimg(object).Area >1000
  
   
  bb = markimg(object).BoundingBox;
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
  rectangle('Position',[(actual(i,1)-kalmanx) (actual(i,2)-kalmany) xwidth ywidth],'EdgeColor','r','LineWidth',1.5);
  hold on
  plot(actual(i,1),actual(i,2), 'rx','LineWidth',1.5);
  drawnow;
  i=i+1;
        end
 end
  flushdata(vid);
end
stop(vid);
 
flushdata(vid);
delete(vid);
