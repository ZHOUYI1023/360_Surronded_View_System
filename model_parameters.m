clear
clc
global model
model.wheel_length = 275;
model.wheel_width = 180;
model.car_height = 181;
model.car_length_front = 105;
model.car_length_back = 90;
model.theta_res = -5;
model.x_res =  2;
model.x = 80;
model.radius_long = 500;
model.radius_short = 300;
model.flat_ratio = 5/6;
model.theta0 = 55;
model.origin = [0 ,model.wheel_length/2];
model.theta = [180-model.theta0,model.theta0;90+model.theta0,90-model.theta0;180-model.theta0,model.theta0;90+model.theta0,90-model.theta0];
model.pad = [145;0;-90;0];% front, left , back ,right
model.corner_global = [model.pad(4)-model.wheel_width/2,model.pad(1)+model.wheel_length;
                       model.pad(2)+model.wheel_width/2,model.pad(1)+model.wheel_length;
                       model.pad(2)+model.wheel_width/2,model.pad(3);
                       model.pad(4)-model.wheel_width/2,model.pad(3)]; % clockwise
save model.mat model
orientation = ["front", "right", "back", "left"];

for i = 1:4
    %%
    orient = char(orientation(i));
    % generate local model
    eval(['P_local_',orient,' = model_generate(orient, i);']);
    % local model to global model
    eval(['P_global_',orient,' = local2global(P_local_',orient,',orient);']);
    % show results
    figure(1)
    hold on
    eval(['mesh(P_global_',orient,'.X,P_global_',orient,'.Y,P_global_',orient,'.Z)'])
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

%%
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


function P_local = model_generate(orient,  k) 
global model
switch orient
    case 'front'
        a = model.radius_short;
        b = model.radius_long;
    case 'back'
        a = model.radius_short;
        b = model.radius_long;
    case 'left'
        a = model.radius_long;
        b = model.radius_short;
    case 'right'
        a = model.radius_long;
        b = model.radius_short;
end
        
corner_l =  global2local(model.corner_global(mod(k-1,4)+1,:), orient);
corner_r =  global2local(model.corner_global(mod(k,4)+1,:), orient);
ind_x = 0;
origin =  global2local(model.origin, orient);
for i = model.theta(k,1):model.theta_res:model.theta(k,2)
    ind_x = ind_x + 1;
    p_upper = [a * cos(deg2rad(i)),b * sin(deg2rad(i)) + origin(2)];
    p_lower = (corner_r - corner_l)*(i-model.theta(k,1))/(model.theta(k,2)-model.theta(k,1)) + corner_l;
    max_radius = sqrt((p_upper(1)-origin(1))^2 + (p_upper(2)-origin(2))^2);
    ind_y = 0;
    for j = 0:model.x_res:model.x
        ind_y = ind_y + 1;
        P_local.X(ind_x,ind_y) = (p_upper(1) - p_lower(1))*j/model.x + p_lower(1);
        P_local.Y(ind_x,ind_y) = (p_upper(2) - p_lower(2))*j/model.x + p_lower(2);
        dist = sqrt((P_local.X(ind_x,ind_y)-origin(1))^2 +(P_local.Y(ind_x,ind_y)-origin(2))^2);
        P_local.Z(ind_x,ind_y) = max((dist-model.flat_ratio*max_radius),0)^2/200*5;
%         P_local.Z(ind_x,ind_y) = 0;
    end
end
figure(2)
subplot(2,2,k)
hold on
title(orient)
plot3(P_local.X, P_local.Y, P_local.Z)
axis('equal')
end