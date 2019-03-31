
% Load images
% Note that images are already rectified from calibrated camera, i.e.
% epipolar lines are parallel in both left and right images.
% Each row in the image is the corresponding epipolar line in the other.
% The suffix is misleading. They are NOT pgm images. 
% -----------------------------------------------------------
left_image = imread('shaft3rec.l.pgm');
right_image = imread('shaft3rec.r.pgm');

% Find the edges ( like this for instance, but however you like)
% -------------------------------------------------------------
left_edge_image = edge(left_image,'sobel');
right_edge_image = edge(right_image,'sobel');

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
title('Left Edge Image');
subplot(2,2,4);
imagesc(right_edge_image);
axis image, axis off, colormap gray;
title('Right Edge Image');


% Now do the matching ( a basic understanding of Matlab is needed here )
% disparity matrix concatenation - i.e. append [left_coords, disparities] to
% the existing array_of_disparities
% -----------------------------------------------------------------------
num_rows = size(left_image,1);
num_cols = size(right_image,2);
array_of_disparities2 = []; 
disparity_array_after_SAD = [];

for r = 1:num_rows
	left_edge_pixels = find(left_edge_image(r,:));
    if left_edge_pixels ~= 0
        s = sprintf('edge points found in row %d', r);
        % debug info to make sure window size does not exceed img boundary
        disp(s);
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
        % L: for a 5x5 window, this is the distance from window edge to
        % the centre. Assuming square window
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
                    tmp_row = [tmp_row, right_image(k2, k3)];
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
        % incorporate sum of absolute difference in the array
        left_coords = [left_coords, SAD_vector'];
		array_of_disparities2 = [array_of_disparities2; [left_coords, disparities]];        
	end
end

% Display the table of candidate matches
% --------------------------------------
array_of_disparities2;




