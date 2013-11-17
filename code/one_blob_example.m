IMAGE_SIZE = 256;
MASK_SIZE = 51;
SIGMA_ORIGINAL = 15;

sigmas = 3:0.25:19;
image = generate_circle([floor(IMAGE_SIZE / 2) floor(IMAGE_SIZE / 2)], SIGMA_ORIGINAL, IMAGE_SIZE);

mins = zeros(length(sigmas), 1);

for i = 1:length(sigmas)
    mask = get_mask(sigmas(i), MASK_SIZE);
    res = conv2(image, mask, 'same');
    mins(i) = min(res(:));
    
    if (sigmas(i) == SIGMA_ORIGINAL) 
        res_of_real_sigma = res;
    end
end

figure

subplot(1,4,1)
draw_image(image)

subplot(1,4,2)
plot(sigmas, mins, '-r');
title('Min conviolution value')
xlabel('Sigma of mask')
ylabel('Min value')

subplot(1,4,3)
plot(res_of_real_sigma(floor(IMAGE_SIZE / 2), :), '-b');

subplot(1,4,4)
draw_image(res_of_real_sigma)

total_min_value = min(mins);
disp(['Minimum of responce: ' num2str(total_min_value)]);
%[total_min_value index] = min(mins)
%argmin_min = sigmas(index)