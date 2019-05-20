function output_image = sobel_op(image)

% Read information of input image
row = size(image,1);
col = size(image,2);
pixel_num = row*col;
gray_image = rgb2gray(image);

subplot(1,3,1);
imshow(image);
title('original');

%%
% Noise Reduction
nr = zeros(row + 2, col + 2);
for i = 2 : row + 1
    for j = 2 : col + 1
        nr(i,j) = gray_image(i - 1, j - 1);
    end
end

% Break down the image into 3x3 block and find the median of each block
% Replace the pixel value with the median
nr_image = zeros(row, col);
block = zeros(3,3);
for x = 1 : row
    for y = 1 : col
        for i = 1 : 3
            for j = 1 : 3
                q = x - 1;
                w = y -1;
                block((i - 1) * 3 + j) = nr(i + q, j + w);
            end
        end
        nr_image(x, y) = median(block(:));
    end
end

nr_image = uint8(nr_image);

%%
% Histogram Equalization
histogram = uint8(zeros(row, col));
frequency = zeros(256,1);
c = zeros(256,1);
pc = zeros(256,1);
output = zeros(256,1);

% Count how many times each value appears
for i = 1:row
    for j = 1:col
        frequency(image(i,j) + 1) = frequency(image(i,j) + 1) + 1;
    end
end

% Count the cumulative probability
sum = 0;
bin = 255;
for i = 1:256
    sum = sum + frequency(i);
    c(i) = sum;
    pc(i) = c(i)/pixel_num;
    output(i) = round(pc(i)*bin);
end

for i = 1:row
    for j = 1:col
        histogram(i,j) = output(nr_image(i,j) + 1);
    end
end

subplot(1,3,2);
imshow(histogram);
title('histogram equalization');

%%
% Sobel Operator
Gx = [-1 0 1;-2 0 2;-1 0 1];
Gy = [-1 -2 -1;0 0 0;1 2 1];
sobel = double(histogram);
sobel_output = histogram;

for i = 2:row - 1
    for j = 2:col - 1
        
        temp = sobel(i - 1 : i + 1, j - 1 : j + 1);
        a = Gx.* temp;
        b = Gy.* temp;
        x = 0;
        y = 0;
        for k = 1:9
           x = x + a(k);
           y = y + b(k);
        end
        
        pixValue =sqrt(x.^2 + y.^2);
        sobel_output(i, j) = pixValue;
        
    end
end

%%
% Noise Reduction
nr = zeros(row + 2, col + 2);
for i = 2 : row + 1
    for j = 2 : col + 1
        nr(i,j) = sobel_output(i - 1, j - 1);
    end
end

% Break down the image into 3x3 block and find the median of each block
% Replace the pixel value at the center of block with the median
output_image = zeros(row, col);
block = zeros(3,3);
for x = 1 : row
    for y = 1 : col
        for i = 1 : 3
            for j = 1 : 3
                q = x - 1;
                w = y -1;
                block((i - 1) * 3 + j) = nr(i + q, j + w);
            end
        end
        output_image(x, y) = median(block(:));
    end
end

subplot(1,3,3);
output_image = uint8(output_image);
imshow(output_image);
title('sobel operator');

