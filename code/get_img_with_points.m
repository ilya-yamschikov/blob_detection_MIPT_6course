function clr_img = get_img_with_points(img, centers)
    max_intensity = max(img(:));
    min_intensity = min(img(:));

    clr_img = zeros(size(img,1), size(img,2), 3);
    clr_img(:,:,1) = img;
    clr_img(:,:,2) = img;
    clr_img(:,:,3) = img;
    
    for i = 1:length(centers)
        clr_img(centers{i}(1), centers{i}(2), 1) = max_intensity;
        clr_img(centers{i}(1), centers{i}(2), 2) = min_intensity;
        clr_img(centers{i}(1), centers{i}(2), 3) = min_intensity;
    end
end