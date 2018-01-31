clear;
f = false(100,100);
f(25,25:75) = true;
f(75,25:75) = true;
f(25:75,25) = true;
f(25:75,75) = true;
d = ceil(sqrt(100*100 + 100*100));
aa = zeros((2*d)+1,180);
imshow(f);

for r = 1:100
    for c = 1:100
        if(f(r,c) == 1)
            for th = 0:179
              v = round(r* sind(th)) + round(c * cosd(th));
              aa(v+d+1,th+1) = aa(v+d+1,th+1)+1;  
            end
        end
    end
end

figure;
imshow(aa,[]);
colorbar;
max1 = max(aa(:));
[R,C]=find(aa==max1);
Row = R-d-1;
Theta = C-1;

