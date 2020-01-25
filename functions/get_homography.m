function H = get_homography(str)
% �����Դ��1.�ڷ��нǶȣ�������׼���������������������� 2.��Ե����̫�󣬵���ͼ��Ť�����޷����
% for loop recurrently optimize
load(char(strcat('points_',str,'.mat')))% to be updated
% seperate into 2 sets one for estimation one for stiching

A = zeros(2*size(pt_world,2), 9);
for i = 1:size(pt_world,2)
    A(2*i-1,:) = [-pt_world(1,i), -pt_world(2,i), -1, 0, 0, 0, pt_world(1,i) * pt_img(1,i), pt_world(2,i) * pt_img(1,i),  pt_img(1,i)];
    A(2*i,:) = [0, 0, 0, -pt_world(1,i), -pt_world(2,i), -1,  pt_world(1,i) * pt_img(2,i), pt_world(2,i) * pt_img(2,i),  pt_img(2,i)];
end
[~,~,V] = svd(A);
h = V(:,end);
H = [h(1:3)';h(4:6)';h(7:9)'];
H = H./H(3,3); 

% stiching for world points rotation

% reprojection
% points_reprojection = H * pt_world;
% points_reprojection = points_reprojection./points_reprojection(3,:);
% figure
% plot(points_reprojection(1,:),points_reprojection(2,:),'rx')
% hold on
% plot(pt_img(1,:),pt_img(2,:),'bx')
end