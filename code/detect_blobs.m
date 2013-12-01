function [centers, radiuses, matrix] = detect_blobs(image, blolbs_sizes)
    if (nargin < 2)
        blolbs_sizes = [1 5];
    end

    DEBUG_STEP = 0.1;
    SIGMA_SPLITS = 20;

    IMG_SIZE = size(image);
    MASK_SIZE = floor(floor(IMG_SIZE / 10) / 2) * 2 + 1;
    RESPONSE_THRESHOLD = -0.0;
    
    sigmas = blolbs_sizes(1):((blolbs_sizes(2) - blolbs_sizes(1)) / SIGMA_SPLITS):blolbs_sizes(2);
    
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