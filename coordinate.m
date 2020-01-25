clear
clc
img_front = rgb2gray(imread('front_undistort.bmp'));
figure(1)
imshow(img_front)
img_left = rgb2gray(imread('left_undistort.bmp'));
figure(2)
imshow(img_left)
img_back = rgb2gray(imread('back_undistort.bmp'));
figure(3)
imshow(img_back)
img_right = rgb2gray(imread('right_undistort.bmp'));
figure(4)
imshow(img_right)



% %modularize
% 
% 
% %% front
% clear
% load model.mat
% img_front = rgb2gray(imread('front_undistort.bmp'));
% [imagePoints_front,~] = detectCheckerboardPoints(img_front);
% cornerPoints_front = [173,502;288,510;1142,558;927,460;1034,462];
% pt_img = [imagePoints_front';ones(1,size(imagePoints_front,1))];
% corner_img = [cornerPoints_front';ones(1,size(cornerPoints_front,1))];
% ind = 1;
% for i = 1:6
%     for j = 1:4
%         pt_world(1,ind) = 45 + (i-1)*20 - 198.4/2;
%         pt_world(2,ind) = 219 -(j-1)*20;
%         pt_world(3,ind) = 1;
%         ind = ind + 1;
%     end
% end
% ind = 1;
% corner_world(1,ind) = 25 - 198.4/2 - 49.5 -89.5 + 20;
% corner_world(2,ind) = 139 +20;
% corner_world(3,ind) = 1;
% ind = ind + 1;
% corner_world(1,ind) = 25 - 198.4/2 - 49.5 -20;
% corner_world(2,ind) = 139 +20;
% corner_world(3,ind) = 1;
% ind = ind + 1;
% corner_world(1,ind) = 25 - 198.4/2 + 140 + 49.5 + 20;
% corner_world(2,ind) = 139 + 20;
% corner_world(3,ind) = 1;
% ind = ind + 1;
% corner_world(1,ind) = 25 - 198.4/2 + 140 + 49.5 + 20;
% corner_world(2,ind) = 139 + 100 - 40;
% corner_world(3,ind) = 1;
% ind = ind + 1;
% corner_world(1,ind) = 25 - 198.4/2 + 140 + 49.5 + 89.5 -20;
% corner_world(2,ind) = 139 + 100 - 40;
% corner_world(3,ind) = 1;
% 
% pt_world_global = pt_world + [0;275;0];
% figure(1)
% hold on
% plot(pt_world_global(1,:),pt_world_global(2,:),'rx-')
% save points_front.mat pt_img pt_world
% %% left
% clear
% img_left = imread('left_undistort.bmp');
% [imagePoints_left,~] = detectCheckerboardPoints(img_left);
% % imagePoints_left = [642,298;642,318;642,340;642,368;
% % 667,293;668,315;670,339;672,366;
% % 693,290;695,312;698,336;706,364;
% % 1169,313;1075,241;1165,231
% % ];
% figure
% imshow(img_left)
% hold on
% plot(imagePoints_left(:,1),imagePoints_left(:,2),'rx')
% pt_img = [imagePoints_left';ones(1,size(imagePoints_left,1))];
% ind = 1;
% for i = 1:6
%     for j = 1:4
%         pt_world(1,ind) = 275/2 - 163 + (i-1)*20;
%         pt_world(2,ind) = 99 -(j-1)*20;
%         pt_world(3,ind) = 1;
%         ind = ind + 1;
%     end
% end
% % pt_world(1,ind) = 275/2 + 139 + 20;
% % pt_world(2,ind) = -25 + 49.5 +20;
% % pt_world(3,ind) = 1;
% % ind = ind + 1;
% % pt_world(1,ind) = 275/2 + 139 + 20;
% % pt_world(2,ind) = -25 + 49.5 + 89.5 -20;
% % pt_world(3,ind) = 1;
% % ind = ind + 1;
% % pt_world(1,ind) = 275/2 + 139 + 100 - 40;
% % pt_world(2,ind) = -25 + 49.5 + 89.5 -20;
% % pt_world(3,ind) = 1;
% 
% 
% pt_world_global = [-pt_world(2,:)- 198.4/2;pt_world(1,:)+ 275/2];
% figure(2)
% hold on
% plot(pt_world_global(1,:),pt_world_global(2,:),'rx-')
% save points_left.mat pt_img pt_world
% %% right
% clear
% img_right = imread('right_undistort.bmp');
% [imagePoints_right,~] = detectCheckerboardPoints(img_right);
% % imagePoints_right = [];
% imagePoints_right = [imagePoints_right;12,259;137,277;151,195;245,211];
% imagePoints_right = [imagePoints_right;968,385;993,388;936,340;960,343];
% figure(1)
% subplot(2,2,3)
% imshow(img_right)
% hold on
% plot(imagePoints_right(:,1),imagePoints_right(:,2),'rx')
% pt_img = [imagePoints_right';ones(1,size(imagePoints_right,1))];
% ind = 1;
% for i = 1:6
%     for j = 1:4
%         pt_world(1,ind) = 70 + (i-1)*20 - 275/2;
%         pt_world(2,ind) = 106 -(j-1)*20;
%         pt_world(3,ind) = 1;
%         ind = ind + 1;
%     end
% end
% pt_world(1,ind) = - 139 - 275/2 - 100 + 40;
% pt_world(2,ind) = -198.4/2 + 25 + 140 -198.4/2 + 49.5 +20;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% pt_world(1,ind) = - 139 - 275/2 - 20;
% pt_world(2,ind) = -198.4/2 + 25 + 140 -198.4/2 + 49.5 +20;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% pt_world(1,ind) = - 139 - 275/2 - 100 + 40;
% pt_world(2,ind) = -198.4/2 + 25 + 140 -198.4/2 + 49.5 + 89.5 -20;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% pt_world(1,ind) = - 139 - 275/2 - 20;
% pt_world(2,ind) =  -198.4/2 + 25 + 140 -198.4/2 + 49.5 + 89.5 -20;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% 
% pt_world(1,ind) = 130 + 275/2 + 20;
% pt_world(2,ind) = -198.4/2 + 16 + 140 -198.4/2 + 49.5 +20;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% pt_world(1,ind) = 130 + 275/2 + 100 -40;
% pt_world(2,ind) = -198.4/2 + 16 + 140 - 198.4/2 + 49.5 +20;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% pt_world(1,ind) = 130 + 275/2 + 20;
% pt_world(2,ind) = -198.4/2 + 16 + 140 -198.4/2 + 49.5 + 89.5 -20;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% pt_world(1,ind) = 130 + 275/2 + 100 -40;
% pt_world(2,ind) =  -198.4/2 + 16 + 140 -198.4/2 + 49.5 + 89.5 -20;
% pt_world(3,ind) = 1;
% 
% pt_world(2,:) = pt_world(2,:)+15;
% pt_world_global = [pt_world(2,:)+ 198.4/2;-pt_world(1,:)+ 275/2];
% figure(2)
% hold on
% plot(pt_world_global(1,:),pt_world_global(2,:),'bx')
% save points_right.mat pt_img pt_world
% %% back
% clear
% img_back = imread('back_undistort.bmp');
% [imagePoints_back,~] = detectCheckerboardPoints(img_back);
% % imagePoints_back = [];
% imagePoints_back = [imagePoints_back;376,394;447,395;428,355;483,356];
% imagePoints_back = [imagePoints_back;845,399;917,399;806,358;865,358];
% figure(1)
% subplot(2,2,4)
% imshow(img_back)
% hold on
% plot(imagePoints_back(:,1),imagePoints_back(:,2),'rx')
% pt_img = [imagePoints_back';ones(1,size(imagePoints_back,1))];
% ind = 1;
% for i = 1:6
%     for j = 1:4
%         pt_world(1,ind) = -136 + (i-1)*20 + 198.4/2;
%         pt_world(2,ind) = 210 -(j-1)*20;
%         pt_world(3,ind) = 1;
%         ind = ind + 1;
%     end
% end
% pt_world(1,ind) =-16 + 198.4/2 - 140 - 49.5 -89.5 + 20;
% pt_world(2,ind) = 130 + 20;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% pt_world(1,ind) = -16 + 198.4/2 - 140 - 49.5 - 20;
% pt_world(2,ind) = 130 + 20;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% pt_world(1,ind) = -16 + 198.4/2 - 140 - 49.5 -89.5 + 20;
% pt_world(2,ind) = 130 + 100 - 40;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% pt_world(1,ind) = -16 + 198.4/2 - 140 - 49.5 - 20;
% pt_world(2,ind) = 130 + 100 - 40;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% 
% pt_world(1,ind) = -16 + 198.4/2 + 49.5  + 20;
% pt_world(2,ind) = 130 + 20;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% pt_world(1,ind) = -16 + 198.4/2 + 49.5 + 89.5 - 20;
% pt_world(2,ind) = 130 + 20;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% pt_world(1,ind) =  -16 + 198.4/2 + 49.5  + 20;
% pt_world(2,ind) = 130 + 100 - 40;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% pt_world(1,ind) =  -16 + 198.4/2 + 49.5 + 89.5 - 20;
% pt_world(2,ind) = 130 + 100 - 40;
% pt_world(3,ind) = 1;
% ind = ind + 1;
% save points_back.mat pt_img pt_world
% 
% pt_world_global = -pt_world;
% figure(2)
% hold on
% plot(pt_world_global(1,:),pt_world_global(2,:),'rx')
% axis equal
% 
% 
% 
% function pt_img = detect_points(img)
% [imagePoints,~] = detectCheckerboardPoints(img);
% pt_img = [imagePoints';ones(1,size(imagePoints,1))];
% end