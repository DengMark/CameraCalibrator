%% Detect Checkerboard in a Set of Image Files
%% 
clear all
clc
file_path = 'D:\CameraCalibration\calibration_demo\101\';% 图像文件夹路径
img_path_list = dir(strcat(file_path,'*.bmp'));%获取该文件夹中所有png格式的图像
img_num = length(img_path_list);%获取图像总数量
allimage=cast([], 'uint8');
image_index = cell(img_num,3);
 for i=1:img_num
        image_name = img_path_list(i).name;% 图像名
        image =  imread(strcat(file_path,image_name));
        allimage(:, :, :, i) = image;
         image_index{i,1}=i;
       image_index{i,2}= image_name;
       image_index{i,3}=cast(image,'uint8');
 end

%%
% Detect calibration pattern in the images.
[imagePoints,boardSize,imagesUsed] = detectCheckerboardPoints(allimage);
squareSize = 30;
worldPoints = generateCheckerboardPoints(boardSize, squareSize);
%% 
for i = 1:img_num
    figure
  I = imshow(image_index{i,3});
  %subplot(2, 2, i);
  hold on;
  plot(imagePoints(:,1,i),imagePoints(:,2,i),'ro');
   hold on
    plot(imagePoints(1,1,i),imagePoints(1,2,i),'s',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b');
    hold on
    line([imagePoints(1,1,i) imagePoints(34,1,i)],[imagePoints(1,2,i) imagePoints(34,2,i)],...
        'Color','yellow','LineWidth',3);
    hold on
    line([imagePoints(1,1,i) imagePoints(3,1,i)],[imagePoints(1,2,i) imagePoints(3,2,i)],...
        'Color','green','LineWidth',3);
    title(image_index{i,2})
end 
%%
[cameraParams,imagesUsed,estimationErrors] = estimateCameraParameters(imagePoints,worldPoints);
showReprojectionErrors(cameraParams);
figure;
showExtrinsics(cameraParams);
drawnow;






