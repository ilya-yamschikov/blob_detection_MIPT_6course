function blob = generate_blob(center, sigma, IMG_SIZE) 
    if (max(size(IMG_SIZE)) == 1)
        IMG_SIZE = [IMG_SIZE IMG_SIZE];
    end
    if (max(size(sigma)) == 1)
        sigma = [sigma^2 0; 0 sigma^2];
    end

    blob = zeros(IMG_SIZE(1), IMG_SIZE(2));
    
    X_SIZE = IMG_SIZE(1);
    Y_SIZE = IMG_SIZE(2);
    for x = 1:X_SIZE
        vector = [repmat(x, Y_SIZE, 1) (1:Y_SIZE)'] - repmat(center, Y_SIZE, 1);
        blob(x,:) = exp(- 0.5 * ((vector / sigma) .* vector) * ones(2, 1));
    end 
end