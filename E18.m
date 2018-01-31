
 prefix = ('key');
 for i = 1:4
 fn = sprintf('%s.%d.jpg', prefix, i);
 img = imread ( fn );
 img_gray = rgb2gray(img);
 g = imbinarize(img_gray);
 g = ~g;
 [R,C] = size(g);
 diag = floor(sqrt(R^2 + C^2));
 c = ones(5,5);
 f = imclose(g,c);
 l = bwlabel(f);
 stats = regionprops(l,'area');
 max1= max([stats.Area]);
 area1 = find([stats.Area]>=max1);
 m = ismember(l,area1);
 rp = regionprops(m,'Centroid');
 centroids = cat(1, rp.Centroid);
 
 cy = round(centroids(2));
 cx = round(centroids(1));
 
edg = edge(m); 
cdf = 1:360;
for r = 1:R-1
  for c = 1:C-1
     if(edg(r,c)==1)
         d = sqrt((cy-r)^2 + (cx-c)^2);
         th = 180 + floor(atan2d((cy-r),(cx-c)));
         cdf(th+1) = d;   
     end
  end
end
 figure;
 plot(cdf);
 norm_cdf = cdf/max(cdf);
 figure;
 plot(norm_cdf);
 th_max = find(cdf == max(cdf));
 
 cdf_rot = 1:360;
 for r = 1:360
 cdf_rot(r) = norm_cdf(mod(r+th_max-2,360)+1);
 end
 figure;
 plot(cdf_rot);
 end
       