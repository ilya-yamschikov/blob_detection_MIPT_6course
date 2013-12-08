to_run = [2];

% 1 - algorithm results example
if (any (to_run == 1))
    img = generate_sample(512, 15, 'blob', true);
    [centers, radiuses] = detect_blobs(img, 2:0.25:30);

    draw_image(img, false, false)
    figure
    draw_image(img, false, false)
    hold on
    for i = 1:length(centers)
        plot(centers{i}(2),centers{i}(1), 'ro', 'MarkerSize',radiuses{i}*3, 'LineStyle', 'none', 'LineWidth', 5); 
    end
    hold off
    
    for i = 1:length(centers)
        disp(['Blob found: center [' num2str(centers{i}) '], radius = ' num2str(radiuses{i})])
    end
end

% 2 - one dimentional
if (any (to_run == 2))
    SIZE = 256;
    sigmas = 4:0.25:18;
    %img = generate_blob([floor(SIZE / 2), floor(SIZE / 2)], 15, SIZE);
    %img = img + random('unif', 0, 0.4, SIZE, SIZE);
    conv = cell(length(sigmas));
    %for i = [1, 10, 15, 30]
        %conv{i} = conv2(img, get_mask(sigmas(i), 31), 'same');
        %figure
        %draw_image(conv{i})
    %end
    
    draw_image(img, false, true)
    
    [centers, radiuses] = detect_blobs(img, sigmas);
    %draw_image(img);
    hold on
    for i = 1:length(centers)
        plot(centers{i}(2),centers{i}(1), 'ro', 'MarkerSize',radiuses{i}*5, 'LineStyle', 'none', 'LineWidth', 3); 
    end
    hold off
    %for i = 1:length(centers)
    %    disp(['Blob found: center [' num2str(centers{i}) '], radius = ' num2str(radiuses{i})])
    %end
    
    
    %draw_image(conv{45}, false, false)
    %figure
    %point = [floor(SIZE/2), floor(SIZE/2)];
    %point = [16 16];
    %val = zeros(1, length(sigmas));
    %for i = 1:length(sigmas)
    %    val(i) = conv{i}(point(1), point(2));
    %end
    %plot(sigmas, val, 'r.-');
end