close all;
clear all;
clc;

%reading image 
img=imread('brain19.jpg');

%convert image to black and white
bw=im2bw(img,0.7);
label=bwlabel(bw);

%regionprops measures a set of properties for each labelled region
stats=regionprops(label,'Solidity','Area');
density=[stats.Solidity];
area=[stats.Area];

%finding the area that has solidity>50%
high_dense_area=density>0.5;
max_area=max(area(high_dense_area));
tumor_label=find(area==max_area);

%ismember returns a vector of logical values of the same length as of label
tumor=ismember(label,tumor_label);

%performing morphological operation(dilation) for accuracy
se=strel('square',5);
tumor=imdilate(tumor,se);

figure(2);
subplot(1,3,1);
imshow(img,[]);
title('Brain');

subplot(1,3,2);
imshow(tumor,[]);
title('Tumor Alone');

%draw boundaries around the tumor
[B,L]=bwboundaries(tumor,'noholes');

subplot(1,3,3);
imshow(img,[]);
hold on
for i=1:length(B)
    plot(B{i}(:,2),B{i}(:,1), 'y' ,'linewidth',1.45);
    
    
    
end

title('Detected Tumor');
hold off;
    
