function [G] = compute_GLCM ( f)
img = f;
gl = zeros(256,256,'uint16');
for r = 1:size(img,1)-1
    for c = 1:size(img,2)-1
        i1 = img(r,c);
        i2 = img(r+1,c+1);
        gl(i1+1,i2+1) = gl(i1+1,i2+1) + 1;
    end
end

G = gl;

end

    