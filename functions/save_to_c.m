function save_to_c(P, I, orient)
global img_size model TexOrient
Vrt = [];
Tex = [];
TEMP = P.Y;
P.X = -P.X/100;
P.Y = abs(P.Z)/100;
P.Z = (TEMP - model.wheel_length/1.75)/100;
for j = 1:size(P.X,2) - 1
    for i = 1:size(P.X,1) - 1
        Vrt = [Vrt; P.X(i,j), P.Y(i,j), P.Z(i,j), P.X(i+1,j+1), P.Y(i+1,j+1), P.Z(i+1,j+1), P.X(i,j+1), P.Y(i,j+1), P.Z(i,j+1)];
        Vrt = [Vrt; P.X(i,j), P.Y(i,j), P.Z(i,j), P.X(i+1,j), P.Y(i+1,j), P.Z(i+1,j), P.X(i+1,j+1), P.Y(i+1,j+1), P.Z(i+1,j+1)];
        Tex = [Tex; I.X(i,j)/img_size(1), 1 - I.Y(i,j)/img_size(2), I.X(i+1,j+1)/img_size(1), 1 - I.Y(i+1,j+1)/img_size(2), I.X(i,j+1)/img_size(1), 1 - I.Y(i,j+1)/img_size(2)];
        Tex = [Tex; I.X(i,j)/img_size(1) , 1 - I.Y(i,j)/img_size(2) , I.X(i+1,j)/img_size(1), 1 - I.Y(i+1,j)/img_size(2), I.X(i+1,j+1)/img_size(1), 1 - I.Y(i+1,j+1)/img_size(2)];
        Tex = tex_warp(Tex,TexOrient);
%         figure(4)
%         hold on
        pts = [P.X(i,j), P.Y(i,j), P.Z(i,j); 
               P.X(i+1,j+1), P.Y(i+1,j+1), P.Z(i+1,j+1);
               P.X(i,j+1), P.Y(i,j+1), P.Z(i,j+1);
               P.X(i,j), P.Y(i,j), P.Z(i,j)];
%         plot3(pts(:,1),pts(:,3),pts(:,2),'r-')
        pts = [P.X(i,j), P.Y(i,j), P.Z(i,j); 
               P.X(i+1,j), P.Y(i+1,j), P.Z(i+1,j); 
               P.X(i+1,j+1), P.Y(i+1,j+1), P.Z(i+1,j+1);
               P.X(i,j), P.Y(i,j), P.Z(i,j)];
%         plot3(pts(:,1),pts(:,3),pts(:,2),'r-')
    end
end
switch orient
    case 'front'
        orient = 'Front';
    case 'left'
        orient = 'Left';
    case 'right'
        orient = 'Right';
    case 'back'
        orient = 'Back';
end
    
fileID = fopen('output/bowl.c','a');
str1 = ['GLfloat ',orient,'BowlVer[] = {\n'];
fprintf(fileID,str1);
vertex = fprintf(fileID,'%.8f, %.8f, %.8f, %.8f, %.8f, %.8f, %.8f, %.8f, %.8f,\n',Vrt');
fprintf(fileID, '};\n');
str2 = ['GLfloat ',orient,'BowlTextCo[] = {\n'];
fprintf(fileID,str2);
texture = fprintf(fileID,'%.8f, %.8f, %.8f, %.8f, %.8f, %.8f,\n',Tex');
fprintf(fileID, '};\n');
str3 = ['GLint ',orient,'BowlVerNum = %d;\n'];
fprintf(fileID, str3 ,6*(size(P.X,1)-1)*(size(P.X,2)-1));
% merge two txt files
fclose('all');
end