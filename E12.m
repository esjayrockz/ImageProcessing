clear;
a = imread('rice.png');
f = imbinarize(a);
f2 = zeros(size(f,1)+1,size(f,1)+1);
for i = 1:size(f,1)
    for j = 1:size(f,2)
        f2(i+1,j+1) = f(i,j);
    end
end


%First pass

f3 = f2;
l=1;
for r =2:size(f2,1)
    for c = 2:size(f2,2)
       if(f2(r,c)==1)
        if(f2(r-1,c)~=1 && f2(r,c-1)~=1)
            f3(r,c) = l;
            l = l+1;
        elseif(f2(r-1,c)==1 && f2(r,c-1)~=1)
            f3(r,c) = f3(r-1,c);
        elseif(f2(r-1,c)~=1 && f2(r,c-1)==1)
            f3(r,c) = f3(r,c-1);
        elseif(f2(r-1,c)==1 && f2(r,c-1)==1)
            if(f3(r-1,c)==f3(r,c-1))
            f3(r,c) = f3(r-1,c);
            elseif(f3(r-1,c)~=f3(r,c-1))
            f3(r,c) = min(f3(r-1,c),f3(r,c-1));
            %equiv(max(f3(r-1,c),f3(r,c-1))) = min(f3(r-1,c),f3(r,c-1));
            %equiv(min(f3(r-1,c),f3(r,c-1))) = min(f3(r-1,c),f3(r,c-1));
            end
        end
       end
        
    end
end


%Creating equivalent table

mx = max(f3(:));

equiv = zeros(mx,1);

for r =2:size(f2,1)
    for c = 2:size(f2,2)
       if(f2(r,c)==1)
            if(f2(r-1,c)==1 && f2(r,c-1)==1)
                if(f3(r-1,c)~=f3(r,c-1))
                    equiv(max(f3(r-1,c),f3(r,c-1))) = min(f3(r-1,c),f3(r,c-1));
                    equiv(min(f3(r-1,c),f3(r,c-1))) = min(f3(r-1,c),f3(r,c-1));
                end
            end
       end
        
    end
end



%Equivalent table values assigned with the minimum value 

for i = 1:size(equiv,1)
    mn = equiv(i);
    for j = equiv(i):-1:1
        if(equiv(j)==j && (equiv(j)==mn || j==mn))
            break;
        elseif(equiv(j)<j && (equiv(j)==mn || j==mn))
          mn = equiv(j);
        end
            
    end
    equiv(i) = mn;
end

%Assigning the image back with those equivalent values (2nd pass)

for r =2:size(f2,1)
    for c = 2:size(f2,2)
        if(f2(r,c)==1)
            f3(r,c) = equiv(f3(r,c));          
        end
    end
end


%Counting the number of pixels for each equivalent table value

max1 = max(equiv);
pxls = zeros(max1,1);

for r =2:size(f3,1)
    for c = 2:size(f3,2)
    if(f3(r,c) ~= 0)
    pxls(f3(r,c)) = pxls(f3(r,c))+1;
    end
    end
end



%Counting the number of pixels greater than T pixels

N = 0; cm = [];
for i =1:size(pxls,1)
    
    if(pxls(i) > 78)
    N = N+1; 
    
    end
    
end

%Assigning color map values to vector

cmap = rand(N+1,3);

c=1;
for i = 1:size(pxls,1)
    if(pxls(i) > 78)
    cm(i,1) = cmap(c+1,1);
    cm(i,2) = cmap(c+1,2);
    cm(i,3) = cmap(c+1,3);
    c=c+1;
    else
    cm(i,1) = cmap(1,1);
    cm(i,2) = cmap(1,2);
    cm(i,3) = cmap(1,3);
    end
    
end

%Assigning vector color values to image

f4 = zeros(size(f3,1),size(f3,2),3);
for r =2:size(f3,1)
    for c = 2:size(f3,2)
    if(f3(r,c) ~= 0)
    f4(r,c,1) = cm(f3(r,c),1);
    f4(r,c,2) = cm(f3(r,c),2);
    f4(r,c,3) = cm(f3(r,c),3);
    else
    f4(r,c,1) = cm(1,1);
    f4(r,c,2) = cm(1,2);
    f4(r,c,3) = cm(1,3);
    end
    
    end
end

imshow(f4);

