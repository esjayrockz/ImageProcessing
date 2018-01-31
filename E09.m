clear;
a = imread('salt-pep.png');

[R,C] = size(a);
d = [];
for W = 3: 20 : 103

str = sprintf('Median filter output of Window size %dx%d', W,W);
figure('name', str);

Wh = floor(W/2);

g = zeros(size(a), 'uint8');
tic;
for r = 1+Wh:R-Wh-1
    for c = 1+Wh:C-Wh-1
        
        % Compute median of WXW at (r,c)
        v = a(r-Wh:r+Wh+1,c-Wh:c+Wh+1);
        
        
        med = median(v(:));
        
        % assign it to output
        g(r,c) = med;
    end
end
temp = toc;
d = [d temp];
imshow(g);

%plot(W, d, '-ro');
end

W = 3: 20 : 103;
figure('name', 'Plot of time for window sizes 3 x 3 to 103 x 103 with a step-size of 20');
plot(W, d, '-ro');