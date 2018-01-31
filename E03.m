a = imread('mountain.png');
meanMountainColumn = mean(a);
m = min(meanMountainColumn);
darkestCol = int16(find(meanMountainColumn == m));
flipimage = a(end:-1:1,:);
imshow(flipimage);
halfimage = a(1:2:end,1:2:end);
imshow(halfimage);
h = zeros(256, 1);
for i=1:numel(a) 
Z=a(i); 
h(Z+1)=h(Z+1)+1;
end 
myHist = int16(h);
plot(myHist);