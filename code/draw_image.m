function draw_image(img)
    imagesc(img);
    colormap(gray);
    colorbar;
    axis([0 size(img,1) 0 size(img, 2)]);
    %axis off
end