function f = inter3d(d,x,y,N1,N2,method)

[n1,~] = size(d);

f = zeros(n1,N1,N2);

[xq,yq] = meshgrid(linspace(-0.5,0.5,N2),linspace(-0.5,0.5,N1));
for i=1:n1
  
   f(i,:,:) = griddata(x(:),y(:),d(i,:,:),xq,yq,method);
    
end


f(isnan(f)) = 0;
end