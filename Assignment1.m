function [] = Assignment1(image_name)
%Assignment1 template
%   image_name       Full path/name of the input image (e.g. 'Test Image (1).JPG')


%% Load the input RGB image

%% Create a gray-scale duplicate into grayImage variable for processing

%% List all the template files starting with 'Template-' ending with '.png'
% Assuming the images are located in the same directory as this m-file
% Each template file name is accessible by templateFileNames(i).name
templateFileNames = dir('Template-*.png');

%% Get the number of templates (this should return 13)
numTemplates = length(templateFileNames);

%% Set the values of SSD_THRESH and NCC_THRESH

%% Initialize two output images to the RGB input image

%% For each template, do the following
for i=1:numTemplates
    %% Load the RGB template image, into variable T 
    
    %% Convert the template to gray-scale
    
    %% Extract the card name from its file name (look between '-' and '.' chars)
    % use the cardName variable for generating output images
    cardNameIdx1 = findstr(templateFileNames(i).name,'-') + 1;
    cardNameIdx2 = findstr(templateFileNames(i).name,'.') - 1;
    cardName = templateFileNames(i).name(cardNameIdx1:cardNameIdx2); 
    
    %% Find the best match [row column] using Sum of Square Difference (SSD)
    [SSDrow, SSDcol] = SSD(grayImage, T, SSD_THRESH);
    
    % If the best match exists
    % overlay the card name on the best match location on the SSD output image                      
    % Insert the card name on the output images (use small font size, e.g. 6)
    % set the overlay locations to the best match locations, plus-minus a random integer   

    
    %% Find the best match [row column] using Normalized Cross Correlation (NCC)
    [NCCrow, NCCcol] = NCC(grayImage, T, NCC_THRESH);
    
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
