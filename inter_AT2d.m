% Test script of class nfft for spatial dimension d=1.
function y = inter_AT2d(d,x1,N1,N2)

[n1,~] = size(d);

A = @(f) (reshape(nfft2d_wrap(x1,f,N2,N1),N2,N1)).';
AT = @(fhat) ifftshift(fft2((fftshift(fhat))))/N1/N2;

d_ = fft(d);

fhat2d = zeros(n1,N1,N2);

for i=1:n1
    fhat = A(d_(i,:).'); 
    fhat2d(i,:,:) = ((AT(fhat))); 
end


y = real(ifft(fhat2d));