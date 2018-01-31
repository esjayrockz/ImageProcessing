a = imread('cameraman.png');
a1 = 255 - a;
imshow(a1);
c1 = imread('corrupt1.png');
df1 = sum(sum(abs(double(a1) - double(c1))));

a2 = 100 + a;
figure;
imshow(a2);
c2 = imread('corrupt2.png');
df2 = sum(sum(abs(double(a2) - double(c2))));

min1 = min(a(:));
max1 = max(a(:));
g = a - min1;
g1 = (255/(max1 - min1)) * g;
a3 = round(g1);
figure;
imshow(a3);
c3 = imread('corrupt3.png');
df3 = sum(sum(abs(double(a3) - double(c3))));


a4 = (255 * log(double(a)+1))/log(256);
a4 = uint8(a4);
figure;
imshow(a4);
c4 = imread('corrupt4.png');
df4 = sum(sum(abs(double(a4) - double(c4))));


