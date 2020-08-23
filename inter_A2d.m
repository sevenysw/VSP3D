% Test script of class nfft for spatial dimension d=1.
function y = inter_A2d(d2,x1,N1,N2)

[n1,~] = size(d2);



AT = @(fhat) (infft2d_wrap(x1,fhat,N1,N2));
% AT = @(fhat) (infft2d_wrap(x1,fhat,N2,N1))'/N1/N2;

d_ = fft(d2);

fhat2d = zeros(n1,size(x1,1));

for i=1:n1
    dt = (squeeze(d_(i,:,:)));
    fhat = ifftshift((ifft2(fftshift(dt.')))); % use permute to replace transpose?
    fhat2d(i,:) = (AT(fhat)); 
end

y = real(ifft(fhat2d));
