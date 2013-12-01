to_run = [1];

% 1 - algorithm results example
if (any (to_run == 1))
    img = generate_sample(512, 15, 'blob', false);
    [centers, radiuses] = detect_blobs(img, 1:1:50);

    subplot(1, 2, 1)
    draw_image(img, false, true)
    subplot(1, 2, 2)
    draw_image(img, false, false)
    hold on
    for i = 1:length(centers)
        plot(centers{i}(2),centers{i}(1), 'ro', 'MarkerSize',radiuses{i}*15, 'LineStyle', 'none'); 
    end
    hold off
end

% 2 - one dimentional
if (any (to_run == 2))
    SIZE = 64;
    sigmas = 1:1:15;
    img = generate_blob([floor(SIZE / 2), floor(SIZE / 2)], SIZE / 10, SIZE);
    img = img + random('unif', 0, 0.1, SIZE, SIZE);
    conv = cell(length(sigmas));
    for i = 1:length(sigmas)
        conv{i} = conv2(img, get_mask(sigmas(i), 31), 'same');
        draw_image(conv{i}, false, false)
    end
    
    draw_image(img, false, true)
end