function [r,c] = i_spy ( object_im, big_im, x )


Ro = size(object_im, 1); 
Co = size(object_im, 2); 

Rb = size(big_im, 1); 
Cb = size(big_im, 2); 


o_im = int16(object_im);
b_im = int16(big_im);

o_img = rgb2gray(o_im);
b_img = rgb2gray(b_im);


for r = 1 : Rb - (Ro-1)
    if(max(o_img(1,:))>x(r))
        continue;
    end
    for c = 1 : Cb - (Co-1)
        flag = 0;
        flag2 = 0;

      if(b_img(r,c) == o_img(1,1))
      
        
        for i = 1:Ro
        for j = 1:Co

        diff_val(i,j) = b_img(i+r-1, j+c-1) - o_img(i,j);
            if ( sum ( abs ( diff_val(i,j)) ) ~= 0 )
                flag = 1;
                break;
            end

        end

            if(flag==1)
              flag2 = 1;
              break;
            end

        end

            if ( flag2 == 0 )
            return;
            end

      end

    end
end

