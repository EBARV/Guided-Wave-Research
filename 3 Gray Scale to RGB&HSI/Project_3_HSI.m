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
% color_i=zeros(m,n); % color 
HSI_Image=zeros([m,n,3]);
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
        frq_R = 0.01;
        Phi_R = 0;
        frq_G = 0.01;
        Phi_G = -pi/6;
        frq_B = 0.01;
        Phi_B = -2*pi/6;

end

H = 360*abs(sin(2*pi*frq_R*x+Phi_R));% sin H ba phaze 
S = abs(sin(2*pi*frq_G*x+Phi_G));% sinusi S ba Phaze
I = abs(sin(2*pi*frq_B*x+Phi_B));% sinusi I  ba Phaze
   
%% HSI transform

for i=1:m
    for j=1:n
        HSI_Image(i,j,1)=H(Image(i,j));
        HSI_Image(i,j,2)=S(Image(i,j));
        HSI_Image(i,j,3)=I(Image(i,j));
    end
end

% I_RGB=hsi2rgb(HSI_Image);

HH = HSI_Image(:, :, 1);
SS = HSI_Image(:, :, 2);
II = HSI_Image(:, :, 3);
HH = HH-360*floor(HH/360);	

a = HH<120;
b = HH<240 & ~a;
c = ~a & ~b;

Red=zeros(size(HH));
Gren=zeros(size(HH));
Blue=zeros(size(HH));

Red(a)=II(a).*(1+SS(a).*cos(HH(a).*(pi/180))./cos((60-HH(a))*(pi/180)));
Blue(a)=II(a).*(1-SS(a));
Gren(a)=3*II(a)-Red(a)-Blue(a);

HH(b)=HH(b)-120;
Red(b)=II(b).*(1-SS(b));
Gren(b)=II(b).*(1+SS(b).*cos(HH(b).*(pi/180))./cos((60-HH(b))*(pi/180)));
Blue(b)=3*II(b)-Blue(b)-Gren(b);

HH(c)=HH(c)-240;
Gren(c)=II(c).*(1-SS(c));
Blue(c)=II(c).*(1+SS(c).*cos(HH(c).*(pi/180))./cos((60-HH(c))*(pi/180)));
Red(c)=3*II(c)-Gren(c)-Blue(c);
out=II;
out(:,:,1)=Red;
out(:,:,2)=Gren;
out(:,:,3)=Blue;

% Red_out = out(:,:,1);
% Green_out = out(:,:,2);
% Blue_out = out(:,:,3);
%% Plot Show
subplot(3,2,1)
imshow(uint8(Image));
title( 'Main Image');

subplot(3,2,2)
imshow(out);
title( 'RGB Image');

subplot(3,2,3)
imshow(HSI_Image(:,:,1),[]);
title( 'Channel H');

subplot(3,2,4);
imshow(HSI_Image(:,:,2),[]);
title( 'Channel Green');

subplot(3,2,5);
imshow(HSI_Image(:,:,3),[]);
title( 'Channel Blue');

figure();
subplot(3, 1, 1)
plot(x, H, 'r');
xlim([0 255])
ylabel('Func H')

subplot(3, 1, 2)
plot(x, S, 'g');
xlim([0 255])
ylabel('Func S')

subplot(3, 1, 3)
plot(x, I, 'b');
xlim([0 255])
ylabel('Func I')