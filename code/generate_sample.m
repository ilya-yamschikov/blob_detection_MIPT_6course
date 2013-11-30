function [result_image centers radiuses] = generate_sample(mesh_size, blobs_count, type)
    if ~(strcmp(type, 'blob') || strcmp(type, 'circle'))
        type = 'blob';
    end

    BLOBS_COUNT = blobs_count;
    MESH_SIZE = mesh_size;
    DEBUG_STEP = 0.1; % step in percent for debug output

    Z = zeros(MESH_SIZE, MESH_SIZE);
    centers = zeros(BLOBS_COUNT, 2);
    radiuses = cell(BLOBS_COUNT);

    next_debug = DEBUG_STEP;
    for iteration = 1:BLOBS_COUNT
        intensity = random('unif', 0.99, 1);
        sigma = [random('unif', MESH_SIZE/100, MESH_SIZE/15) 0; 0 random('unif', MESH_SIZE/100, MESH_SIZE/15)];
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
        
        % progress output
        rate = iteration / BLOBS_COUNT;
        if (rate > next_debug)
            disp(['progress: ' num2str(next_debug * 100) '%...']);
            while (next_debug < rate)
                next_debug = next_debug + DEBUG_STEP; 
            end
        end
    end

    min_intensity = min(Z(:));
    max_intensity = max(Z(:));
    Z = (Z - min_intensity) / (max_intensity - min_intensity);
    
    result_image = Z;
end