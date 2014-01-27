IMAGE_SIZE = 512;
BLOBS_COUNT = 100;

tStart = tic;

[img, centers, radiuses] = generate_sample(IMAGE_SIZE, BLOBS_COUNT, 'blob');

[matrix, detected_centers, detected_radiuses] = Yamshchikov2013BlobsDetection(img, 1:0.25:20);

draw_image(img, false)
hold on
for i = 1:length(detected_centers)
    plot(detected_centers{i}(2),detected_centers{i}(1), 'ro', 'MarkerSize',detected_radiuses{i}*4, 'LineStyle', 'none'); 
end
hold off

tElapsed = toc(tStart);
disp(['Running time: ' num2str(tElapsed) 'sec.']);