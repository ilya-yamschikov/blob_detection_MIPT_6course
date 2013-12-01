function draw_image(img, invert, add_colorbar)
    if nargin < 2
        invert = false;
    end
    if nargin < 3
        add_colorbar = false;
    end
    
    if invert 
        img = max(img(:)) - img;
    end
    figure
    imagesc(img);
    colormap(gray);
    if add_colorbar
        colorbar;
    end
    axis([0 size(img,1) 0 size(img, 2)]);
    %axis off
end