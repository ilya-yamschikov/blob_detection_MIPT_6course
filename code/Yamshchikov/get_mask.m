function mask = get_mask(sigma)
    MASK_SIZE = ceil(11 * sigma / 2) * 2 + 1;
    [mask_X, mask_Y] = meshgrid(1:MASK_SIZE);
    mask_X = mask_X - (max(mask_X(:)) + min(mask_X(:)))/2;
    mask_Y = mask_Y - (max(mask_Y(:)) + min(mask_Y(:)))/2;
    mask = - (1 / (pi * sigma^2)) * (1 - (mask_X.^2 + mask_Y.^2)/(2 * sigma^2)) .* exp (-(mask_X.^2 + mask_Y.^2)/(2 * sigma^2));
end