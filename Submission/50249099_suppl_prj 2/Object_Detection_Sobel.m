%code
clc;
close all;
clear all;
xyloObj = VideoReader('traffic.mj2');
vidFrames = read(xyloObj);
nFrames = xyloObj.NumberOfFrames;
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;
mov(1:nFrames) = ...
struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
'colormap', []);

for k = 1 : nFrames
mov(k).cdata = read(xyloObj, k);
end

hf = figure;
set(hf, 'position', [600 300 vidWidth vidHeight])
movie(hf, mov, 1, xyloObj.FrameRate);

for k = nFrames:-1:1
g(:, :, k) = rgb2gray(vidFrames(:, :, :, k));
end

for k = nFrames-1:-1:1
d(:, :, k) = imabsdiff(g(:, :, k), g(:, :, k+1));
end

for k = nFrames-2:-1:1
bg(:, :, k) = edge(d(:, :, k),'sobel','both');
end

for k = nFrames-2:-1:1
dg(:, :, k) = medfilt2(bg(:, :, k),[1,1]);
end
