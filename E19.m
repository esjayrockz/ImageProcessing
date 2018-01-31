f = imread ('input.png');
[R,C] = size(f);
regionIm = ones(R,C,'int16');
processList = [1];
while(~isempty(processList))
    regionNum = processList(1);
    mx = max(processList);
    processList = processList(2:end);
    regionPix = f(regionIm == regionNum);
    stdOfRegion = std2(regionPix);
    T = 10;
    if(stdOfRegion>T)
        [R1,C1] = find(regionIm == regionNum);
        minR = min(R1);
        minC = min(C1);
        maxR = max(R1);
        maxC = max(C1);
        bordR = floor((maxR+minR)/2);
        bordC = floor((maxC+minC)/2);
        regionIm(minR:bordR,minC:bordC) = mx+1;
        regionIm(minR:bordR,bordC+1:maxC) = mx+2;
        regionIm(bordR+1:maxR,minC:bordC)= mx+3;
        regionIm(bordR+1:maxR,bordC+1:maxC)= mx+4;
        processList(end+1) = mx+1;
        processList(end+1) = mx+2;
        processList(end+1) = mx+3;
        processList(end+1) = mx+4;
        
        
    end
    
end


g = zeros(size(f), 'uint8');
r0 = min(regionIm(:));
r1 = max(regionIm(:));
for r = r0:r1
    t = regionIm == r;
     
    t2 = f(t);
    if ( numel(t2) > 0)
        g(t) = uint8(mean(t2));
    end
end

imshow ( g );

title('input - T = 10');