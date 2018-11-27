function [images] = load_images(full_path, num_images)

    S = dir(fullfile(full_path,'*.bmp')); % pattern to match filenames.
    for k = 1:numel(S)
        F = fullfile(full_path,S(k).name);
        I = imread(F);
        images(:, :, :, k) = I;
        S(k).data = I; % optional, save data.
        if k > num_images
           break 
        end
    end
end

