% By Isaac Chen in 2019, with the inspiration from Prof. Hongdong Li, ANU


function main()
%read 4 images and each image is processed by the built-in corner function
%and my corner function. the output of the functions is the coordinates of
%the corners.
im1 = imread('Harris_1.jpg');
im1 = rgb2gray(im1);
cs1_my = mycorner(im1);
cs1_bt = corner(im1);

im2 = imread('Harris_1.pgm');
cs2_my = mycorner(im2);
cs2_bt = corner(im2);

im3 = imread('Harris_3.jpg');
im3 = rgb2gray(im3);
cs3_my = mycorner(im3);
cs3_bt = corner(im3);

im4 = imread('Harris_4.jpg');
im4 = rgb2gray(im4);
cs4_my = mycorner(im4);
cs4_bt = corner(im4);

pause(1);

%the output(the coordinates) from both built-in and my corner are plotted 
%on the respective images

%for image 1
[r,~] = size(cs1_my);
hold on;
figure(1);
imshow(im1);
title('1-mycorner')
hold on;
for i = 1:r
    plot(cs1_my(i,2),cs1_my(i,1),'r.');
end
pause(0.5);

[r,~] = size(cs1_bt);
figure(2);
imshow(im1);
title('1-builtin')
hold on;
for i = 1:r
    plot(cs1_bt(i,1),cs1_bt(i,2),'r.');
end
pause(0.5);

%for image 2
[r,~] = size(cs2_my);
hold on;
figure(3);
imshow(im2);
title('2-mycorner')
hold on;
for i = 1:r
    plot(cs2_my(i,2),cs2_my(i,1),'r.');
end
pause(0.5);

[r,~] = size(cs2_bt);
figure(4);
imshow(im2);
title('2-builtin')
hold on;
for i = 1:r
    plot(cs2_bt(i,1),cs2_bt(i,2),'r.');
end
pause(0.5);

%for image 3
[r,~] = size(cs3_my);
hold on;
figure(5);
imshow(im3);
title('3-mycorner')
hold on;
for i = 1:r
    plot(cs3_my(i,2),cs3_my(i,1),'r.');
end
pause(0.5);

[r,~] = size(cs3_bt);
figure(6);
imshow(im3);
title('3-builtin')
hold on;
for i = 1:r
    plot(cs3_bt(i,1),cs3_bt(i,2),'r.');
end
pause(0.5);

%for image 4
[r,~] = size(cs4_my);
hold on;
figure(7);
imshow(im4);
title('4-mycorner')
hold on;
for i = 1:r
    plot(cs4_my(i,2),cs4_my(i,1),'r.');
end
pause(0.5);

[r,~] = size(cs4_bt);
figure(8);
imshow(im4);
title('4-builtin')
hold on;
for i = 1:r
    plot(cs4_bt(i,1),cs4_bt(i,2),'r.');
end

end

%mycorner function
%input: an image
%output: coordinates of the corners of the image
function corners = mycorner(im)
im = im2double(im);
[h, w] = size(im);
corners = zeros(h,w); %initialisation for the final result
response = zeros(h,w); %initialisation of the matrix for response 
sigma = 2;
thresh = 0.005; 
k = 0.05; 
filter_size = 3; % Parameters, add more if needed

% Derivative masks
dx = [-1 0 1;-1 0 1; -1 0 1];
dy = dx'; % dx is the transpose matrix of dy
% compute x and y derivatives of image
Ix = conv2(im,dx,'same');
Iy = conv2(im,dy,'same'); 

g = fspecial('gaussian',max(1,fix(3*sigma)*2+1),sigma); %compute g in order to later compute Ix2, Iy2 and Ixy
Ix2 = conv2(Ix.^2,g,'same'); % x and x
Iy2 = conv2(Iy.^2,g,'same'); % y and y
Ixy = conv2(Ix.*Iy,g,'same'); % x and y

for i = 1:h
    for j = 1:w
        structure_tensor = [Ix2(i,j) Ixy(i,j);Ixy(i,j) Iy2(i,j)]; % calculate M based on Ix2, Iy2 and Ixy
        response(i,j) = det(structure_tensor) - k*(trace(structure_tensor)^2); % calculate corner response
    end
end

localmaxs = ordfilt2(response,filter_size^2,ones(filter_size)); %apply non-maxium suppression
for i = 2:h-1
    for j = 2:w-1
        if response(i,j) > thresh && response(i,j) ==localmaxs(i,j) %only local maxium and the one greater than thresh can be selected
            corners(i,j) = 1; %mark the select points as 1s
        end
    end
end
[cs,rs] = find(corners == 1); %only output the coordinates of the corners
corners = [cs,rs]; 
end


