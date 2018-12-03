%code
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

background = imdilate(g, ones(1, 1, 5));
imtool(background(:,:,1))

d = imabsdiff(g, background);
thresh = graythresh(d);
bw = (d >= thresh * 255);
