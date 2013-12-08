function [result_image, centers, radiuses] = generate_sample(MESH_SIZE, BLOBS_COUNT, type, apply_noise)
    % constants
    NOISE_INTENSITY = 0.3;
    DEBUG_STEP = 0.1; % step in percent for debug output
    KNOWN_BLOB_TYPES = {'blob', 'circle'};

    % arguments check    
    if ~ismember(type, KNOWN_BLOB_TYPES)
        disp(['No registred blob type "' type '", using "blob".']);
        type = 'blob';
    end
    if nargin < 4
        apply_noise = false;
    end

    % initialization
    Z = zeros(MESH_SIZE, MESH_SIZE);
    centers = zeros(BLOBS_COUNT, 2);
    radiuses = cell(BLOBS_COUNT);

    disp('Start sample generation...');
    next_debug = DEBUG_STEP;
    for iteration = 1:BLOBS_COUNT
        intensity = random('unif', 0.99, 1);
        sigma = [random('unif', MESH_SIZE/40, MESH_SIZE/10) 0; 0 random('unif', MESH_SIZE/40, MESH_SIZE/10)];
        center = random('unid', MESH_SIZE - 6 * floor(max(sigma(:))), 1, 2) + 3 * floor(max(sigma(:)));
        
        switch type
            case 'blob'
                blob = generate_blob(center, sigma, size(Z));
            case 'circle'
                blob = generate_circle(center, sigma, size(Z));
            otherwise
                disp('Unknown blob type. See generate_sample function.');
        end

        blob = intensity * blob;
        Z = Z + blob;
        centers(iteration, :) = center;
        radiuses{iteration} = sigma;
        
        next_debug = log_progress(iteration, BLOBS_COUNT, next_debug, DEBUG_STEP);
    end

    min_intensity = min(Z(:));
    max_intensity = max(Z(:));
    if apply_noise
        noise = random('unif', min_intensity, min_intensity + NOISE_INTENSITY * (max_intensity - min_intensity), MESH_SIZE, MESH_SIZE);
        Z = noise + Z;
        min_intensity = min(Z(:));
        max_intensity = max(Z(:));
    end
    Z = (Z - min_intensity) / (max_intensity - min_intensity);
    
    result_image = Z;
end