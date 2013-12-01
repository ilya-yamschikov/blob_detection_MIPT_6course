%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Detecting blobs on image
% Arguments:
% 1) Image - image for blobs detection.
%       should be 2D array with size > 16px on both dimentions
%       Array element represent the intensity of pixel. 
% 2) Blobs_sizes (optional parameter) - specifies the range of bolobs sizes
%       for search. Shold be 2D array - [min_size max_size]
%       If it's not specified, then default value [1 5] will be used
%       Limits: min_size should be > 1,  max_size < then image size (on both dimentions)

function [Matrix, Centers, Radiuses] = Yamshchikov2013BlobsDetection(Image, Blobs_sizes)
    if (nargin < 2) || (length(size(Blobs_sizes)) > 2) || (((size(Blobs_sizes, 1) ~= 1) || (size(Blobs_sizes, 2) ~= 2)) && ((size(Blobs_sizes, 1) ~= 2) || (size(Blobs_sizes, 2) ~= 1)))
        disp(['Wrong input! blobs sizes to find set wrong: blolbs_sizes = [' num2str(Blobs_sizes) '], continue with [1.0 5.0]']);
        Blobs_sizes = [1 5];
    end
    if (Blobs_sizes(1) < 1)
        disp(['Minimum blob size for search should be greater then 1px, but ' num2str(Blobs_sizes(1)) ' found.'])
        Blobs_sizes(1) = 1;
    end
    if (Blobs_sizes(2) > min(size(Image)))
        disp(['Maximum blob size for search should be less then image size (' num2str(min(size(Image))) '), but ' num2str(Blobs_sizes(2)) ' found.'])
        Blobs_sizes(2) = min(size(Image));
    end
    
    if length(size(Image)) > 2
        disp('Sorry, Image should be 2D array.')
        return
    end
    if (min(size(Image)) < 16)
        disp('Sorry, only images with size > 16x16 px allowed.')
        return
    end

    % Normalizing
    Image = (Image - min(Image(:))) / (max(Image(:)) - min(Image(:)));
    
    [Centers, Radiuses, Matrix] = detect_blobs(Image, Blobs_sizes);
end