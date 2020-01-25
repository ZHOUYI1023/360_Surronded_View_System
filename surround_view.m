addpath('images')
addpath('data')
addpath('output')
addpath('functions')
clear
clc
global img_size TexOrient
load model
global model
img_size = [1280, 720];
TexOrient = [-1, -1];
orientation = ["front", "right", "back", "left"];
fileID1 = fopen('output/bowl.c','w');
fprintf(fileID1, '#include<GLES2/gl2.h>\n');
fclose(fileID1);
fileID2 = fopen('output/bowl.py','w');
fprintf(fileID2, 'import numpy as np\n');
fclose(fileID2);

for i = 1:4
    %%
    orient = char(orientation(i));
    % generate local model
    eval(['P_local_',orient,' = model_generate(orient, i);']);
    % load undistorted image and new intrinsics
    eval(['[J, intrinsic_',orient,'] = load_image(orient);']);
    %%
    % homography
    eval(['H_',orient,'=get_homography(orient);']);
    % transformation
    eval(['T_',orient,' = get_transformation(H_',orient,', intrinsic_',orient,');']);
    %%
    % texture mapping
    eval(['P_img_',orient,' = texture_map(T_',orient,', P_local_',orient,', i);']); 
    % local model to global model
    eval(['P_global_',orient,' = local2global(P_local_',orient,',orient);']);
    % show results
    figure(1)
    hold on
    eval(['mesh(P_global_',orient,'.X,P_global_',orient,'.Y,P_global_',orient,'.Z)'])
    figure(3)
    subplot(2,2,i)
    hold on
    title(orient)
    imshow(J)
    eval(['plot(P_img_',orient,'.X, P_img_',orient,'.Y);']);
    %%
    % write to files
    eval(['save_to_c(P_global_',orient,', P_img_',orient,', orient);'])
    eval(['save_to_py(P_global_',orient,', P_img_',orient,', orient);'])
end
