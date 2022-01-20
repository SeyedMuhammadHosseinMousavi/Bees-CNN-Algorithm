function y = PerformBeeDance(x, r)
    nVar = numel(x);
    k = randi([1 nVar]); 
    y = x;
    y(k) = x(k)+unifrnd(-r, r);
end