clear;
a = imread('rice.png');
f = imbinarize(a);

k1  = ones(3,3);
k2 = ones(7,7);

[R,C] = size(f);
m1 = zeros(R,C,'logical');
m2 = zeros(R,C,'logical');

for r = 2:R-1
    for c = 2:C-1
        im = f(r-1:r+1,c-1:c+1);
        t1 = im & k1;
        
        if(all(t1))
            m1(r,c) = 1;
        else
            m1(r,c) = 0;
        end
        
        if(any(t1(:)))
            m2(r,c) = 1;
        else
            m2(r,c) = 0;
        end
        
    end
end
figure;
imshow(m1);
figure;
imshow(m2);
m3 = zeros(R,C,'logical');
m4 = zeros(R,C,'logical');

for r = 4:R-3
    for c = 4:C-3
        im = f(r-3:r+3,c-3:c+3);
        t1 = im & k2;
        
        if(all(t1))
            m3(r,c) = 1;
        else
            m3(r,c) = 0;
        end
        
        if(any(t1(:)))
            m4(r,c) = 1;
        else
            m4(r,c) = 0;
        end
        
    end
end
figure;
imshow(m3);
figure;
imshow(m4);