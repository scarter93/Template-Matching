function [] = Assignment1(image_name)
%Assignment1 template
%   image_name       Full path/name of the input image (e.g. 'Test Image (1).JPG')


%% Load the input RGB image
input = imread(image_name);

%% Create a gray-scale duplicate into grayImage variable for processing
grayImage = rgb2gray(input);
figure
imshow(grayImage)

%% List all the template files starting with 'Template-' ending with '.png'
% Assuming the images are located in the same directory as this m-file
% Each template file name is accessible by templateFileNames(i).name
templateFileNames = dir('Template-*.png');

%% Get the number of templates (this should return 13)
numTemplates = length(templateFileNames);

%% Set the values of SSD_THRESH and NCC_THRESH
SSD_THRESH = 200;
%% Initialize two output images to the RGB input image
[rows cols colorDepth]= size(grayImage);
matched = zeros(rows, cols);
position = zeros(13,2);
%% For each template, do the following
for i=1:1
    %% Load the RGB template image, into variable T 
    T = rgb2gray(imread(templateFileNames(i).name));
    figure
    imshow(T)
    %% Convert the template to gray-scale
    % grayImage = rgb2gray(T);
    %% Extract the card name from its file name (look between '-' and '.' chars)
    % use the cardName variable for generating output images
    cardNameIdx1 = findstr(templateFileNames(i).name,'-') + 1;
    cardNameIdx2 = findstr(templateFileNames(i).name,'.') - 1;
    cardName = templateFileNames(i).name(cardNameIdx1:cardNameIdx2); 
    
    
    
    %% Find the best match [row column] using Sum of Square Difference (SSD)
    [SSDrow, SSDcol] = SSD(grayImage, T, SSD_THRESH);
    display([SSDrow, SSDcol]);
    position(i,:) = [SSDrow, SSDcol];
    output = insertText(input,[SSDcol, SSDrow],'ace','FontSize',12,'BoxColor','yellow','BoxOpacity',0.4,'TextColor','white');
    figure
    imshow(output);
    % If the best match exists
    % overlay the card name on the best match location on the SSD output image                      
    % Insert the card name on the output images (use small font size, e.g. 6)
    % set the overlay locations to the best match locations, plus-minus a random integer   

    
    %% Find the best match [row column] using Normalized Cross Correlation (NCC)
    %[NCCrow, NCCcol] = NCC(grayImage, T, NCC_THRESH);
    
    % If the best match exists
    % overlay the card name on the best match location on the NCC output image                      
    % Insert the card name on the output images (use small font size, e.g. 6)
    % set the overlay locations to the best match locations, plus-minus a random integer   

        
    
end

%% Display the output images 



end

%% Implement the SSD-based template matching here
function [SSDrow, SSDcol] = SSD(grayImage, T, SSD_THRESH)
% inputs
%           grayImag        gray-scale image
%           T               gray-scale template
%           SSD_THRESH      threshold below which a match is accepted
% outputs
%           SSDrow          row of the best match (empty if unavailable)
%           SSDcol          column of the best match (empty if unavailable)

[rows cols colorDepth ] = size(grayImage);
display([rows cols colorDepth]);
[m n colorDepth ] = size(T);
sumCurrent = 0;
min = SSD_THRESH;
for row=1:rows-m
    for col=1:cols-n
        for i=1:m
            for j=1:n
                sumCurrent = sum(T(i,j) - grayImage(row+i,col+j).^2);
                if sumCurrent <= min
                    min = sumCurrent;
                    SSDrow = row;
                    SSDcol = col;
                end
            end
        end
    end
end

end

%% Implement the NCC-based template matching here
function [NCCrow, NCCcol] = NCC(grayImage, T, NCC_THRESH)
% inputs
%           grayImag        gray-scale image
%           T               gray-scale template
%           NCC_THRESH      threshold above which a match is accepted
% outputs
%           NCCrow          row of the best match (empty if unavailable)
%           NCCcol          column of the best match (empty if unavailable)


end
