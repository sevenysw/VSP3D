function showigb(data,x,y,yc)

rg_y = max(y(:)) - min(y(:));

yp = min(y(:))+yc*rg_y;

r = 25/1000;

ind = find(abs(y-yp)<r);

x2 = x(ind);

data2 = data(:,ind);

z = (1501:1628)*0.002;
figure,
% for i=1:length(x2)
%     plot(flipud(data2(:,i))/2+x2(i),z,'k');hold on;
% end
dx = 0.035919468094926;

wigb(data2,8,x2,z,1,dx);xlabel('Y (km)'); ylabel('Time (s)');
set(gca,'FontSize',12);
set(gcf,'Position',[50 550 600 300])
end