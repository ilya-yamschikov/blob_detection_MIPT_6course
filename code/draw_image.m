function draw_image(img, invert)
    if nargin < 2
        invert = false;
    end
    if invert 
        img = max(img(:)) - img;
    end
    imagesc(img);
    colormap(gray);
    colorbar;
    axis([0 size(img,1) 0 size(img, 2)]);
    %axis off
end