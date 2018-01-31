a = imread('input1.png');
variance = 0;
for T = 0:255
    g = a >= T;
    o2 = sum(g(:));
    o1 = numel(a) - o2;
    mu2 = mean(a(g));
    mu1 = mean(a(~g));
    icv = o1*o2*(mu1 - mu2)*(mu1-mu2);
    var(T+1) = icv;
    if icv > variance 
        variance = icv;
        Th = T;
        otsu = g;
    end
end
plot(var);
figure;
title('1st Image - Output from Otsu');
imshow(otsu);


a2 = imread('input2.png');

%Output from Otsu for Comparison of 2nd Image
variance = 0;
for T = 0:255
    g1 = a2 >= T;
    o2 = sum(g1(:));
    o1 = numel(a2) - o2;
    mu2 = mean(a2(g1));
    mu1 = mean(a2(~g1));
    icv = o1*o2*(mu1 - mu2)*(mu1-mu2);
    var(T+1) = icv;
    if icv > variance 
        variance = icv;
        Th = T;
        otsu = g1;
    end
end
figure;
title('2nd Image - Output from Otsu');
imshow(otsu);

s = 24;sf = s/2; sc = (s/2)+1;
f2 = zeros(size(a2,1)+s,size(a2,2)+s);

%Create a larger image than input with zeros on the border
for i = 1:size(a2,1)
    for j = 1:size(a2,2)
f2(i+sf,j+sf)=a2(i,j);
    end
end


%Mean Image
for i = sc:size(f2,1)-sf
    fprintf("%d\n",i);
    for j = sc:size(f2,2)-sf
    
        mn = mean(mean(f2(i-sf:i+sf,j-sf:j+sf)));
        mn2(i-sf,j-sf) = mn;
        
    end
   end
mn2 = uint8(mn2);
figure;
title('Mean image');
imshow(mn2);


%For k =  1.0
k = 1.0;
for i = sc:size(f2,1)-sf
    for j = sc:size(f2,2)-sf
    
        mn = mean(mean(f2(i-sf:i+sf,j-sf:j+sf)));
        thr = k *mn;
        h(i-sf,j-sf) = a2(i-sf,j-sf) >= thr;
        
    end
end
figure;
imshow(h);

%For k =  0.7
k = 0.7;
for i = sc:size(f2,1)-sf
    for j = sc:size(f2,2)-sf
    
        mn = mean(mean(f2(i-sf:i+sf,j-sf:j+sf)));
        thr = k *mn;
        h(i-sf,j-sf) = a2(i-sf,j-sf) >= thr;
        
    end
end
figure;
imshow(h);


%For k =  1.3
k = 1.3;
for i = sc:size(f2,1)-sf
    fprintf("%d\n",i);
    for j = sc:size(f2,2)-sf
    
        mn = mean(mean(f2(i-sf:i+sf,j-sf:j+sf)));
        thr = k *mn;
        h(i-sf,j-sf) = a2(i-sf,j-sf) >= thr;
        
    end
end
figure;
imshow(h);

   