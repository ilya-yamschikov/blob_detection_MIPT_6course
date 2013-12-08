function [centers, radiuses, matrix] = filter_blobs(blobs_brightness, median_convolutions, in_centers, in_radiuses, IMG_SIZE) 
    centers = cell(0);
    radiuses = cell(0);
    matrix = zeros(IMG_SIZE);
    blobs_count = 0;
    peak_brightness = max(cell2mat(blobs_brightness));
    
    for i = 1:length(in_centers)
        if blobs_brightness{i} < median_convolutions + 0.1 * (peak_brightness - median_convolutions);
            blobs_count = blobs_count + 1;
            centers{blobs_count} = in_centers{i};
            radiuses{blobs_count} = in_radiuses{i};
            matrix(centers{i}(1), centers{i}(2)) = 1;
        end
    end
end