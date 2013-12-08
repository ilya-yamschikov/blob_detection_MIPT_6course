function [result_image centers radiuses] = generate_sample(mesh_size, blobs_count, type, apply_noise)
    if ~(strcmp(type, 'blob') || strcmp(type, 'circle'))
        type = 'blob';
    end
    if nargin < 4
        apply_noise = false;
    end

    NOISE_INTENSITY = 0.5;
    BLOBS_COUNT = blobs_count;
    MESH_SIZE = mesh_size;
    DEBUG_STEP = 0.1; % step in percent for debug output

    Z = zeros(MESH_SIZE, MESH_SIZE);
    centers = zeros(BLOBS_COUNT, 2);
    radiuses = cell(BLOBS_COUNT);

    next_debug = DEBUG_STEP;
    for iteration = 1:BLOBS_COUNT
        intensity = random('unif', 0.99, 1);
        sigma = [random('unif', MESH_SIZE/40, MESH_SIZE/10) 0; 0 random('unif', MESH_SIZE/40, MESH_SIZE/10)];
        center = random('unid', MESH_SIZE - 6 * floor(max(sigma(:))), 1, 2) + 3 * floor(max(sigma(:)));
        if strcmp(type, 'blob')
            blob = generate_blob(center, sigma, size(Z));
        else
            blob = generate_circle(center, sigma, size(Z));
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