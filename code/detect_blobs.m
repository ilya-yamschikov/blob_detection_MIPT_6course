function [centers, radiuses, matrix] = detect_blobs(image, sigmas)
    % Arguments check
    if (nargin < 2)
        sigmas = 1:0.25:5;
    end

    % Constants
    DEBUG_STEP = 0.1;
    IMG_SIZE = size(image);
    MASK_SIZE = max(min([4 * max(sigmas)^2, floor(floor(IMG_SIZE / 10) / 2) * 2 + 1]), 31);
    
    % Initialization
    convolutions = cell(length(sigmas));
    matrix = zeros(size(image));
    
    % Calculate convolution
    disp('Start convolutions calculation...');
    next_debug = DEBUG_STEP;
    for i = 1:length(sigmas)
        convolutions{i} = conv2(image, get_mask(sigmas(i), MASK_SIZE), 'same');
        next_debug = log_progress(i, length(sigmas), next_debug, DEBUG_STEP);
    end
    
    % Aggregate convolutions
    min_convolutions = convolutions{1};
    for i = 2:length(sigmas)
        min_convolutions = min(min_convolutions, convolutions{i});
    end
    median_convolutions = median(min_convolutions(:));
    
    % Find blobs
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
            
            if is_local_minimum(min_convolutions, [x y])
                centers{end+1} = [x y];
                radiuses{end+1} = sigmas(idx);
                blobs_brightness{end+1} = min_convolutions(x,y);
                matrix(x, y) = 1;
            end

            next_debug = log_progress(y + x * IMG_SIZE(2), IMG_SIZE(1) * IMG_SIZE(2), next_debug, DEBUG_STEP);
        end
    end
    
    [centers, radiuses, matrix] = filter_blobs(blobs_brightness, median_convolutions, centers, radiuses, IMG_SIZE);
end