clear;
a = imread('rice.png');
g = imbinarize(a);
imshow(g);
l = bwlabel(g);
imshow(l,[]);
colormap jet;
colormap jet;imshow(l,[]);
colormap jet;imagesc(l);
stats = regionprops(l,'area');
area1 = find([stats.Area]>50);

m = ismember(l,area1);
k1  = ones(3,3);
f = imerode(m,k1);
f1 = m - f;
imshow(f1);