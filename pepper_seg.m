a = imread('peppers.jpg');
imshow(a);
g = rgb2hsv(a);
hueIm = g(:,:,1);
meanHue =[];

for p = 1:4
    [x,y] = ginput(5);
    hueV = [];
    
    for i = 1:5
        hueV(i) = hueIm(floor(y(i)),floor(x(i)));
    end
    
    meanHue(p) = mean(hueV);
    
end

sortedMeanHue = sort(meanHue);
T1 = mean([sortedMeanHue(1),sortedMeanHue(2)]);
T2 = mean([sortedMeanHue(2),sortedMeanHue(3)]);
T3 = mean([sortedMeanHue(3),sortedMeanHue(4)]);

labelIm = zeros(size(a,1),size(a,2),'uint8');
for r = 1:size(a,1)
    for c = 1:size(a,2)
        oneHue = hueIm(r,c);
        if(oneHue >= 0 & oneHue <T1)
            labelIm(r,c) = 1;
        elseif(oneHue >= T1 & oneHue <T2)
            labelIm(r,c) = 2;
        elseif(oneHue >= T2 & oneHue <T3)
            labelIm(r,c) = 3;
        elseif(oneHue >= T3)
            labelIm(r,c) = 4;
        end
    end
end
           

r1 = [];
r2 = [];
r3 = [];
g1 = [];
g2 = [];
g3 = [];
y1 = [];
y2 = [];
y3 = [];
o1 = [];
o2 = [];
o3 = [];
for r = 1:size(a,1)
    for c = 1:size(a,2)
    
        if(labelIm(r,c) == 1)
            r1 =[r1,a(r,c,1)];
            r2 = [r2,a(r,c,2)];
            r3 = [r3,a(r,c,3)];
        
        elseif(labelIm(r,c) == 2)
            g1 =[g1,a(r,c,1)];
            g2 = [g2,a(r,c,2)];
            g3 = [g3,a(r,c,3)];
         
        elseif(labelIm(r,c) == 3)
            y1 =[y1,a(r,c,1)];
            y2 = [y2,a(r,c,2)];
            y3 = [y3,a(r,c,3)];
         
        elseif(labelIm(r,c) == 4)
            o1 =[o1,a(r,c,1)];
            o2 = [o2,a(r,c,2)];
            o3 = [o3,a(r,c,3)];
        end
       
    end
end

        
r1mean = mean(r1);
r2mean = mean(r2);
r3mean = mean(r3);
g1mean = mean(g1);
g2mean = mean(g2);
g3mean = mean(g3);
y1mean = mean(y1);
y2mean = mean(y2);
y3mean = mean(y3);
o1mean = mean(o1);
o2mean = mean(o2);
o3mean = mean(o3);
copy = a;

for r = 1:size(a,1)
    for c = 1:size(a,2)
    
        if(labelIm(r,c) == 1)
            copy(r,c,1) = r1mean;
            copy(r,c,2) = r2mean;
            copy(r,c,3) = r3mean;
        
        elseif(labelIm(r,c) == 2)
            copy(r,c,1) = g1mean;
            copy(r,c,2) = g2mean;
            copy(r,c,3) = g3mean;
         
        elseif(labelIm(r,c) == 3)
            copy(r,c,1) = y1mean;
            copy(r,c,2) = y2mean;
            copy(r,c,3) = y3mean;
         
        elseif(labelIm(r,c) == 4)
           copy(r,c,1) = o1mean;
            copy(r,c,2) = o2mean;
            copy(r,c,3) = o3mean;
        end
      
    end
end
imshow(copy);