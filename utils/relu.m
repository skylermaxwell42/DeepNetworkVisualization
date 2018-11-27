function [im_activ] = relu(im_data)
    im_size = size(im_data);
    im_active = zeros(im_size);
    for HGT = 1:im_size(1)
        for WID = 1:im_size(2)
            if im_data(HGT, WID) >= 0
                im_activ(HGT, WID) = im_data(HGT, WID);
                
            else
                im_activ(HGT, WID) = 0;
            end    
        end
    end
end

