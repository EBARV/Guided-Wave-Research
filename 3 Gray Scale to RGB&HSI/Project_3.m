clc;
clear;
close all;
%%
[ImageRead,path] = uigetfile({'*.png';'*.tif';'*.jpg'},...
               'Please Select a Picture...');
INFO = imfinfo(ImageRead);
Image = imread(ImageRead);

[m, n, ~] = size(Image);

%% Variable
Red_channel=zeros(m,n);% red help chanal
Green_channel=zeros(m,n);% green help chanal
Blue_channel=zeros(m,n); % blue help chanal
color_i=zeros(m,n); % color 
x = 0:255;
L = 256;
disp('******************************************')
disp('*      Choose frequency mode             *')
disp('*if select 1 input frequency and Phase   *')
disp('*if select 2 defualt frequency and Phase *')
disp('*****************************************')
ss = input('Enter a number[1-2]: ');
switch ss
    case 1
        frq_R = input('Please input frequency Red Color : ');
        Phi_R = input('Please input Phase Red Color : ');
        frq_G = input('Please input frequency Green Color : ');
        Phi_G = input('Please input Phase Green Color : ');
        frq_B = input('Please input frequency Blue Color : ');
        Phi_B = input('Please input Phase Blue Color : ');
    case 2
        frq_R = 0.002;
        Phi_R = 0;
        frq_G = 0.002;
        Phi_G = -pi/6;
        frq_B = 0.002;
        Phi_B = -2*pi/6;

end

Func_R = abs(sin(2*pi*frq_R*x+Phi_R));% function sin ghermez ba phaze 
Func_G = abs(sin(2*pi*frq_G*x+Phi_G));% function sinusi sabz ba Phaze
Func_B = abs(sin(2*pi*frq_B*x+Phi_B));% function sinusi abi  ba Phaze
        


%%
for i = 1:m
    for j = 1:n
         Red_channel(i, j) = Func_R(Image(i, j)+1);
         color_i(i, j, 1) = Func_R(Image(i, j)+1);
         Green_channel(i, j) = Func_G(Image(i, j)+1);
         color_i(i, j, 2) = Func_G(Image(i, j)+1);
         Blue_channel(i, j) = Func_B(Image(i, j)+1);
         color_i(i, j, 3) = Func_B(Image(i, j)+1);
    end
end

%% Plots
subplot(3,2,1)
imshow(uint8(Image));
title( 'Main Image');

subplot(3,2,2)
imshow(color_i);
title( 'RGB Image');

subplot(3,2,3)
imshow(Red_channel);
title( 'Red channel');

subplot(3,2,4);
imshow(Green_channel);
title( 'Green channel');

subplot(3,2,5);
imshow(Blue_channel);
title( 'Blue channel');

figure();
subplot(3, 1, 1)
plot(x,Func_R,'r');
xlim([0 255])
ylabel('Func RED')

subplot(3, 1, 2)
plot(x,Func_G,'g');
xlim([0 255])
ylabel('Func GREEN')

subplot(3, 1, 3)
plot(x,Func_B,'b');
xlim([0 255])
ylabel('Func BLUE')