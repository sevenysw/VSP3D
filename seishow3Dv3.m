function seishow3Dv3(D,c,dmin,dmax,pos,d1,d2,d3,f1,f2,f3)

if (~exist('pos' ,'var')) 
    pos=0.5;
end

if (~exist('c' ,'var')) c=100;end
if (~exist('c' ,'var')) c=100;end
if (~exist('d1' ,'var')) d1=0.002;end % time
if (~exist('d2' ,'var')) d2=0.02;end % x
if (~exist('d3' ,'var')) d3=0.02;end % y
if (~exist('f1' ,'var')) f1=0;end
if (~exist('f2' ,'var')) f2=0;end
if (~exist('f3' ,'var')) f3=0;end



cm = max(D(:));
[n1,n2,n3] = size(D);

ppx = 0.8;
ppy = 0.8;
ppt = 0.8;

xt = [8 130 138+8 138+130];
xtl= [-2 2 -2 2];
yt = [14 124 138+5 138+100];
ytl= [-2 2 3 3.2];

I                   = zeros(n1+n3+1,n2+n3+1);
I(1:n3,1:n2)        = squeeze( D(round(n1*pos),:,:) )';
I(:,n2+1)  = cm;
I(1:n3,n2+2:n2+n3+1)  = mean(D(:))*ones(n3,n3);
I(n3+2:n3+n1+1,1:n2)  = squeeze(D(:,:, round(n3*pos)));
I(n3+1,:)  = cm;
I(n3+2:n3+n1+1,n2+2:n2+n3+1) = squeeze( D(:,round(n2*pos),:));
%figure,
I = clip(I,c,c);

if (~exist('dmin' ,'var')) 
    dmin = min(I(:)) ;
end
if (~exist('dmax' ,'var')) 
    dmax = max(I(:)) ;
end

figure,imagesc(I,[dmin,dmax]);%axis image;
colorbar; colormap(seismic(2)); colormap gray;
set(gca,'XTick',xt,'YTick',yt);
set(gca,'XTickLabel',xtl,'YTickLabel',ytl);
set(gca,'FontSize',12);
xlabel('X (km)                       Y (km)');
ylabel('Time (s)                            Y (km)');
%imagesc(I);axis image; colormap gray; axis off;colorbar;
% figure, plot(I(:,64));
end