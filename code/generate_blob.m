function blob = generate_blob(center, sigma, IMG_SIZE) 
    blob = zeros(IMG_SIZE(1), IMG_SIZE(2));
    for x = 1:IMG_SIZE_X
        for y = 1:IMG_SIZE_Y
            blob(x,y) = exp(- 0.5 * ([x y] - center) / sigma * ([x y] - center)');
        end
    end
end