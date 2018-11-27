clear
clc
format compact
net = alexnet %calls alexnet
[I] = imread('peppers.png');
figure(1)
subplot(2,2,1)
imshow(I)
title('Original Image')

sz = size(I);
I = I(1:227,1:227,:);
subplot(2,2,2)
imshow(I)
title('Resized Image')

number_filter_weight=56;

alexnet_feats = alex_net_relu1_feats(net,I,number_filter_weight); %calls the get features
subplot(2,2,3)
imshow(alexnet_feats)
title('AlexNet ReLU1 Output(not normalized)')
w = net.Layers(2).Weights;


filter = w(:,:,:,number_filter_weight);
subplot(2,2,4)
im_feats = extract_features(filter, I);
activations = relu(im_feats);
imshow(activations)
title('Our Extracted Features (normalized)');

max = max(abs(filter(:)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%displaying grayscale and color of weights
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RW_original=(filter(:,:,1));
GW_original=(filter(:,:,2));
BW_original=(filter(:,:,3));
[RW,GW,BW,colormap_red,colormap_green,colormap_blue]=get_color_map(filter);

im= ones(11,11,3);
im(:,:,1) = colormap_red(:,:,1);
im(:,:,2) = colormap_green(:,:,2);
im(:,:,3) = colormap_blue(:,:,3);


figure(2)
subplot(3,3,[1,2,3])
imshow(im);
title('weights color mapping')
subplot(3,3,4)
imshow(RW_original, [-max max])
title('Red Grayscale')
subplot(3,3,5)
imshow(GW_original, [-max max])
title('Green Grayscale')
subplot(3,3,6)
imshow(BW_original, [-max max])
title('Blue Grayscale')
subplot(3,3,7)
imshow(colormap_red)
title('Red color map')
subplot(3,3,8)
imshow(colormap_green)
title('Green color map')
subplot(3,3,9)
imshow(colormap_blue)
title('Blue color map')


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

function [Im_feats] = alex_net_relu1_feats(net, I, filter_number) 
    sz = net.Layers(1).InputSize;    %scales the images size    
    Im_feats = activations(net, I, 3, 'OutputAs', 'channels');
    Im_feats = Im_feats(:,:, filter_number); %gets the features from the activation
end

function [result] = conv_block(filter, IMSLICE)
   image_slice=im2single(IMSLICE);
   sz = size(filter);
   result = 0;
   for HGT = 1:sz(1)
      for WID = 1:sz(2)
         for CH = 1:sz(3)
             result = result + filter(HGT, WID, CH) * image_slice(WID, HGT, CH);
         end
      end
   end
end

    

function [RW,GW,BW,colormap_red,colormap_green,colormap_blue] = get_color_map(filt)
RW=(filt(:,:,1));
GW=(filt(:,:,2));
BW=(filt(:,:,3));

stepsize=10;

min_val_red=min(min(RW));
max_val_red=max(max(RW));
 
min_val_green=min(min(GW));
max_val_green=max(max(GW));
 
min_val_blue=min(min(BW));
max_val_blue=max(max(BW));

minval=[min_val_red,min_val_green,min_val_blue];
maxval=[max_val_red,max_val_green,max_val_blue];

minimum=min(minval);
maximum=max(maxval);

Steps=(abs(minimum)+abs(maximum))/stepsize;
COL=1;
ROW=1;
i=1;

while(ROW<=11)
   while(COL<=11)
        if (minimum<=RW(ROW,COL) && RW(ROW,COL)<minimum+Steps)
            colormap_red(ROW,COL)=0.1;
        end
        if (minimum+Steps<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*2)
            colormap_red(ROW,COL)=0.2;
        end
        if (minimum+Steps*2<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*3)
            colormap_red(ROW,COL)=0.3;
        end
        if (minimum+Steps*3<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*4)
            colormap_red(ROW,COL)=0.4;
        end
        if (minimum+Steps*4<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*5)
            colormap_red(ROW,COL)=0.5;
        end
        if (minimum+Steps*5<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*6)
            colormap_red(ROW,COL)=0.6;
        end
        if (minimum+Steps*6<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*7)
            colormap_red(ROW,COL)=0.7;
        end
        if (minimum+Steps*7<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*8)
            colormap_red(ROW,COL)=0.8;
        end
        if (minimum+Steps*8<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*9)
            colormap_red(ROW,COL)=0.9;
        end
        if (minimum+Steps*9<RW(ROW,COL) && RW(ROW,COL)<=maximum)
            colormap_red(ROW,COL)=1;
        end
        COL=COL+1;
        i=i+1;
    end
    ROW=ROW+1;
    COL=1;
end
colormap_red(:,:,1) = [colormap_red];
colormap_red(:,:,2) = [zeros(11)];
colormap_red(:,:,3) = [zeros(11)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%finding green color mapping
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
COL=1;
ROW=1;
i=1;
while(ROW<=11)
   while(COL<=11)
        if (minimum<=GW(ROW,COL) && GW(ROW,COL)<minimum+Steps)
            colormap_green(ROW,COL)=0.1;
        end
        if (minimum+Steps<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*2)
            colormap_green(ROW,COL)=0.2;
        end
        if (minimum+Steps*2<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*3)
            colormap_green(ROW,COL)=0.3;
        end
        if (minimum+Steps*3<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*4)
            colormap_green(ROW,COL)=0.4;
        end
        if (minimum+Steps*4<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*5)
            colormap_green(ROW,COL)=0.5;
        end
        if (minimum+Steps*5<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*6)
            colormap_green(ROW,COL)=0.6;
        end
        if (minimum+Steps*6<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*7)
            colormap_green(ROW,COL)=0.7;
        end
        if (minimum+Steps*7<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*8)
            colormap_green(ROW,COL)=0.8;
        end
        if (minimum+Steps*8<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*9)
            colormap_green(ROW,COL)=0.9;
        end
        if (minimum+Steps*9<GW(ROW,COL) && GW(ROW,COL)<=maximum)
            colormap_green(ROW,COL)=1;
        end
        COL=COL+1;
        i=i+1;
    end
    ROW=ROW+1;
    COL=1;
end
colormap_green(:,:,2) = [colormap_green];
colormap_green(:,:,1) = [zeros(11)];
colormap_green(:,:,3) = [zeros(11)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%finding blue color mapping
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
COL=1;
ROW=1;
i=1;
while(COL<=11)
   while(ROW<=11)
        if (minimum<=BW(ROW,COL) && BW(ROW,COL)<minimum+Steps)
            colormap_blue(ROW,COL)=0.1;
        end
        if (minimum+Steps<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*2)
            colormap_blue(ROW,COL)=0.2;
        end
        if (minimum+Steps*2<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*3)
            colormap_blue(ROW,COL)=0.3;
        end
        if (minimum+Steps*3<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*4)
            colormap_blue(ROW,COL)=0.4;
        end
        if (minimum+Steps*4<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*5)
            colormap_blue(ROW,COL)=0.5;
        end
        if (minimum+Steps*5<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*6)
            colormap_blue(ROW,COL)=0.6;
        end
        if (minimum+Steps*6<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*7)
            colormap_blue(ROW,COL)=0.7;
        end
        if (minimum+Steps*7<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*8)
            colormap_blue(ROW,COL)=0.8;
        end
        if (minimum+Steps*8<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*9)
            colormap_blue(ROW,COL)=0.9;
        end
        if (minimum+Steps*9<BW(ROW,COL) && BW(ROW,COL)<=maximum)
            colormap_blue(ROW,COL)=1;
        end
        ROW=ROW+1;
        i=i+1;
    end
    COL=COL+1;
    ROW=1;
end
colormap_blue(:,:,3) = [colormap_blue];
colormap_blue(:,:,1) = [zeros(11)];
colormap_blue(:,:,2) = [zeros(11)];
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