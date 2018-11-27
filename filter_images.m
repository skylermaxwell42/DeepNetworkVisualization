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

filt_num = input('Enter the filter index to analyze: \n>');
filter = w(:,:,:,filt_num);
filter_upsample = imresize(filter, [256 256]);

for IMG_IDX = 1:length(images)-1
    im = images(:, :, :, IMG_IDX);
    im_feats = extract_features(filter, im);
    im_feats_upsample = imresize(im_feats, [256, 256]);
    
    f = figure('visible','off');
    subplot(1, 3, 1)
    imshow(im)
    title('Original Image')
    subplot(1, 3, 2)
    imshow(filter)
    title('Filter')
    subplot(1, 3, 3)
    imshow(im_feats)
    title('Extracted Features')
    file_name = sprintf('results/test_%0d.jpg', IMG_IDX);
    saveas(f, file_name)
end




