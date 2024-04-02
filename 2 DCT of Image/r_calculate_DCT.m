function out= r_calculate_DCT(x,y,u,v,n)
if u==0
    alpha_u=sqrt(1/n);
else
    alpha_u=sqrt(2/n);
end
if v==0
    alpha_v=sqrt(1/n);
else
    alpha_v=sqrt(2/n);
end
out=alpha_u*alpha_v*cos((2*x+1)*u*pi/(2*n))*cos((2*y+1)*v*pi/(2*n));
end

