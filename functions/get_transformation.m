function T = get_transformation(H, intrinsics)
r1 = intrinsics\H(:,1)/norm(intrinsics\H(:,1));
r2 = intrinsics\H(:,2)/norm(intrinsics\H(:,1)); 
t = intrinsics\H(:,3)/norm(intrinsics\H(:,1));
R = [r1 r2 cross(r1,r2)];
T = intrinsics * [eye(3),[0;0;0]] * [R, t;0, 0, 0, 1];
end