clear;
a = imread('input.png');

sg = 10.0;
hwk = round((2.5*sg) -0.5)
w = zeros((hwk*2)+1,(hwk*2)+1);

for r = 1:size(w,1)
    for c = 1:size(w,2)
         x = r - hwk -1;
         y = c - hwk -1;
         e = -((x^2)+(y^2))/(2*sg^2);
         w(r,c) = exp(e);
     end
end
norm = (w / sum(w(:)));
figure('name', 'Visualization of kernel');
title('Visualization of kernel');
imagesc(norm);
colormap jet;

figure('name','Output of Gaussian Filter');
title('Output of Gaussian Filter');

ImageOutput = uint8(zeros(size(a,1),size(a,2)));

for r = hwk+1:size(a,1)-hwk-1
    for c = hwk+1:size(a,2)-hwk-1
        sum = 0;

        for i = -hwk:hwk
            for j = -hwk:hwk
                sum  = sum + (norm(i+hwk+1,j+hwk+1)*double(a(r+i,c+j)));
                ImageOutput(r,c) = sum;
            end
        end        
        
    end
end

imshow(ImageOutput);
