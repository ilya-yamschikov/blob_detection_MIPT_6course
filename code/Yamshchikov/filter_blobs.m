function [centers, radiuses, matrix] = filter_blobs(blobs_brightness, median_convolutions, in_centers, in_radiuses, IMG_SIZE) 
    THRESHOLD = 0.1;

    centers = cell(0);
    radiuses = cell(0);
    matrix = zeros(IMG_SIZE);
    peak_brightness = min(cell2mat(blobs_brightness));
    
    for i = 1:length(in_centers)
        if blobs_brightness{i} < median_convolutions + THRESHOLD * (peak_brightness - median_convolutions);
            centers{end+1} = in_centers{i};
            radiuses{end+1} = in_radiuses{i};
            matrix(centers{i}(1), centers{i}(2)) = 1;
        end
    end
end