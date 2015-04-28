% Reset
close all
clear
clc

% Read image
test_image = imread('t3.jpg');

% Transform to grayscale
test_image_gray = rgb2gray(test_image);
figure; imshow(test_image_gray);

% Transform to black and white
% TODO: Change to local threshold
test_image_gray_threshold = graythresh(test_image_gray); % Get an appropriate threshold
test_image_bw = im2bw(test_image_gray, test_image_gray_threshold);
figure; imshow(test_image_bw);

% TODO: Add opening and closing

% Detect edge with canny
test_image_edge = edge(test_image_bw, 'canny');
figure; imshow(test_image_edge);

% Detect boundaries
boundaries = bwboundaries(test_image_edge);

% Draw objects
objects = [];
figure; imshow(test_image_edge); hold on;

for i = 1:length(boundaries)
    boundary = boundaries{i};
    
    boundary_bound = [...
        min(boundary(:, 2)),... % X
        min(boundary(:, 1)),... % Y
        max(boundary(:, 2)) - min(boundary(:, 2)),... % Width
        max(boundary(:, 1)) - min(boundary(:, 1))... % Height
    ];
    
    objects = [objects; boundary_bound];
    rectangle('Position', boundary_bound, 'EdgeColor', 'y'); % Draw rectangle
end

% Draw characters
characters = [];
figure; imshow(test_image); hold on;

for i = 1:length(objects)
    object = objects(i, :);
    character_x = object(1);
    character_y = object(2);
    character_width = object(3);
    character_height = object(4);
    
    if character_width < character_height % TODO: Add more conditions
        characters = [characters; object];
        rectangle('Position', object, 'EdgeColor', 'g');
    end
end

[size(objects, 1), size(characters, 1), size(objects, 1) - size(characters, 1)]