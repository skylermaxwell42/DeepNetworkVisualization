function [Im_feats] = alex_net_relu1_feats(net, I, filter_number) 
    sz = net.Layers(1).InputSize;    %scales the images size    
    Im_feats = activations(net, I, 3, 'OutputAs', 'channels');
    Im_feats = Im_feats(:,:, filter_number); %gets the features from the activation
end
