function img = load_image(filename, invert)
    if nargin < 2
        invert = false;
    end
    img = imread(filename);
    %img = mat2gray(img);
    img = 0.299*img(:,:,1) + 0.587*img(:,:,2) + 0.114*img(:,:,3);
    img = double(img);
    img = (img - min(img(:))) / (max(img(:)) - min(img(:)));
    if invert
        img = max(img(:)) - img;
    end
end