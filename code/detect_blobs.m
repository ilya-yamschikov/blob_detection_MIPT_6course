function [centers radiuses] = detect_blobs(image)
    DEBUG_STEP = 0.1;

    IMG_SIZE = size(image);
    MASK_SIZE = floor(floor(IMG_SIZE / 10) / 2) * 2 + 1;
    RESPONSE_THRESHOLD = -0.0;
    
    sigmas = 1:0.1:3;
    
    convolutions = cell(length(sigmas));
    centers = cell(0);
    radiuses = cell(0);
    blobs_found = 0;
    
    disp('Start convolutions calculation...');
    next_debug = DEBUG_STEP;
    for i = 1:length(sigmas)
        mask = get_mask(sigmas(i), MASK_SIZE);
        convolutions{i} = conv2(image, mask, 'same');
        rate = i / length(sigmas);
        if (rate > next_debug)
            disp(['progress: ' num2str(next_debug * 100) '%...']);
            next_debug = next_debug + DEBUG_STEP;
        end
    end
    
    disp('Start blobs finding...');
    next_debug = DEBUG_STEP;
    for x = 1:IMG_SIZE(1)
        for y = 1:IMG_SIZE(2)
            mins = zeros(length(sigmas), 1);
            for i = 1:length(sigmas)
                mins(i) = convolutions{i}(x, y);
            end
            
            [min_val, idx] = min(mins);
            if is_local_minimum(convolutions{i}, [x y]) && (min_val < RESPONSE_THRESHOLD)
                blobs_found = blobs_found + 1;
                centers{blobs_found} = [x y];
                radiuses{blobs_found} = sigmas(idx);
            end
            
            rate = sub2ind(IMG_SIZE, y, x) / (IMG_SIZE(1) * IMG_SIZE(2));
            if (rate > next_debug)
                disp(['progress: ' num2str(next_debug * 100) '%...']);
                next_debug = next_debug + DEBUG_STEP;
            end
        end
    end
end