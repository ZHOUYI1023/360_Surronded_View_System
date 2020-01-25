% to be updated
function p = undistort_image(orient)
global img_size
tabx = importdata("../data/tabx.txt");
taby = importdata("../data/taby.txt");
img = imread('../images/front.bmp');
for i = 1:img_size(2)
    for j = 1:img_size(1)
        if round(taby(i,j)+1) >0 && round(taby(i,j)+1) <720 && round(tabx(i,j)+1) >0 && round(tabx(i,j)+1)< 1281
                    p(i,j,:) = uint8(img(round(taby(i,j)+1),round(tabx(i,j)+1),:));
        end
    end
end
imshow(p)
img2 = imread('../images/front_undistort.bmp');
figure
imshow(img2)
end