clear
clc
format compact
addpath('utils/');

%% Funtion Imports
import conv_block.*
import extract_features.*
import relu.*
import load_images.*

%% Loading Images and Weight Data
load('layer_1_weights.mat')
images = load_images('/Users/maxwels2/Documents/Fall_2018/ELC433/final_project/DeepNetworkVisualization/images/', 10);


%% Filter and Plotting Images 
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

filter = w(:,:,:,56);
subplot(2,2,4)
im_feats = extract_features(filter, I);
activations = relu(im_feats);
imshow(activations)
title('Our Extracted Features');



