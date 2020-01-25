function [img, intrinsics] = load_image(str)
load(char(strcat('intrinsic_',str,'.mat')));%intrinsic
%% option 1 read image and table, do undistortion
% img_original = rgb2gray(imread(char(strcat(str,'.bmp'))));
%% option 2 directly read the intrinsic and unditorted image
img = rgb2gray(imread(char(strcat(str,'_undistort.bmp'))));
end