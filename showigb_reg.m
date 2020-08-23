function showigb_reg(data,xp,yc)

x1 = min(xp(:));
x2 = max(xp(:));
xrg = x2 - x1;

[nt,n1,n2] = size(data);

np = round(n1*yc);

x2 = linspace(x1,x2,n2);

data2 = squeeze(data(:,np,:));

z= (1501:1628)*0.002;
figure,

dx = 0.035919468094926;

wigb(data2,8,x2,z,1,dx);xlabel('Y (km)'); ylabel('Time (s)');
set(gca,'FontSize',12);
set(gcf,'Position',[50 550 600 300]);


end