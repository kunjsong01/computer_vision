close all

% Load images
% Note that images are already rectified from calibrated camera, i.e.
% epipolar lines are parallel in both left and right images.
% Each row in the image is the corresponding epipolar line in the other.
% The suffix is misleading. They are NOT pgm images. 
% -----------------------------------------------------------
left_image = imread('left.pgm');
right_image = imread('right.pgm');

% Find the edges ( like this for instance, but however you like)
% -------------------------------------------------------------
%s = 'sobel';
s = 'Canny';
left_edge_image = edge(left_image, s);
right_edge_image = edge(right_image, s);

% Display everything
% ------------------
figure(1);
subplot(2,2,1);
imagesc(left_image);
axis image, axis off, colormap gray;
title('Left Image');
subplot(2,2,2);
imagesc(right_image);
axis image, axis off, colormap gray;
title('Right Image');

subplot(2,2,3);
imagesc(left_edge_image);
axis image, axis off, colormap gray;
L_edge_title = sprintf('Left Edge Image - detector %s', s);
title(L_edge_title);
subplot(2,2,4);
imagesc(right_edge_image);
axis image, axis off, colormap gray;
R_edge_title = sprintf('Left Edge Image - detector %s', s);
title(R_edge_title);

% Now do the matching ( a basic understanding of Matlab is needed here )
% disparity matrix concatenation - i.e. append [left_coords, disparities] to
% the existing array_of_disparities
% -----------------------------------------------------------------------
num_rows = size(left_image,1);
num_cols = size(right_image,2);
array_of_disparities = [];
new_array_of_disparities = [];
best_disparity = [];
L = 0;
for r = 1:num_rows
	left_edge_pixels = find(left_edge_image(r,:));
    if left_edge_pixels ~= 0
        debug_s = sprintf('edge points found in row %d', r);
        % debug info to make sure window size does not exceed img boundary
        disp(debug_s);
    end
    % process each edge point in Left image
	for i = left_edge_pixels
		i1 = find(right_edge_image(r,:));
		disparities = (i1 - i)';
		num_matches = size(disparities,1);
        % assert helps to check the size match
        assert(num_matches == size(i1, 2));
        
        % vector to hold sum of absolute difference values for each points
        SAD_vector = [];
        
        % apply correspondence algorithm on edge point
        % add an SAD column in the array_of_disparities. Method: 
        % use a 3x3 window to calculate SAD in the right image
        % This is to find the correspondence between the left and right
        % edge points
        % L: this is the distance from window edge to the centre. Assuming square window
        %    e.g. L = 2 for a 5x5 window, 
        L = 3; % if using 2, too many minimal SAD values
        left_window = [];
        % construct left window
        for j = drange(r-L, r+L)
            tmp_row = [];
            for k = drange(i-L, i+L)
                tmp_row = [tmp_row, left_image(j, k)];
            end
            left_window = [left_window; tmp_row];
        end
        assert(size(left_window, 1) == size(left_window, 2)); % assert left window shape
        assert(size(left_window, 1) == (1+2*L)); % assert right window size
        % compare left window with each right window centered at right edge point
        for j2 = i1
            right_window = [];
            for k2 = drange(r-L, r+L)
                tmp_row = [];
                for k3 = drange(j2-L, j2+L)
                    % check out of boundary cases and copy and extend the boundaries if exceed
                    x = k3;
                    if k3 < 1
                        x = 1;
                    end
                    if k3 > size(right_image, 2)
                        x = size(right_image, 2);
                    end
                    tmp_row = [tmp_row, right_image(k2, x)];
                end
                right_window = [right_window; tmp_row];
            end
            % assert right window matrix before calculating SAD
            assert(isequal(size(left_window), size(right_window)));
            % compare each right window (edge point centered) with left window
            difference = right_window - left_window;
            absolute_diff = abs(difference);
            SAD_value = sum(absolute_diff(:));
            SAD_vector = [SAD_vector, SAD_value];
        end
        
        % copy [i, r] repeatedly in num_matches rows and 1 column
		left_coords = repmat([i,r],num_matches,1);
		array_of_disparities = [array_of_disparities; [left_coords, disparities]];
        % incorporate sum of absolute difference in the array
        left_coords = [left_coords, SAD_vector'];
        new_array_of_disparities = [new_array_of_disparities; [left_coords, disparities]];
        
        % select best disparities based on correspondence level for each
        % edge point
        SAD_column = left_coords(:, 3:3);
        SAD_min = min(SAD_column(:)');
        SAD_min_idx = find(SAD_column == SAD_min);
        disp(SAD_min_idx');
        % assert disparity and SAD vector boundary before calc
        assert(size(disparities, 1) == size(SAD_column, 1));
        average_min_disparity = round(mean(disparities(SAD_min_idx')));
        best_disparity = [best_disparity; [i, r, SAD_min, average_min_disparity]];
    end 
end

% edge points depth calculation
% Z = 1/(k+disparity) where k is an arbitary constant
% --------------------------------------
object_edge = best_disparity(:, 1:2);
k = 1; % change k to find best reconstruction
tmp_depth = [];
disparity_column = best_disparity(:, 4:4);
for i = drange(1, size(disparity_column,1))
    depth = 1 / (k + disparity_column(i));
    tmp_depth = [tmp_depth, depth];
end
assert(size(tmp_depth, 2) == size(object_edge, 1));
object_edge = [object_edge, tmp_depth'];


% 3D reconstruction using edge points with depth in scatter plot
% need to apply real world depth using focal length
% --------------------------------------
world_depth = object_edge(:, 3).*(17/(0.11/2));
object_edge = [object_edge, world_depth];
figure(2);
plot3(object_edge(:, 1), object_edge(:, 2), object_edge(:,4), '.', 'MarkerSize', 5)
recon_title = sprintf('reconstructed 3D object - correspondence using %s for edge detection and window size %d', s, L);
title(recon_title)
axis equal





