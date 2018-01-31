function [x0, y0, x1, y1, x2, y2, x3, y3] = auto_crop ( f )

%%%IMPORTANT%%%
% x0,y0 are the x, y coordinates of the top left corner of image
% x1,y1 are the x, y coordinates of the top right corner of image
% x2,y2 are the x, y coordinates of the bottom right corner of image
% x3,y3 are the x, y coordinates of the bottom left corner of image



rgb = rgb2gray(f);

L=graythresh(rgb);
g = 255 * uint8(imbinarize(rgb,L));
g = edge(g,'canny');
[l,w] = size(g);
d = ceil(sqrt((l*l) + (w*w)));
aa = zeros((2*d)+1,180);

for r = 1:l
    for c = 1:w
        if(g(r,c) == 1)
            for th = 0:179
              v = ceil((r* sind(th))+ (c * cosd(th)));
              aa(v+d+1,th+1) = aa(v+d+1,th+1)+1;
            end
        end
    end
end
aa_sort1 = sort(aa(:),'descend');
aa_sort1 = aa_sort1(1:10);


xbox1 = [];
ybox1 = [];


for i=1:10
[R,C]=find(aa==aa_sort1(i), 1,'last');
rhoA = R-d-1;
thA = C-1;
x00=1;
xbox1(i,1) = x00;
y00=round((rhoA-(x00*cosd(thA)))/sind(thA));
ybox1(i,1) = y00;
x100=size(g,2);
xbox1(i,2) = x100;
y100=round((rhoA-(x100*cosd(thA)))/sind(thA));
ybox1(i,2) = y100;
end

xint = [];
yint = [];
for i=1:10
    for j=1:10
        if(i==j)
            continue;
        end
        [xcoor,ycoor] = polyxpoly(xbox1(i,:),ybox1(i,:),xbox1(j,:),ybox1(j,:));
        if(isempty(xcoor) || isempty(ycoor))
            continue;
        end
        xint=[xint,xcoor(1)];
        yint=[yint,ycoor(1)];
    end
end
topleftx = [];
toplefty = [];
toprightx = [];
toprighty = [];
bottomleftx = [];
bottomlefty = [];
bottomrightx = [];
bottomrighty = [];

hw = w/2;
hl = l/2;
for i = 1:size(xint,2)
    if((xint(i)<hw && xint(i)>0) && (yint(i)<(hl+10) && xint(i)>0))
        topleftx = [topleftx,xint(i)];
        toplefty = [toplefty,yint(i)];
    elseif((xint(i)>hw && xint(i)<w) && (yint(i)<(hl+10) && xint(i)>0))
        toprightx = [toprightx,xint(i)];
        toprighty = [toprighty,yint(i)];
    elseif((xint(i)>hw && xint(i)<w) && (yint(i)>(hl+10)  && xint(i)<l))
        bottomrightx = [bottomrightx,xint(i)];
        bottomrighty = [bottomrighty,yint(i)];
    elseif((xint(i)<hw && xint(i)>0) && (yint(i)>(hl+10) && xint(i)<l))
        bottomleftx = [bottomleftx,xint(i)];
        bottomlefty = [bottomlefty,yint(i)];
    end
end
if(isempty(topleftx))
topleftx = [topleftx,double(w*.25)];
toplefty = [toplefty,double(l*.25)];
end
if(isempty(toprightx))
toprightx = [toprightx,double(w*.75)];
toprighty = [toprightx,double(l*.25)];
end
if(isempty(bottomrightx))
bottomrightx = [bottomrightx,double(w*.75)];
bottomrighty = [bottomrighty,double(l*.75)];
end
if(isempty(bottomleftx))
bottomleftx = [bottomleftx,double(w*.25)];
bottomlefty = [bottomlefty,double(l*.75)];
end

cx1 = topleftx(1);
cy1 = toplefty(1);
cx2 = toprightx(1);
cy2 = toprighty(1);
cx3 = bottomleftx(1);
cy3 = bottomlefty(1);
cx4 = bottomrightx(1);
cy4 = bottomrighty(1);

top_dist = ceil(sqrt((cy1-cy2)^2 + (cx1-cx2)^2));
bottom_dist = ceil(sqrt((cy3-cy4)^2 + (cx3-cx4)^2));
left_dist = ceil(sqrt((cy1-cy3)^2 + (cx1-cx3)^2));
right_dist = ceil(sqrt((cy2-cy4)^2 + (cx2-cx4)^2));

