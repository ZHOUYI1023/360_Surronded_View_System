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
        P_local.Z(ind_x,ind_y) = 50*(max((dist-model.flat_ratio*max_radius)/max_radius,0))^2*5;
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