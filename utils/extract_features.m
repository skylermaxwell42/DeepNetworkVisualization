function [im_feats] = extract_features(filter, I)
    stride = 4;
    filt_size = size(filter);
    output_shape = ((227 - filt_size(1))/4) + 1;
    im_feats = zeros(output_shape, output_shape);
    im_size = size(I);
    
    output_i = 1;
    output_j = 1;
    for j_idx = (6):stride:227-5
        for i_idx =  6:stride:227-5
            im_slice = I(j_idx-5:j_idx+5, i_idx-5:i_idx+5, :);
            im_feats(output_j, output_i) = conv_block(filter, im2single(im_slice));
            output_i = output_i + 1;
        end
        output_j = output_j + 1;
        output_i = 1;
    end
end

