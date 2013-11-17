function blob = generate_blob(center, sigma, IMG_SIZE) 
    if (max(size(IMG_SIZE)) == 1)
        IMG_SIZE = [IMG_SIZE IMG_SIZE];
    end
    if (max(size(sigma)) == 1)
        sigma = [sigma^2 0; 0 sigma^2];
    end

    blob = zeros(IMG_SIZE(1), IMG_SIZE(2));
    
    for x = 1:IMG_SIZE(1)
        for y = 1:IMG_SIZE(2)
            blob(x,y) = exp(- 0.5 * ([x y] - center) / sigma * ([x y] - center)');
        end
    end
end