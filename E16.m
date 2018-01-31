clear;
a = imread('doc.jpg');
f = rgb2gray(a);
f = imresize(f, 0.9);
g = edge(f,'canny');
imshow(g);
[l,w] = size(g);

d = ceil(sqrt((l*l) + (w*w)));
aa = zeros((2*d)+1,180);

for r = 1:l
    for c = 1:w
        if(g(r,c) == 1)
            for th = 0:179
              v = ceil((c* sind(th))+ (r * cosd(th)));
              aa(v+d+1,th+1) = aa(v+d+1,th+1)+1;  
            end
        end
    end
end

aa_sort1 = sort(aa(:),'descend');
aa_sort1 = aa_sort1(1:4);
colorIm = imresize(a, 0.9);
for i=1:4
[R,C]=find(aa==aa_sort1(i));
rhoA = R-d-1;
thA = C-1;
x0=1;
y0=round((rhoA-(x0*sind(thA)))/cosd(thA));
x1=size(g,1);
y1=round((rhoA-(x1*sind(thA)))/cosd(thA));
colorIm = insertShape(colorIm, 'line', [x0, y0, x1, y1]);
end

figure;
imshow(aa(1:10:end,:),[]);
colormap jet;
colormap jet;imshow(aa(1:10:end,:),[]);
colormap jet;imagesc(aa(1:10:end,:));
figure;
imshow(colorIm);

aaCopy = zeros(size(aa,1),size(aa,2));
windowSize = 17;

for i = 1:size(aa,1)
    for j = 1:size(aa,2)
        rowMin = max(1,i-windowSize);
        rowMax = min(size(aa,1),i+windowSize);
        colMin = max(1,j-windowSize);
        colMax = min(size(aa,2),j+windowSize);
        % max1 = max(max(aa(i-17:i+17,j-17:j+17)));
         %max1 = max(max1);
     windowImage = aa(rowMin:rowMax,colMin:colMax);
     max1 = max(max(windowImage));
            if(aa(i,j) == max1)
              aaCopy(i,j) = max1;
          
            end
        
    end
end

aa_sort1 = sort(aaCopy(:),'descend');
aa_sort1 = aa_sort1(1:4);

colorIm1 = imresize(a, 0.9);
for i=1:4
[R,C]=find(aaCopy==aa_sort1(i));
rhoA = R-d-1;
thA = C-1;
x0=1;
y0=round((rhoA-(x0*sind(thA)))/cosd(thA));
x1=size(g,1);
y1=round((rhoA-(x1*sind(thA)))/cosd(thA));
colorIm1 = insertShape(colorIm1, 'line', [x0, y0, x1, y1]);
end
figure;
imshow(g);
figure;
imshow(aaCopy(1:10:end,:),[]);
colormap jet;
colormap jet;imshow(aaCopy(1:10:end,:),[]);
colormap jet;imagesc(aaCopy(1:10:end,:));
figure;
imshow(colorIm1);

