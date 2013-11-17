function test_matrix = generate_sample(mesh_size, blobs_count)

    BLOBS_COUNT = blobs_count;
    MESH_SIZE = mesh_size;

    Z = zeros(MESH_SIZE, MESH_SIZE);

    for iteration = 1:BLOBS_COUNT
        intensity = random('unif', 0.5, 1);
        sigma = [random('unif', MESH_SIZE/100, MESH_SIZE/15) 0; 0 random('unif', MESH_SIZE/100, MESH_SIZE/15)];
        center = random('unid', MESH_SIZE - 6 * floor(max(sigma(:))), 1, 2) + 3 * floor(max(sigma(:)));
        blob = intensity * generate_blob(center, sigma, size(Z));
        Z = Z + blob;
    end

    min_intensity = min(Z(:));
    max_intensity = max(Z(:));
    Z = (Z - min_intensity) / (max_intensity - min_intensity);

    %h = figure;
    %pic = mesh(X, Y, Z);
    %colormap(gray(256));
    %view(2);
    %axis([0 MESH_SIZE 0 MESH_SIZE]);
    %axis off
    %mkdir('test_samples')
    %saveas(pic, 'test_samples\sample1.png', 'png');
    
    test_matrix = Z;
end