clear;
f = imread('valve.png');
g = rgb2gray(f);
a = double(g);
k1 = 1.0/8.0 * [1 0 -1; 2 0 -2; 1 0 -1];
gx = double(imfilter(a,k1));
imshow(gx,[]);

k2 = 1.0/8.0 * [1 2 1; 0 0 0; -1 -2 -1];
gy = imfilter(a,k2);
imshow(gy,[]);

gm = sqrt(gx .^ 2 + gy .^ 2);
imshow(gm,[]);

gd = atan2(gy,gx) * (180/pi);
imshow(gd,[]); 
colormap jet;

x = find(gd < 0);
gd(x) = gd(x) + 180;
x = find(gd==180);
gd(x) = 0.0;
gd = gd - 22.5;


glocal = gm;
for r = 2:size(gm,1)-1
    for c = 2:size(gm,2)-1
        if(-180/8 <= gd(r,c) && gd(r,c)<180/8) && (gm(r,c) <gm(r-1,c) || gm(r,c) <gm(r+1,c))
            glocal(r,c) = 0;
            elseif(180/8 <= gd(r,c) && gd(r,c)<(3*180)/8) && (gm(r,c) <gm(r-1,c-1) || gm(r,c) <gm(r+1,c+1))
            glocal(r,c) = 0;
            elseif((3*180)/8 <= gd(r,c) && gd(r,c)<(5*180)/8) && (gm(r,c) <gm(r,c-1) || gm(r,c) <gm(r,c+1))
            glocal(r,c) = 0;
            elseif((5*180)/8 <= gd(r,c) && gd(r,c)<(7*180)/8) && (gm(r,c) <gm(r-1,c+1) || gm(r,c) <gm(r+1,c-1))
            glocal(r,c) = 0;
        end
    end
end
imshow(glocal, [])

        