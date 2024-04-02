clc;
clear;
close all;
%% Image Read
[ImageRead,path] = uigetfile({'*.png';'*.tif';'*.jpg'},...
               'Please Select a Picture...');
INFO = imfinfo(ImageRead);
I = imread(ImageRead);
[m,n,h] = size(I);
if h == 3
    I = rgb2gray(I);
    I = imresize(I, [256,256]);
    disp('Image Change to Gray')
    [m,n,h] = size(I);
else
    disp('Image is Gray')
end

%% Variable
value = [];
Accumulator = 0;

%plot image
figure(1)
subplot(5,1,1)
%% Image histo
rr = 0:1:m-1;
for i = 1:m
    value = [value sum(sum(I == rr(i)))];
end

bar(value) %plot histo
title('Histogram Image')

%% PDF Image
nn = sum(sum(value));
ImagePDF = value/nn;
subplot(5,1,2)%plot pdf I
bar(ImagePDF)
title('PDF Image')

%% calculate cdf with PDF
LL = ImagePDF;

for i = 1:m
    Accumulator = Accumulator + ImagePDF(i);
    LL(i) = Accumulator;
end

%generate desired pdf
LL = 255*LL; %Formul (L-1)*CDF
% rand_num = zeros(1,m);% ye bordar random 
% rand_num(1:100) = 500;% ye seri maghadir dashte bashe baraye histogram exmple=xx
% sum2 = sum(rand_num);
% gol_PDF = rand_num/sum2;
%inja mishe raveshhaye mokhtalef gozash
xn = 0:255;
gol_PDF = normpdf(xn,100,20);
subplot(5,1,3) %plot desired pdf
bar(gol_PDF)
title('Gol PDF')

%% calculate cdf of desired image  by using desired pdf
Vn = gol_PDF;
Accumulator = 0;
for i = 1:m
    Accumulator = Accumulator + gol_PDF(i);
    Vn(i) = Accumulator;
end

Vn=Vn*255; % [m-1]*[gol_PDF]
%% find zk corresponding to each rk by using Vn & S.
z_k = zeros(size(LL));
for i = 1:m
    res = abs(Vn-LL(i));
    ind = find(res == min(res));
    z_k(i) = ind(1)-1;
end
%% Image Result
I_result = zeros(size(I));
rr = 0:1:m-1;
for i = 1:m
    I_result(I == rr(i)) = z_k(i);
end

subplot(5, 1, 4) % histo gol or result image
value = [];
rr = 0:1:m-1;
for i = 1:m
    value = [value sum(sum(I_result == rr(i)))];
end

%% plot histo
bar(value);
title('Histogram Results')
nn = sum(value);
pdf_result = value/nn;
subplot(5, 1, 5)
bar(pdf_result)
title('PDF')
figure();
subplot(1, 2, 1)
imshow(I)
title('Main Image')
subplot(1, 2, 2)
imshow(uint8(I_result))
title('Image Result')
figure();
subplot(2, 1, 1)
plot(0:m-1, LL,'b')
title('Sk')
xlim([0 m-1])
subplot(2, 1, 2)
plot(0:m-1, Vn, 'r')
title('Vk')
xlim([0 m-1])







    

