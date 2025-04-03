function y = F14_expanded_scaffer(x)
    D = length(x);
    total = 0;
    for i = 1:D-1
        total = total + scafferF6(x(i), x(i+1));
    end
    y = total;
end

function val = scafferF6(x1, x2)
    temp = x1^2 + x2^2;
    val = 0.5 + (sin(sqrt(temp))^2 - 0.5) / (1 + 0.001*temp)^2;
end