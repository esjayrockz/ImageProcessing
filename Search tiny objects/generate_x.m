function [x] = generate_x ( b_im )

% nothing useful for now
%x.table = [1 2 3];
%x.magic = [25.5 2.1];

b_imgrey = rgb2gray(b_im);
for i1 = 1:size(b_imgrey)
x(i1) = max(b_imgrey(i1,:));
end