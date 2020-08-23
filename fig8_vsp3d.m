
close all; clear; 
% Dependency 1: Curvelab
addpath('E:\matlab\CommonTool\CurveLab-2.1.3\fdct3d\mex');
% Dependency 2: SeismicLab
addpath(genpath('E:\matlab\CommonTool\SeismicLab'));
% Dependency 3: NFFT, added in the folder.
N1 = 138; N2 = 138;
load VSP3d.mat;
x = [H.SourceX] - [H.GroupX];
y = [H.SourceY] - [H.GroupY];
k = atan(0.3447);
R = [cos(k),-sin(k);sin(k),cos(k)];
rp = R*[x;y];
xp = rp(1,:);
yp = rp(2,:);

x = valuemap(xp,min(xp),max(xp),-0.5,0.5);
y = valuemap(yp,min(yp),max(yp),-0.5,0.5);

f1 = data/max(abs(data(:)));
x1 = [x;y]';
A = @(f) inter_A2d(f,x1,N1,N2);
AT = @(f) inter_AT2d(f,x1,N1,N2);

n = 1;
b = f1;
tic
u = AT(f1);
toc
u0 = u;
if (~exist('data_inter3d','var'))
    data_inter3d = inter3d(f1,x,y,N1,N2,'linear');
    data_inter3d(isnan(data_inter3d)) = 0;
end
%u = data_inter3d;
f3 = real(u);
method = 2;
if method== 1 
    %Fourier method
    D = @(u) fftn(u);
    DT= @(u) ifftn(u);
    beta = 1/2500*em; mu = beta/4;
    betas = 1/beta;
elseif method==2
    %3D Curvelet method; Default parameters;
    ctmp = fdct3d_forward(u);
    D = @(u) C2V(fdct3d_forward(u)); % should be 3D!
    DT = @(c) fdct3d_inverse(V2C(c,ctmp));
    beta = 0.5; mu = beta*0.2;
    bt = cweight(u);
    betas = 40*C2V(bt);
end

sigma = 1;

u = u0;
lam = zeros(size(f1)); v = zeros(size(D(u)));

oo = [];
n = 1;

while (n<30)
    tic
    fu = D(u);
    omega = ((abs(fu-v/beta))>(betas)).*(fu-v/beta);
    u1 = DT(v+beta*omega);
    u2 = AT(lam+mu*f1);
    u = 1/(beta+mu)*(u1+u2);
    v = v - beta*(D(u)-omega);
    lam = lam - mu*(A(u)-f1);
    n = n + 1
    toc
end

f2 = real(u);

sc = 0.2; pos = 0.45 ; %relative position of the plane
seishow3Dv3(data_inter3d,100,-sc,sc,pos);title('Linear interpolation')
set(gcf,'Position',[50 50 500 400])
set(gcf,'paperpositionmode','auto')

seishow3Dv3(f2,100,-sc,sc,pos);title('Curvelet interpolation')
set(gcf,'Position',[50 550 500 400])
set(gcf,'paperpositionmode','auto')

% seishow3D(f3,100,-sc,sc,pos);title('Fourier interpolation')
% set(gcf,'Position',[550 50 500 400])