angle_top_left = abs((atan((cy2-cy1)/(cx2-cx1)) - atan((cy3-cy1)/(cx3-cx1)))* 180/pi);
angle_top_right = abs((atan((cy2-cy1)/(cx2-cx1)) - atan((cy4-cy2)/(cx4-cx2))) * 180/pi);
angle_bottom_left = abs((atan((cy3-cy1)/(cx3-cx1)) - atan((cy4-cy3)/(cx4-cx3))) * 180/pi);
angle_bottom_right = abs((atan((cy4-cy2)/(cx4-cx2)) - atan((cy4-cy3)/(cx4-cx3))) * 180/pi);

diff_angle_top_left = abs(angle_top_left-90);
diff_angle_top_right = abs(angle_top_right-90);
diff_angle_bottom_left = abs(angle_bottom_left-90);
diff_angle_bottom_right = abs(angle_bottom_right-90);

x0 = cx1;
y0 = cy1;
x1 = cx2;
y1 = cy2;
x2 = cx4;
y2 = cy4;
x3 = cx3;
y3 = cy3;
score_matrix = [];   

for a = 1:size(topleftx,2)
    for b = 1:size(toprightx,2)
        for c = 1:size(bottomleftx,2)
            for d = 1:size(bottomrightx,2)
                total_score = 0;iterate = 1;
                cx1 = topleftx(a);
                cy1 = toplefty(a);
                cx2 = toprightx(b);
                cy2 = toprighty(b);
                cx3 = bottomleftx(c);
                cy3 = bottomlefty(c);
                cx4 = bottomrightx(d);
                cy4 = bottomrighty(d);
                top_dist = ceil(sqrt((cy1-cy2)^2 + (cx1-cx2)^2));
                bottom_dist = ceil(sqrt((cy3-cy4)^2 + (cx3-cx4)^2));
                left_dist = ceil(sqrt((cy1-cy3)^2 + (cx1-cx3)^2));
                right_dist = ceil(sqrt((cy2-cy4)^2 + (cx2-cx4)^2));
                if(top_dist<200 || bottom_dist<200 || left_dist<200|| right_dist<200)
                    continue;
                end

                %diff_top = abs(top_dist - bottom_dist);
                %diff_bottom = abs(left_dist - right_dist);

                angle_top_left = abs((atan((cy2-cy1)/(cx2-cx1)) - atan((cy3-cy1)/(cx3-cx1)))* 180/pi);
                angle_top_right = abs((atan((cy2-cy1)/(cx2-cx1)) - atan((cy4-cy2)/(cx4-cx2))) * 180/pi);
                angle_bottom_left = abs((atan((cy3-cy1)/(cx3-cx1)) - atan((cy4-cy3)/(cx4-cx3))) * 180/pi);
                angle_bottom_right = abs((atan((cy4-cy2)/(cx4-cx2)) - atan((cy4-cy3)/(cx4-cx3))) * 180/pi);
                diff_angle_top_left = abs(angle_top_left-90);
                diff_angle_top_right = abs(angle_top_right-90);
                diff_angle_bottom_left = abs(angle_bottom_left-90);
                diff_angle_bottom_right = abs(angle_bottom_right-90);
                s1 = score(diff_angle_top_left);
                  s2 = score(diff_angle_top_right);
                  s3 = score(diff_angle_bottom_left);
                  s4 = score(diff_angle_bottom_right);
                  total_score = s1+s2+s3+s4;
                  score_matrix(iterate,1) = total_score;
                  score_matrix(iterate,2) = cx1;
                  score_matrix(iterate,3) = cy1;
                  score_matrix(iterate,4) = cx2;
                  score_matrix(iterate,5) = cy2;
                  score_matrix(iterate,6) = cx4;
                  score_matrix(iterate,7) = cy4;
                  score_matrix(iterate,8) = cx3;
                  score_matrix(iterate,9) = cy3;
                  iterate = iterate+1;
            end
        end
    end
end
if(isempty(score_matrix)~=1)
max_score = max(score_matrix(:,1));
row_num=find(score_matrix(:,1)==max_score);
 x0 = score_matrix(row_num,2);
 y0 = score_matrix(row_num,3);
 x1 = score_matrix(row_num,4);
 y1 = score_matrix(row_num,5);
 x2 = score_matrix(row_num,6);
 y2 = score_matrix(row_num,7);
 x3 = score_matrix(row_num,8);
 y3 = score_matrix(row_num,9);
end
    function pts = score(angle)
if(angle<2)
    pts = 100;
elseif(angle<5)
    pts = 50;
elseif(angle<10)
        pts = 40;
elseif(angle<15)
        pts = 30;
elseif(angle<25)
        pts = 20;
elseif(angle<30)
        pts = 10;
        elseif(angle<35)
        pts = 5;
        elseif(angle<40)
        pts = 2;
        elseif(angle<45)
        pts = 1;
else
    pts = 0;
end
end
end



