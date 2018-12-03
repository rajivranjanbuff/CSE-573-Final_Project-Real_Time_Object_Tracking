Readme.txt

Important Information about the project:

It’s a one person project and has not been done in a group of two.
All the details regarding the algorithms implemented is in the project report file.
The codes are sent as an additional attachment .

The brief summary of the project goes like this to effectively detect a moving object and track it. For tracking the object Kalman Filter has been be used. For detecting the objects, we will be using various algorithms like background subtraction, edge detection using sober filter etc. has been used. These algorithms have also been analyzed and a comparison has been presented.

The tracking happens for a total of 3 videos and these form the dataset for this project.
1)  traffic.mj2 : default
2)  car.mp4 : The video was taken from YouTube. Many cars are running on a road.
3)  Meet_Crowd.mp4 :Source is CAVIAR test case scenario. 4 people walk.


Here are the various code files name and their description:

1) Basic_Operation.m :  Contains the implementation of basic image processing steps done as part of pre processing.

2) Object_Detection_Sobel.m : Object detection implementation using Sobel filter.

3) Object_Tracking_Adjacent_Frame_Subtraction.m : Object detection implementation using Adjacent frame subtraction method.

4)Simple_Color_Based_Video_Tracking.m : Object tracking of pre stored video using the simple color based technique.

5)Simple_Real_Time_Color_Based_Video_Tracking.m :  Object tracking of video using the simple color based technique. The webcam of the system on which it runs will start and will do simple color based video tracking for the images it captures. My code runs for MacBook and similarly the code will have to be modified if it runs on a windows system.
Also it requires a lot of buffer space to run, so please close off all the other processes on the system.

6)Kalman_Filter_single_object_tracking.m : Single object tracking using Kalman filter 

7) Kalman_Filter_Multiple_Object_Tracking.m : Multiple object tracking using Kalman filter

8)Kalman_filter_single_object_real_time_webcam.m :Single object tracking on a real time basis using webcam of the system on which it runs will start and will do video tracking for the images it captures using kalman filter. My code runs for MacBook and similarly the code will have to be modified if it runs on a windows system.
Also it requires a lot of buffer space to run, so please close off all the other processes on the system.

Note: please enter ’s’ when asked for a choice to start the webcam.


9)Kalman_filter_multiple_object_realtime_webcam.m : Multiple object tracking on a real time basis using webcam of the system on which it runs will start and will do video tracking for the images it captures using kalman filter. My code runs for MacBook and similarly the code will have to be modified if it runs on a windows system.
Also it requires a lot of buffer space to run, so please close off all the other processes on the system.

Note: please enter ’s’ when asked for a choice to start the webcam.

Also make a note of the fact that the two extra video file other than the traffic video file namely car.mp4 and meet_crowd.mp4 are being provided. They can be used to check the working of the implementation.