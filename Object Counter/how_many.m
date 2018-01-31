function [ct] = how_many ( prefix, ct_f, num_f )


for x=1:numel(ct_f)
fn = sprintf ( '%sFRM_%05d.png%', prefix, ct_f(x));
img = imread (fn);
gth = graythresh(img);
if (size(img,3)==3)
    img_gray = rgb2gray(img);
    mean1 = imbinarize(img_gray,(gth-0.1));
else
    mean1 = imbinarize(img,(gth-0.2));
end
imc = imcomplement(mean1);

k1 = ones(5,5);

imd = imdilate(imc,k1);
ime = imerode(imd,k1);

l = bwlabel(ime);
stats = regionprops(l,'area');
mn1 = mean([stats.Area]);
rcheck = min(10,ceil(size(l,1)*0.1));
ccheck = min(10,ceil(size(l,2)*0.1));
for r = 1:rcheck
for c = 1:size(l,2)
l(r,c)=0;
end
end

for r = 1:size(l,1)
for c = size(l,2)-ccheck:size(l,2)
l(r,c)=0;
end
end

for r = size(l,1)-rcheck:size(l,1)
for c = 1:size(l,2)
l(r,c)=0;
end
end

for r = 1:size(l,1)
for c = 1:ccheck
l(r,c)=0;
end
end
stats = regionprops(l,'area');
area1 = find([stats.Area]>mn1);

ct(x) = numel(area1);

end
end
