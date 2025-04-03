function y = F1_sphere(x)
    o = ones(1, length(x));  
    z = x - o;
    y = sum(z.^2);
end