clear
clc
format compact

addpath('utils/');
import get_color_map.*
import conv_block.*
import extract_features.*
import load_images.*
import relu.*

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




function [Im_feats] = alex_net_relu1_feats(net, I, filter_number) 
    sz = net.Layers(1).InputSize;    %scales the images size    
    Im_feats = activations(net, I, 3, 'OutputAs', 'channels');
    Im_feats = Im_feats(:,:, filter_number); %gets the features from the activation
end



    