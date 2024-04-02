function out= r_calculate(x,y,u,v,n,m)
b_x=de2bi(x,m);
b_u=de2bi(u,m);
L_b_u=length(b_u);
p_u=[b_u(L_b_u)];
for k=2:L_b_u
    p_k=b_u(L_b_u-k+2)+b_u(L_b_u-k+1);
    p_u=[p_u p_k];     
end
b_y=de2bi(y,m);
b_v=de2bi(v,m);
L_b_v=length(b_v);
p_v=[b_v(L_b_v)];
for k=2:L_b_v
    p_k=b_v(L_b_v-k+2)+b_v(L_b_v-k+1);
    p_v=[p_v p_k];     
end
sum1=0;
for i=1:m
    sum1=sum1+(b_x(i)*p_u(i)+b_y(i)*p_v(i));
end
out=(1/n)*((-1)^(floor(sum1)));
end

