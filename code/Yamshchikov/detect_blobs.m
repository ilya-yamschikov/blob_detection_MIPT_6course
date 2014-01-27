function [centers, radiuses, matrix] = detect_blobs(image, sigmas)

% Arguments check
    if (nargin < 2)
        sigmas = 1:0.25:5;
    end

% Constants
    DEBUG_STEP = 0.1;
    IMG_SIZE = size(image);
    
% Initialization
    centers = cell(0);
    radiuses = cell(0);
    blobs_brightness = cell(0);
    convolutions = cell(length(sigmas), 1);
    matrix = zeros(size(image));
    min_idx = zeros(IMG_SIZE);
    
% Calculate convolution
    disp('Start convolutions calculation...');
    next_debug = DEBUG_STEP;
    for i = 1:length(sigmas)
        convolutions{i} = conv2(image, get_mask(sigmas(i)), 'same');
        next_debug = log_progress(i, length(sigmas), next_debug, DEBUG_STEP);
    end
    
% Find blobs  
    disp('Start blobs finding...');
    
    % Aggregate convolutions
    min_convolutions = convolutions{1};
    for i = 2:length(sigmas)
        min_convolutions = min(min_convolutions, convolutions{i});
    end
    median_convolutions = median(min_convolutions(:));
    
    %Get indexes of minimum values
    for i = 1:length(sigmas)
        min_idx = max(min_idx, i * (convolutions{i} == min_convolutions));
    end
    
    % start main cycle
    next_debug = DEBUG_STEP;
    for x = 1:IMG_SIZE(1)
        for y = 1:IMG_SIZE(2)
            if ((min_idx(x,y) == 1) || (min_idx(x,y) == length(sigmas)))
                continue;
            end         
            
            if is_local_minimum(min_convolutions, [x y])
                centers{end+1} = [x y];
                radiuses{end+1} = sigmas(min_idx(x, y));
                blobs_brightness{end+1} = min_convolutions(x,y);
                matrix(x, y) = 1;
            end

            next_debug = log_progress(y + x * IMG_SIZE(2), IMG_SIZE(1) * IMG_SIZE(2), next_debug, DEBUG_STEP);
        end
    end
    
    [centers, radiuses, matrix] = filter_blobs(blobs_brightness, median_convolutions, centers, radiuses, IMG_SIZE);
end