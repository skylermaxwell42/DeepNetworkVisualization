clear
clc
format compact
addpath('utils/');

%% Funtion Imports
import conv_block.*
import extract_features.*
import relu.*
import load_images.*

%% Loading Fitlers
load('layer_1_weights.mat')

filt_num = input('Enter filter number to use: \n>');
filter = w(:, :, :, filt_num);

%% Setting Up WebCam
cam = webcam;
im_show_size = 256;
while 1
   im = imresize(snapshot(cam), [256, 256]);
   im_feats = extract_features(filter, im);
   subplot(1, 2, 1)
   imshow(imresize(im, [im_show_size, im_show_size]))  
   subplot(1, 2, 2)
   imshow(imresize(im_feats, [im_show_size, im_show_size]))
end
clear('cam')