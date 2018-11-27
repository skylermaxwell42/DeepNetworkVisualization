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
figure
while 1
   im = imresize(snapshot(cam), [256, 256]);
   figure(1)
   imshow(im)
   im_feats = extract_features(filter, im);
   figure(2)
   imshow(imresize(im_feats, [256, 256]));
end
clear('cam')