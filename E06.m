a = imread('unequal.png');
h = zeros(256, 1);
for i=1:numel(a) 
Z=a(i); 
h(Z+1)=h(Z+1)+1;
end 
myHist = int16(h);
plot(myHist);

t = numel(a);
pdf = double(myHist)/t;
plot(pdf);
cdfI = cumsum(pdf);
newCdf = round(cdfI * 255);
plot(newCdf);

f=a;
for i=1:numel(a) 
f(i)=newCdf(a(i)+1); 
end 
imshow(f);

h1 = zeros(256, 1);
for j=1:numel(f) 
Z1=f(j); 
h1(Z1+1)=h1(Z1+1)+1;
end 
myHist1 = int16(h1);
plot(myHist1);

t1 = numel(f);
pdf1 = double(myHist1)/t1;
plot(pdf1);
cdfNew = cumsum(pdf1);
cdfNew1 = round(cdfNew * 255);
plot(cdfNew1);