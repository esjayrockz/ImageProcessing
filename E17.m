prefix = {'data/Bark', 'data/Bush', 'data/Fabric', 'data/Floor',...
          'data/Flower', 'data/Food', 'data/Gravel', 'data/Hair',...
          'data/Marble', 'data/Metal', 'data/Paint'};
Ent = zeros(11,9);
for x = 1:11
for y = 1:9
fn = sprintf('%s.%d.png', prefix{x}, y);
img = imread (fn);
G = compute_GLCM(img);
G = double(G);
G = G/sum(G(:));
E = 0;
[R,C] = size(G);
for r1 = 1:R
    for c1 = 1:C
        if (G(r1,c1) ~= 0)
            E = E + -1 * G(r1,c1) * log2(G(r1,c1));
        end
        
    end
end
Ent(x,y) = E;
end
end
T = 0;

for x1 = 1:11
    for y1 = 1:9
        E1 = Ent(x1,y1);
        if(y1==9)
        diff = abs(Ent(x1,y1)-Ent(x1,y1-1));
        min1 = diff;
        R1 = x1;
        C1 = y1-1;
        else
        diff = abs(Ent(x1,y1)-Ent(x1,y1+1));
        min1 = diff;
        R1 = x1;
        C1 = y1+1;
        end
        for r = 1:11
            for c = 1:9
               if((r~= x1) || (c~= y1))
                    diff = abs(E1 - Ent(r,c));
                
                    if(diff < min1)
                        min1 = diff;
                        R1 = r;
                        C1 = c;
                    elseif(diff == min1)
                        if(r==x1)
                        min1 = diff;
                        R1 = r;
                        C1 = c;
                        end
                    end
                    
                end
             end
        end
        if(R1==x1)
            T = T+1;
           
        end
    end
end

accuracy = double(T/99)*100;
disp(accuracy);
        