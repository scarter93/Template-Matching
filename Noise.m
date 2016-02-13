function [] = Noise(image_name)
%Assignment1 template
%   image_name       Full path/name of the input image (e.g. 'Test Image (1).JPG')


%% Load the input RGB image
input = imread(image_name);

%% Create a gray-scale duplicate into grayImage variable for processing
var = [0.01,0.03,0.05,0.1,0.3,0.5,0.8,1.0,1.5,2.0]
result_ssd = zeros(13,10);
result_ncc = zeros(13,10);
%% List all the template files starting with 'Template-' ending with '.png'
% Assuming the images are located in the same directory as this m-file
% Each template file name is accessible by templateFileNames(i).name
templateFileNames = dir('Template-*.png');

%% Get the number of templates (this should return 13)
numTemplates = length(templateFileNames);

%% Set the values of SSD_THRESH and NCC_THRESH
SSD_THRESH = intmax; %can be changed depending on image
NCC_THRESH = intmin; % can be changed depending on images
%% Initialize two output images to the RGB input image

position = zeros(13,2);
%use a hardcoded CELL for the names
names = {['ACE']; ['EIGHT'];['FIVE']; ['FOUR']; ['JACK']; ['KING']; ['NINE']; ['Queen']; ['Seven']; ['SIX']; ['TEN']; ['Three']; ['Two']};
%% For each template, do the following
for j=1:1
grayImage = rgb2gray(imnoise(input,'Gaussian',0,1.5));
figure
imshow(grayImage)
for i=1:numTemplates
    %% Load the RGB template image, into variable T 
    T = rgb2gray(imread(templateFileNames(i).name));
%     figure
%     imshow(T)
    %% Convert the template to gray-scale

    %% Extract the card name from its file name (look between '-' and '.' chars)
    % use the cardName variable for generating output images
    cardNameIdx1 = findstr(templateFileNames(i).name,'-') + 1;
    cardNameIdx2 = findstr(templateFileNames(i).name,'.') - 1;
    cardName = templateFileNames(i).name(cardNameIdx1:cardNameIdx2); 
    
    
    
    %% Find the best match [row column] using Sum of Square Difference (SSD)

%% uncomment for SSD/ comment for NCC    
    
     [SSDrow, SSDcol, SSD_val] = SSD(int32(grayImage), int32(T));
     display(SSD_val);
     results_ssd(i,j) = SSD_val;
%      if SSDcol == 0 && SSDrow == 0
%          SSDrow = 25*i;
%      else
%          SSDcol = SSDcol + randi(40);
%          SSDrow = SSDrow + randi(40);
%      end
     position(i,:) = [SSDcol, SSDrow];
   
    
    %% Find the best match [row column] using Normalized Cross Correlation (NCC)

%% uncomment for NCC/ comment for SSD    
 
%     [NCCrow, NCCcol, NCC_val] = NCC(int32(grayImage), int32(T));
%     display(NCC_val);
%     results_ncc(i,j) = NCC_val;
    
    
%     if NCCcol == 0 && NCCrow == 0
%         NCCrow = 25*i;
%     else
%         NCCcol = NCCcol + randi(40);
%         NCCrow = NCCrow + randi(40);
%     end
%     position(i,:) = [NCCcol, NCCrow];

        
end    
end

%% Display the output images 
 output = insertText(input,position,names,'FontSize',12,'BoxColor','yellow','BoxOpacity',0.4,'TextColor','white');
 figure
 imshow(output);
results_ssd
results_ncc
results_mean_ssd = zeros(10,1);
results_mean_ncc = zeros(10,1);
for i=1:10
    results_mean_ssd(i) = mean(results_ssd(:,i));
    results_mean_ncc(i) = mean(results_ncc(:,i));
end

results_mean_ssd
results_mean_ncc

end



%% Implement the SSD-based template matching here
function [SSDrow, SSDcol, SSD_val] = SSD(grayImage, T)
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
display([m n colorDepth]);
sumCurrent = 0;
SSDrow = 0;
SSDcol = 0;
min = intmax;
for row=1:rows-m+1
    for col=1:cols-n+1
        grayImageSection = grayImage(row:(row+m-1), col:(col+n-1));
        sumCurrent = sum(sum((T - grayImageSection).^2)); 
        if sumCurrent <= min
                    min = sumCurrent;
                    SSDrow = row;
                    SSDcol = col;
        end
        %sumCurrent = 0;
    end
end
SSD_val = min;
end

%% Implement the NCC-based template matching here
function [NCCrow, NCCcol, NCC_val] = NCC(grayImage, T)
% inputs
%           grayImag        gray-scale image
%           T               gray-scale template
%           NCC_THRESH      threshold above which a match is accepted
% outputs
%           NCCrow          row of the best match (empty if unavailable)
%           NCCcol          column of the best match (empty if unavailable)
[rows cols colorDepth ] = size(grayImage);
display([rows cols colorDepth]);
[m n colorDepth ] = size(T);
display([m n colorDepth]);
sumCurrent = 0;
NCCrow = 0;
NCCcol = 0;
max = intmin;
for row=1:rows-m+1
    for col=1:cols-n+1
        grayImageSection = grayImage(row:(row+m-1), col:(col+n-1));
        T_norm = T - mean2(T);
        grayImage_norm = grayImageSection - mean2(grayImageSection);
        top = sum(sum(T_norm .* grayImage_norm));
        bot = sum(sum(T_norm .^2)) * sum(sum(grayImage_norm .^2));
        sumCurrent = top/sqrt(bot);
        if sumCurrent >= max
                max = sumCurrent;
                NCCrow = row;
                NCCcol = col;
        end
    end
end
NCC_val = max;

end

