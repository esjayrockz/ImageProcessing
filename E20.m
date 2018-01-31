f = imread ('circle.png');
gx = imfilter(single(f),[-1,1]);
gy = imfilter(single(f),[-1,1]');
[R,C] = size(f);
pts = zeros(40, 2);

pts(1:10, 1) = 1;
pts(1:10, 2) = floor(1:C / 10:C);

pts(11:20, 1) = floor(1:R / 10:R);
pts(11:20, 2) = C;

pts(21:30, 1) = R;
pts(21:30, 2) = floor(C:-C / 10:1);

pts(31:40, 1) = floor(R:-R / 10:1);
pts(31:40, 2) = 1;

Npts = size(pts, 1);
pts3 = pts;
alpha = 10;
beta = 10;
for i=1:100000
Eext = 0;
for j = 1:Npts
     r = pts(j,1);
     c = pts(j,2);
Eext = Eext + gx(r,c)^2 + gy(r,c)^2;
end
Eint = 0;
for j = 1:Npts
     r1 = pts(j,1);
     c1 = pts(j,2);
     r2 = pts(mod(j,Npts)+1,1);
     c2 = pts(mod(j,Npts)+1,2);
     r3 = pts(mod(j+1,Npts)+1,1);
     c3 = pts(mod(j+1,Npts)+1,2);
Eint = Eint + (((r2-r1)^2 + (c2-c1)^2)*alpha);
Eint = Eint + (((r1-(2*r2)+r3)^2 + (c1-(2*c2)+c3)^2)*beta);
end

Etotal = Eint - Eext;

pts2 = pts;
rnd = randi(Npts);
rr = pts2(rnd,1);
cc = pts2(rnd,2);
a = [1,0,-1];
rx = min(max(rr + a(randi(3)),1),R);
cx = min(max(cc + a(randi(3)),1),C);
pts2(rnd,1) = rx;
pts2(rnd,2) = cx;

Eext1 = 0;
for j1 = 1:Npts
     r0 = pts2(j1,1);
     c0 = pts2(j1,2);
Eext1 = Eext1 + gx(r0,c0)^2 + gy(r0,c0)^2;
end
Eint1 = 0;
for j1 = 1:Npts
     r10 = pts2(j1,1);
     c10 = pts2(j1,2);
     r20 = pts2(mod(j1,Npts)+1,1);
     c20 = pts2(mod(j1,Npts)+1,2);
     r30 = pts2(mod(j1+1,Npts)+1,1);
     c30 = pts2(mod(j1+1,Npts)+1,2);
Eint1 = Eint1 + (((r20-r10)^2 + (c20-c10)^2)*alpha);
Eint1 = Eint1 + (((r10-(2*r20)+r30)^2 + (c10-(2*c20)+c30)^2)*beta);
end

Etotal1 = Eint1 - Eext1;
if(Etotal1<Etotal)
    pts = pts2;
end

end
contourImage = vis_acm(f,pts);
imshow(contourImage);