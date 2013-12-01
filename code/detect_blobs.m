function [centers, radiuses, matrix] = detect_blobs(image, sigmas)
    if (nargin < 2)
        sigmas = 1:0.25:5;
    end

    DEBUG_STEP = 0.1;

    IMG_SIZE = size(image);
    MASK_SIZE = max(min([4 * max(sigmas)^2, floor(floor(IMG_SIZE / 10) / 2) * 2 + 1]), 31);
    RESPONSE_THRESHOLD = -0.0;
    
    convolutions = cell(length(sigmas));
    centers = cell(0);
    radiuses = cell(0);
    matrix = zeros(size(image));
    blobs_found = 0;
    
    disp('Start convolutions calculation...');
    next_debug = DEBUG_STEP;
    for i = 1:length(sigmas)
        mask = get_mask(sigmas(i), MASK_SIZE);
        convolutions{i} = conv2(image, mask, 'same');
        rate = i / length(sigmas);
        if (rate > next_debug)
            disp(['progress: ' num2str(next_debug * 100) '%...']);
            while (next_debug < rate)
                next_debug = next_debug + DEBUG_STEP; 
            end
        end
    end
    
    min_convolutions = convolutions{1};
    for i = 2:length(sigmas)
        min_convolutions = min(min_convolutions, convolutions{i});
    end
    median_convolutions = median(min_convolutions(:));
    min_convolutions = min(median_convolutions * ones(size(min_convolutions)), min_convolutions);
    
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
                     
            if (x == 462) && (y == 65)
                ololo = 1;
            end            
            
            if is_local_minimum(min_convolutions, [x y]) && (min_val < RESPONSE_THRESHOLD)
                blobs_found = blobs_found + 1;
                centers{blobs_found} = [x y];
                radiuses{blobs_found} = sigmas(idx);
                matrix(x, y) = 1;
            end
            
            rate = (y + x * IMG_SIZE(2)) / (IMG_SIZE(1) * IMG_SIZE(2));
            if (rate > next_debug)
                disp(['progress: ' num2str(next_debug * 100) '%...']);
                while (next_debug < rate)
                    next_debug = next_debug + DEBUG_STEP; 
                end
            end
        end
    end
end