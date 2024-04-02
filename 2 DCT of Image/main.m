clc
clear 
close all
I=imread('cameraman.tif');
I=imresize(I,[64,64]);
I=im2double(I);
I_T=I;
[x_I,y_I]=size(I);
n=32;
m=5;
percent_eliminate=25;
n_patch_x=floor(x_I/n);
n_patch_y=floor(y_I/n);
for i=1:n_patch_x
    for j=1:n_patch_y
        W=I((i-1)*n +1 :i*n ,(j-1)*n +1 :j*n);
        W_T=W;
        for k=1:n
            for t=1:n
                sum1=0;
                for x=1:n
                    for y=1:n
                        sum1=sum1+W(x,y)*r_calculate(x-1,y-1,k-1,t-1,n,m);
                    end
                end
                W_T(k,t)=sum1;
            end
        end
        I_T((i-1)*n +1 :i*n ,(j-1)*n +1 :j*n)=W_T;
    end 
end 
u_new=floor((percent_eliminate/100)*n);
v_new=floor((percent_eliminate/100)*n);
I_recons=I;
for i=1:n_patch_x
    for j=1:n_patch_y
        W_T=I_T((i-1)*n +1 :i*n ,(j-1)*n +1 :j*n);
        W_rec=W_T;
        for x=1:n
            for y=1:n
                sum1=0;
                for k=1:u_new
                    for t=1:v_new
                        sum1=sum1+W_T(k,t)*r_calculate(x-1,y-1,k-1,t-1,n,m);
                    end
                end
                W_rec(x,y)=sum1;
            end
        end
        I_recons((i-1)*n +1 :i*n ,(j-1)*n +1 :j*n)=W_rec;
    end 
end 
%imshow
I_T=255*(I_T-min(min(I_T)))/(max(max(I_T))-min(min(I_T)));
I_recons=255*(I_recons-min(min(I_recons)))/(max(max(I_recons))-min(min(I_recons)));
subplot(1,3,1)
title('image')
imshow(I)
subplot(1,3,2)
title('image after transform ')
imshow(I_T,[])
subplot(1,3,3)
imshow(I_recons,[])
title('reconstuct image')
zarayeb_marix=zeros([n*n,n*n]);
for k=1:n
        for t=1:n
                W_zarayeb=zeros([n,n]);
                for x=1:n
                    for y=1:n
                        W_zarayeb(x,y)=r_calculate(x-1,y-1,k-1,t-1,n,m);
                    end
                end
                zarayeb_marix((k-1)*n +1 :k*n ,(t-1)*n +1 :t*n)=W_zarayeb;
        end
end
figure(2)  
imshow(zarayeb_marix,[])



        
                
