function [c, r, wdt, hgt] = auto_crop ( f )


folder_name = 'data/';

   g1 = rgb2gray(f);
   L=graythresh(g1);
   
   g = 255 * uint8(imbinarize(g1,L));
   x = 0;
   flag = 0;

    y1 = 0;
    flag1 = 0;
    godown = 0;
    x1 = 0;
    r = 0;
    r1 = 0;
        for i=1:(size(g,1))/2
        for j=1:(size(g,2))/4
            if(g(i,j)==0 && godown == 0)
                x1=x1+1;
            else
                x1=0;
            end
            if(x1==250)
                r1 = i;

            end
        end
        end

        fl=0;
        if(r1 == 0)
            for i=1:(size(g,1))/2
            for j=1:(size(g,2))/4
                if(g(i,j)==0 && godown == 0)
                    x=x+1;
                else
                    x=0;
                end
                if(x==30)
                    r = i;
                    c = j-10;
                    %c1=c;
                    fl = 1;
                    break;
                end
            end
            if(fl ==1)
                break;
            end
            end
        end



        down=0;z1=0;flag3=0;
       if(r==1 && r1==0)
            for i=1:(size(g,1))/2
            for j=1:(size(g,2))/2


                if(g(i,j)==255 && godown == 0)
                    z1=z1+1;
                else
                    z1=0;
                end
                if(z1==600 && godown == 0)
                    r=i;
                    down = 1;
                    break;
                end


            end
                if(down == 1)
                    break;
                end
            end

            z2=0;bz=0;
            if(down == 1)
                for i= r+20:(size(g,1))/2
                for j= 100:(size(g,2))/2

                    if(g(i,j)==255)
                        z2=z2+1;
                        bz=0;
                    else
                        bz = bz+1;
                        if(bz==4)
                            z2=0;
                        end
                    end

                    if(z2==600)

                    c=j-600;
                    flag3 = 1;
                    break;

                    end
                end
                    if(flag3 == 1)
                        break;
                    end
                end
            end

       end

       noBorderflag = 0;
        if(r==0 && r1==0)
            for i= 1:(size(g,1))/2
            for j= 100:(size(g,2))/2
                if(g(i,j)==0)
                    r=i-50;
                    c=j-150;
                    noBorderflag = 1;
                    fl=1;
                    break;
                end
            end
                if(noBorderflag == 1)
                    break;
                end
            end
        end


        if(r1>size(g,1)/4 && x~=10 )
            %z=r1;
           r1=1;
        end

        if (fl == 0 )
        for i=r1:(size(g,1))/2
        for j=100:(size(g,2))/2


            if(g(i,j)==255 && godown == 0)
                y1=y1+1;
                else
                y1=0;
            end
            if(y1==600 && godown == 0)
                r=i;
                godown = 1;
                break;

            end


        end
            if(godown == 1)
                break;
            end
        end
        end

        y2=0;b=0;bsum=0;
        if(godown == 1 && fl==0)
        for i= r+20:(size(g,1))/2
        for j= 100:(size(g,2))/2

             if(g(i,j)==255)
                y2=y2+1;
                b=0;
             else
                b = b+1;
                %bsum = bsum+1;
                if(b==4)
                y2=0;
                end
             end

             if(y2==600)

                c=j-600;
                flag1 = 1;
                break;

            end
        end
            if(flag1 == 1)
                break;
            end
        end
        end

       if(r<60)
           r=r+350;
       end
       if(c<60)
           c=c+350;
       end

       heightArr = [];
       width = c;
       w=0;
       p=0;
       wFlag = 0;
       widthArr = [];widthMax = 0;
       %Width And Height calculation
       if(size(g,1)>size(g,2))
              for i1 = r+20:size(g,1)-50
                  p=0;w=0;
              for k1 = size(g,2)/2:size(g,2)
               if(g(i1,k1)== 0)
                   w=w+1;
                   p=0;
               else
                   p=p+1;
               end
               if(p==5)
                   w=0;
               end

               if(w==50)
                   %st=i;
                   widthArr = [widthArr, k1-50-c];
                  % wFlag = 1;
                   break;

               end
              end
              end
               width = median(widthArr);
               widthMax = max(widthArr);
                if(isnan(width))
                width =size(g,2)-(2*c);
                widthMax = size(g,2)-(2*c);
                end
                if(width<600)
                    width =size(g,2)-(2*c);
                end
              wdt = max(width,widthMax);

               temp=0;hMax=[];
       for i=c-10:size(g,2)
           h=0;hflag=0;
           for j=r+10:size(g,1)

               if(g(j,i)== 0)
                   h=h+1;
               else
                   h=0;
               end
               if(h==20)
                   heightArr = [heightArr,j-20-r];
                   hMax = [hMax,abs(j-20-r - temp)];

                   temp = j-20-r;

                   break;
               end

           end
       end
       height = median(heightArr);
      Max = max(hMax);
      if(isnan(height))
           height =size(g,1)-(2*r);
           Max = size(g,1)-(2*r);
           end
           if(height<400)
                    height =size(g,1)-(2*r);
                end
      hgt = max(height,Max);
       end
       p=0;
       heightArr2 = []; widthArr2 = [];
       if(size(g,1)<size(g,2))
           for i1 = r+20:size(g,1)-50
           for k1 = size(g,2)/2:size(g,2)
               if(g(i1,k1)== 0)
                   w=w+1;
                   p=0;
               else
                   p=p+1;
               end
               if(p==5)
                   w=0;
               end

               if(w==50)
                   %st=i;
                   widthArr2 = [widthArr2,k1-50-c];

                  % wFlag = 1;
                   break;

               end
           end
           end
           width = median(widthArr2);
           widthMax = max(widthArr2);
           if(isnan(width))
           width =size(g,2)-(2*c);
           widthMax = size(g,2)-(2*c);
           end
           if(width<600)
                    width =size(g,2)-(2*c);
                end
           wdt = max(width,widthMax);

           h=0;heightFlag=0;temp=0;hMax=[];
        for i=size(g,2)/2:(size(g,2)*(3/4))
           h=0;heightFlag=0;
           for j=r+20:size(g,1)

               if(g(j,i)== 0)
                   h=h+1;
               else
                   h=0;
               end
               if(h==20)
                   heightArr2 = [heightArr2,j-20-r];
                   hMax = [hMax,j-20-r - temp];
                   temp = j-20-r;
                   break;
               end
           end
       end
        height = median(heightArr2);
        Max = max(hMax);
        if(isnan(height))
           height =size(g,1)-(2*r);
           Max = size(g,1)-(2*r);
           end
           if(height<400)
                    height =size(g,1)-(2*r);
                end

        hgt = max(height,Max);
       end
        wdt2 = size(g,2)-(2*c);
        hgt2 = size(g,1)-(2*r);
        wdt=min(wdt2,wdt);
        hgt=max(hgt2,hgt);

end
