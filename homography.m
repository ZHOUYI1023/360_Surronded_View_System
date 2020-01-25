clear
%% write the optimizer
%%
%showExtrinsics(cameraParams,'patternCentric');
%% cordinates
addpath('images')
addpath('data')
global model
load model
top_left = [-59.5+20,262-10;-119,122;-59.5-15,207-55;-63.5+40,149.5-50];
orientation = ["front", "right", "back", "left"];
figure(2)
hold on
rectangle('Position',[-model.wheel_width/2, 0.2*model.wheel_length, model.wheel_width, 0.8*model.wheel_length+model.car_length_front], 'FaceColor', [0 0 0],'Curvature',0.5)
rectangle('Position',[-model.wheel_width/2, -model.car_length_back, model.wheel_width, 0.8*model.wheel_length], 'FaceColor', [0 0 0],'Curvature',0.5)
rectangle('Position',[-model.wheel_width/2, 0, model.wheel_width, model.wheel_length], 'FaceColor', [0 0 0])
axis equal
for i = 1:4
    orient = char(orientation(i));
    str = [orient,'_undistort.bmp'];
    eval(['img_',orient,' = imread(str);']);
    eval(['[imagePoints,~] = detectCheckerboardPoints(img_',orient,');']);
    figure(1)
    subplot(2,2,i)
    eval(['imshow(img_',orient,')']);
    hold on
    plot(imagePoints(:,1),imagePoints(:,2),'rx')
    pt_img = [imagePoints';ones(1,size(imagePoints,1))];
    pt_world  = getCalibMap(top_left(i,:),orient);
    eval(['save points_',orient,'.mat pt_img pt_world']);
    eval(['H_',orient,' = get_homography(pt_world, pt_img);']);
end

%% corner for validation
% manually mark the four corner points in each side
corner_top_left = [top_left(1,:)+[-157,19.5];
    top_left(1,:)+[166.5,19.5];
    top_left(3,:)+[-157,19.5];
    top_left(3,:)+[166.5,19.5]];
corner_orient = ["front_l", "front_r", "back_l", "back_r"];
corner_side_orient = ["left","right","right","left"];
x_intervals = [0;19.5;68.5;88];
x_diff = [0;19.5;49;19.5];
y_intervals = [0;39.5;79;98.5];
y_diff = [0;39.5;39.5;19.5];
figure(3)
subplot(2,2,1)
imshow(img_front)
hold on
subplot(2,2,2)
imshow(img_back)
hold on
subplot(2,2,3)
imshow(img_right)
hold on
subplot(2,2,4)
imshow(img_left)
hold on
for i = 1:4
    % local to global
    % global to local 
    % reproject into local
    corner_img = [];
    orient = char(corner_orient(i));
    side_orient = char(corner_side_orient(i));
    corner_world  = getValidMap(corner_top_left(i,:),x_intervals,y_intervals);
    eval(['save corner_',orient,'.mat corner_world corner_img'])
    birdview(corner_top_left(i,:), x_intervals, y_intervals, orient(1:end-2), x_diff, y_diff)
    % reprojection in front and back
    eval(['points_reprojection = H_',orient(1:end-2),' * corner_world;']);
    points_reprojection = points_reprojection./points_reprojection(3,:);
    figure(3)
    subplot(2,2,round(sqrt(i)))
    hold on
    plot(points_reprojection(1,:),points_reprojection(2,:),'rx')
    % reprojection in left and right
    corner_global = local2global2(corner_world, orient(1:end-2));
    cornrer_side = global2local(corner_global, side_orient);
    cornrer_side = [cornrer_side;ones(1,size(cornrer_side,2))];
    eval(['points_reprojection = H_',side_orient,' * cornrer_side;']);
    points_reprojection = points_reprojection./points_reprojection(3,:);
    figure(3)
    subplot(2,2,abs(2.5-i)+2.5)
    hold on
    plot(points_reprojection(1,:),points_reprojection(2,:),'rx')
end 


%%
function pt_world = getCalibMap(top_left, orient)
ind = 1;
for i = 1:6
    for j = 1:4
        pt_world(1,ind) = top_left(1) + (i-1) * 19.5;
        pt_world(2,ind) = top_left(2) -(j-1) * 19.5;
        pt_world(3,ind) = 1;
        ind = ind + 1;
    end
end

figure(2)
hold on
f = 1;
switch orient
    case 'front'
        for i = 0:6
            for j = 1:5
                p.X = top_left(1) + (i-1) * 19.5;
                p.Y = top_left(2) -(j-1) * 19.5;
                p.Z = 1;
                pg = local2global(p, orient);
                if f == 1
                    rectangle('Position',[pg.X, pg.Y, 19.5, 19.5], 'FaceColor', [0 0 0])
                    f = 0;
                else
                    f= 1;
                end
            end
        end
    case 'left'
        for i = 0:6
            for j = 0:4
                p.X = top_left(1) + (i-1) * 19.5;
                p.Y = top_left(2) -(j-1) * 19.5;
                p.Z = 1;
                pg = local2global(p, orient);
                if f == 1
                    rectangle('Position',[pg.X, pg.Y, 19.5, 19.5], 'FaceColor', [0 0 0])
                    f = 0;
                else
                    f= 1;
                end
            end
        end    
    case 'right'
        for i = 1:7
            for j = 1:5
                p.X = top_left(1) + (i-1) * 19.5;
                p.Y = top_left(2) -(j-1) * 19.5;
                p.Z = 1;
                pg = local2global(p, orient);
                if f == 1
                    rectangle('Position',[pg.X, pg.Y, 19.5, 19.5], 'FaceColor', [0 0 0])
                    f = 0;
                else
                    f= 1;
                end
            end
        end
    case 'back'
        for i = 1:7
            for j = 0:4
                p.X = top_left(1) + (i-1) * 19.5;
                p.Y = top_left(2) -(j-1) * 19.5;
                p.Z = 1;
                pg = local2global(p, orient);
                if f == 1
                    rectangle('Position',[pg.X, pg.Y, 19.5, 19.5], 'FaceColor', [0 0 0])
                    f = 0;
                else
                    f= 1;
                end
            end
        end
end
axis equal
end

function corner_world = getValidMap(corner_top_left,x_intervals,y_intervals)
corner_img = [];
% corner_world(:,1) = [corner_top_left,1];
ind = 1;
for i = 1:4
    for j = 1:4
        corner_world(1,ind) = corner_top_left(1) + x_intervals(i);
        corner_world(2,ind) = corner_top_left(2) - y_intervals(j);
        corner_world(3,ind) = 1;
        ind = ind + 1;
    end
end
end

function birdview(corner_top_left, x_intervals, y_intervals, orient, x_diff, y_diff)
switch orient
    case 'front'
        f = 1;
        for i = 1:3
            for j = 2:4
                c.X = corner_top_left(1) + x_intervals(i);
                c.Y = corner_top_left(2) - y_intervals(j);
                c.Z = 1;
                cg = local2global(c, orient);
                if f == 1
                    figure(2)
                    hold on
                    rectangle('Position',[cg.X, cg.Y, x_diff(i+1), y_diff(j)], 'FaceColor', [0 0 0])
                    axis equal
                    f = 0;
                else
                    f= 1;
                end
            end
        end
    case 'back'
        f = 1;
        for i = 2:4
            for j = 1:3
                c.X = corner_top_left(1) + x_intervals(i);
                c.Y = corner_top_left(2) - y_intervals(j);
                c.Z = 1;
                cg = local2global(c, orient);
                if f == 1
                    figure(2)
                    hold on
                    rectangle('Position',[cg.X, cg.Y, x_diff(i), y_diff(j+1)], 'FaceColor', [0 0 0])
                    axis equal
                    f = 0;
                else
                    f= 1;
                end
            end
        end
end
end


function P_global = local2global(P_local, orient)
global model
switch orient
    case 'front'
        P_global.X = P_local.X;  
        P_global.Y = P_local.Y + model.wheel_length;
    case 'back'
        P_global.X = - P_local.X;
        P_global.Y = - P_local.Y;
    case 'left'
        temp = P_local.Y;
        P_global.Y = P_local.X + model.wheel_length/2;
        P_global.X = -temp - model.wheel_width/2;
    case 'right'
        temp = P_local.Y;
        P_global.Y = -P_local.X + model.wheel_length/2;
        P_global.X = temp + model.wheel_width/2;
    otherwise
        warning('Unexpected Orientation');
end
P_global.Z = P_local.Z;
end


function P_global = local2global2(P_local, orient)
global model
switch orient
    case 'front'
        P_global(1,:) = P_local(1,:);
        P_global(2,:) = P_local(2,:) + model.wheel_length;
    case 'back'
        P_global(1,:) = - P_local(1,:);
        P_global(2,:) = - P_local(2,:);
    case 'left'
        P_global(2,:) = P_local(1,:)+ model.wheel_length/2;
        P_global(1,:) = - P_local(2,:) - model.wheel_width/2;
    case 'right'
        P_global(2,:) = - P_local(1,:)+ model.wheel_length/2;
        P_global(1,:) = - P_local(2,:) + model.wheel_width/2;
    otherwise
        warning('Unexpected Orientation');
end
P_global = P_global';
end

function p_local = global2local(p_global, orient)
global model
switch orient
    case 'front'
        R = [1,0; 0,1];
        t = [0; -model.wheel_length];
    case 'back'
        R = [-1,0; 0,-1];
        t = [0; 0];
    case 'left'
        R = [0,1; -1,0];
        t = [-model.wheel_length/2; -model.wheel_width/2];
    case 'right'
        R = [0,-1; 1,0];
        t = [model.wheel_length/2; -model.wheel_width/2];
    otherwise
        warning('Unexpected Orientation');
end
p_local = R * p_global' + t;
end

function H = get_homography(pt_world, pt_img)
A = zeros(2*size(pt_world,2), 9);
for i = 1:size(pt_world,2)
    A(2*i-1,:) = [-pt_world(1,i), -pt_world(2,i), -1, 0, 0, 0, pt_world(1,i) * pt_img(1,i), pt_world(2,i) * pt_img(1,i),  pt_img(1,i)];
    A(2*i,:) = [0, 0, 0, -pt_world(1,i), -pt_world(2,i), -1,  pt_world(1,i) * pt_img(2,i), pt_world(2,i) * pt_img(2,i),  pt_img(2,i)];
end
[~,~,V] = svd(A);
h = V(:,end);
H = [h(1:3)';h(4:6)';h(7:9)'];
H = H./H(3,3); 
end

