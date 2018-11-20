clear
clc
format compact
net = alexnet %calls alexnet
I = imread('peppers.png');
sz = size(I);
I = I(1:227,1:227,:);
alexnet_feats = alex_net_relu1_feats(net,I,56); %calls the get features
figure(1)
title("AlexNet ReLU1 Output")
imshow(alexnet_feats)

w = net.Layers(2).Weights;

%imshow(mean_color(w(:,:,:, 56)))

filter = w(:,:,:,56);
figure(2)
title("Our Extracted Features");
im_feats = extract_features(filter, I);
activations = relu(im_feats);
imshow(activations)

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
            im_feats(output_j, output_i) = conv_block(filter, 
im2single(im_slice));
            output_i = output_i + 1;
        end
        output_j = output_j + 1;
        output_i = 1;
    end
end

function [Im_feats] = alex_net_relu1_feats(net, I, filter_number) 
    sz = net.Layers(1).InputSize;    %scales the images size    
    Im_feats = activations(net, I, 3, 'OutputAs', 'channels');
    Im_feats = Im_feats(:,:, filter_number); %gets the features from the 
activation
end

function [result] = conv_block(filter, IMSLICE)
   image_slice=im2single(IMSLICE);
   sz = size(filter);
   result = 0;
   for HGT = 1:sz(1)
      for WID = 1:sz(2)
         for CH = 1:sz(3)
             result = result + filter(HGT, WID, CH) * image_slice(WID, 
HGT, CH);
         end
      end
   end
end


function [filter_norm] = mean_color(filter)
    %Step_size=(max-min)/256;

    for CH = 1:length(filter(1,1,:)) %incrementing channels
        CH
        min_val = min(min(filter(:,:, CH), [], 2), [], 1)
        max_val = max(max(filter(:,:, CH), [], 2), [], 1);

        for ROW = 1:length(filter(:, 1, 1))
            for COL = 1:length(filter(1, :, 1))
                val = filter(COL, ROW, CH);
                if val == 0
                    norm_val = 128;
                end
                if val < 0
                    norm_val = ((val/(abs(min_val))*128)+128);
                end
                if val > 0
                    norm_val = ((val/(abs(max_val))*128)+128);
                end
                filter_norm(COL, ROW, CH) = norm_val;
            end
        end

    end

    % i=0;
    % while(i<256)
    %     if(i1<filter(i))
    %         filter(i)=
    %     
    % end



end

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
