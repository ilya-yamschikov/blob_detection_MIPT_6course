function circle = generate_circle(center, sigma, IMG_SIZE) 
    if (max(size(IMG_SIZE)) == 1)
        IMG_SIZE = [IMG_SIZE IMG_SIZE];
    end
    if (max(size(sigma)) == 1)
        sigma = [sigma^2 0; 0 sigma^2];
    end

    circle = zeros(IMG_SIZE(1), IMG_SIZE(2));
    
    for x = 1:IMG_SIZE(1)
        for y = 1:IMG_SIZE(2)
            circle(x,y) = ([x y] - center) / sigma  * ([x y] - center)' <= 1;
        end
    end
end