function result = is_local_minimum(img, point)
    LOCAL_AREA_SIZE = 3;

    if (point(1) <= LOCAL_AREA_SIZE) || (point(1) >= (size(img, 1) + 1 - LOCAL_AREA_SIZE)) || (point(2) <= LOCAL_AREA_SIZE) || (point(2) >= (size(img, 2) + 1 - LOCAL_AREA_SIZE))
        result = false;
        return;
    end
    
    local_area = img((point(1) - LOCAL_AREA_SIZE):(point(1) + LOCAL_AREA_SIZE), (point(2) - LOCAL_AREA_SIZE):(point(2) + LOCAL_AREA_SIZE));
    point_value = local_area(LOCAL_AREA_SIZE + 1,LOCAL_AREA_SIZE + 1);
    local_area(LOCAL_AREA_SIZE + 1,LOCAL_AREA_SIZE + 1) = point_value + 1;
    
    result = all(local_area(:) > point_value);
end