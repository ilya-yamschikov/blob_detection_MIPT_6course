IMAGE_SIZE = 512;
BLOBS_COUNT = 100;

%start benchmark
tStart = tic;

[img, centers, radiuses] = generate_sample(IMAGE_SIZE, BLOBS_COUNT, 'blob');

%img = load_image('test_samples\sunflower.png', true);

[detected_centers, detected_radiuses] = detect_blobs(img, 1:0.25:10);

draw_image(img, true)
hold on
for i = 1:length(detected_centers)
    plot(detected_centers{i}(2),detected_centers{i}(1), 'ro', 'MarkerSize',detected_radiuses{i}*4, 'LineStyle', 'none'); 
end
hold off

tElapsed = toc(tStart);
disp(['Running time: ' num2str(tElapsed) 'sec.']);