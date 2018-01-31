A = (100 * ones(8,8));
U = dctmtx(8);
B = U * A * U';
imagesc(B);colorbar;

R = rand(8,8,'single') * 255;
B2 = U * R * U';
figure;
imagesc(B2);colorbar;

g = imread('input-2.png');
f = uint8(zeros(656,872));
for i = 1:656
    for j = 1:872
        f(i,j) = g(i,j);
    end
end


f2 = double(f);
for i = 1:8:656
    for j = 1:8:872
        r = double(f(i:i+7,j:j+7));
        B3 = U * r * U';
        f2(i:i+7,j:j+7) = B3;
    end
end
figure;
imagesc(f2);colorbar;