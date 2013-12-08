function [centers, radiuses, matrix] = detect_blobs(image, sigmas)
    % arguments check
    if (nargin < 2)
        sigmas = 1:0.25:5;
    end

    % constants
    DEBUG_STEP = 0.1;
    IMG_SIZE = size(image);
    MASK_SIZE = max(min([4 * max(sigmas)^2, floor(floor(IMG_SIZE / 10) / 2) * 2 + 1]), 31);
    RESPONSE_THRESHOLD = -0.0;
    
    % Initialization
    convolutions = cell(length(sigmas));
    centers = cell(0);
    radiuses = cell(0);
    blobs_brightness = cell(0);
    matrix = zeros(size(image));
    blobs_found = 0;
    peak_brightness = 0;
    
    disp('Start convolutions calculation...');
    next_debug = DEBUG_STEP;
    for i = 1:length(sigmas)
        mask = get_mask(sigmas(i), MASK_SIZE);
        convolutions{i} = conv2(image, mask, 'same');
        
        next_debug = log_progress(i, length(sigmas), next_debug, DEBUG_STEP);
    end
    
    min_convolutions = convolutions{1};
    for i = 2:length(sigmas)
        min_convolutions = min(min_convolutions, convolutions{i});
    end
    median_convolutions = median(min_convolutions(:));
    
    disp('Start blobs finding...');
    next_debug = DEBUG_STEP;
    for x = 1:IMG_SIZE(1)
        for y = 1:IMG_SIZE(2)
            
            mins = zeros(length(sigmas), 1);
            for i = 1:length(sigmas)
                mins(i) = convolutions{i}(x, y);
            end
            
            [min_val, idx] = min(mins);
            if ((idx == 1) || (idx == length(mins)))
                continue;
            end         
            
            if is_local_minimum(min_convolutions, [x y]) && (min_val < RESPONSE_THRESHOLD)
                blobs_found = blobs_found + 1;
                centers{blobs_found} = [x y];
                radiuses{blobs_found} = sigmas(idx);
                blobs_brightness{blobs_found} = min_convolutions(x,y);
                if blobs_brightness{blobs_found} < peak_brightness
                    peak_brightness = blobs_brightness{blobs_found};
                end
                matrix(x, y) = 1;
            end

            next_debug = log_progress(y + x * IMG_SIZE(2), IMG_SIZE(1) * IMG_SIZE(2), next_debug, DEBUG_STEP);
        end
    end
    
    disp(['median brightness = ' num2str(median_convolutions)]);
    true_centers = cell(0);
    true_radiuses = cell(0);
    true_blobs = 0;
    for i = 1:length(centers)
        if blobs_brightness{i} < median_convolutions + 0.1 * (peak_brightness - median_convolutions);
            true_blobs = true_blobs + 1;
            true_centers{true_blobs} = centers{i};
            true_radiuses{true_blobs} = radiuses{i};
            disp(['Blob found: center [' num2str(centers{i}) '], radius = ' num2str(radiuses{i}) ', intensity = ' num2str(blobs_brightness{i})])
        end
    end
    disp(['True blobs ratio = ' num2str(length(true_centers)/length(centers))]);
    
    centers = true_centers;
    radiuses = true_radiuses;
end