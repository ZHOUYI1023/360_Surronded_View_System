function P_img = texture_map(T, P_local,k)
global img_size
P_occupied = [];
P_vacant = [];
for i = 1:size(P_local.X,1)
    for j = 1:size(P_local.X,2)
        
        p_temp = T * [P_local.X(i,j), P_local.Y(i,j), P_local.Z(i,j), 1]';
        P_img.X(i,j) = p_temp(1)/p_temp(3);
        P_img.Y(i,j) = p_temp(2)/p_temp(3);
        if P_img.X(i,j)>=0 && P_img.X(i,j)<=img_size(1) && P_img.Y(i,j)>=0 && P_img.Y(i,j)<=img_size(2)
            P_occupied =[P_occupied ;P_local.X(i,j),P_local.Y(i,j),P_local.Z(i,j)];
        else
            P_vacant = [P_vacant ;P_local.X(i,j),P_local.Y(i,j),P_local.Z(i,j)];
        end
    end
end
figure(5)
subplot(2,2,k)
surface(P_local.X,P_local.Y,P_local.Z)
hold on
plot3(P_occupied(:,1),P_occupied(:,2),P_occupied(:,3),'r.','MarkerSize',25)
if ~isempty(P_vacant)
    plot3(P_vacant(:,1),P_vacant(:,2),P_vacant(:,3),'b.','MarkerSize',25)
end
% local to global
end