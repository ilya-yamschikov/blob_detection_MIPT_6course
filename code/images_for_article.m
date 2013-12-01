to_run = [2];

% 1 - algorithm results example
if (any (to_run == 1))
    img = generate_sample(512, 15, 'blob', true);
    [centers, radiuses] = detect_blobs(img, 4:0.25:25);

    subplot(1, 2, 1)
    draw_image(img, false, true)
    subplot(1, 2, 2)
    %clr = get_img_with_points(img, centers);
    %draw_image(clr, false, false)
    draw_image(img, false, false)
    hold on
    for i = 1:length(centers)
        plot(centers{i}(2),centers{i}(1), 'ro', 'MarkerSize',radiuses{i}*15, 'LineStyle', 'none'); 
    end
    hold off
    
    for i = 1:length(centers)
        disp(['Blob found: center [' num2str(centers{i}) '], radius = ' num2str(radiuses{i})])
    end
end

% 2 - one dimentional
if (any (to_run == 2))
    SIZE = 128;
    sigmas = 4:0.25:25;
    %img = generate_blob([floor(SIZE / 2), floor(SIZE / 2)], SIZE / 10, SIZE);
    %img = img + random('unif', 0, 0.3, SIZE, SIZE);
    conv = cell(length(sigmas));
    for i = 1:length(sigmas)
        conv{i} = conv2(img, get_mask(sigmas(i), 31), 'same');
        %draw_image(conv{i}, false, false)
    end
    
    draw_image(img, false, true)
    
    [centers, radiuses] = detect_blobs(img, sigmas);
    hold on
    for i = 1:length(centers)
        plot(centers{i}(2),centers{i}(1), 'ro', 'MarkerSize',radiuses{i}*15, 'LineStyle', 'none'); 
    end
    hold off
    for i = 1:length(centers)
        disp(['Blob found: center [' num2str(centers{i}) '], radius = ' num2str(radiuses{i})])
    end
    
    
    %draw_image(conv{45}, false, false)
    %figure
    %point = [floor(SIZE/2), floor(SIZE/2)];
    point = [16 16];
    val = zeros(1, length(sigmas));
    for i = 1:length(sigmas)
        val(i) = conv{i}(point(1), point(2));
    end
    %plot(sigmas, val, 'r.-');
end