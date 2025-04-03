function y = F6_rosenbrock(x)
    o = ones(1, length(x));  
    z = x - o;
    y = sum(100*(z(1:end-1).^2 - z(2:end)).^2 + (z(1:end-1) - 1).^2);
end