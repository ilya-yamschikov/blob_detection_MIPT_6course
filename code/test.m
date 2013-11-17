IMG_SIZE = 256;
MASK_SIZE = 35;
STEP = 50;
INTENSITY = 256;

[X,Y] = meshgrid(1:IMG_SIZE);

%Z = (2 * mod(floor((X-1)/STEP),2) - 1) .* (2 * mod(floor((Y-1)/STEP),2) - 1);
%Z = INTENSITY * (Z + 1) / 2;

%Z = generate_sample(IMG_SIZE, 10);

sigma_values = 2:1:10;
blobs_centers = cell(1);

for i = 1:length(sigma_values)
    sigma = sigma_values(i);
    mask = get_mask(sigma, MASK_SIZE);
    Res = conv2(Z, mask, 'same');

    min_elem = (Res == min(Res(:)));
    index = find(min_elem);
    [row col] = ind2sub(size(min_elem), index);
    blobs_centers{i} = [row col sigma];
end
subplot(2,2,1)
img = imagesc(Z);
colormap(gray);
axis([0 IMG_SIZE 0 IMG_SIZE]);
axis off
hold on
for i = 1:length(blobs_centers)
    plot(blobs_centers{i}(2),blobs_centers{i}(1),'ro', 'MarkerSize',blobs_centers{i}(3)*2, 'LineStyle', 'none'); 
end
hold off

%subplot(2,2,2)
%imagesc(Res)
%colormap(gray);
%axis([0 IMG_SIZE 0 IMG_SIZE]);
%axis off

subplot(2,2,3)
%imagesc(mask, 'Annotation', 'on')
imagesc(mask)
colormap(gray);
axis([0 MASK_SIZE 0 MASK_SIZE]);
axis off

subplot(2,2,4)
binranges = 0.01 : 0.045 : 1;
counts = histc(Z(:), binranges);
centers = (([binranges binranges(end)] + [0 binranges]) / 2);
centers = centers(2:end);
bar(counts, centers')
%axis([0 MASK_SIZE 0 MASK_SIZE]);
%axis off

