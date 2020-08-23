function  f = infft2d_wrap(x,fhat,N1,N2)
% A simple wrapping for infft1d .
% input:
%   x: output signals positons
%   fhat: input fourier spectrum
% output:
%   f: output signals

M=length(x); % number of nodes

N=[N1;N2];
% Initialisation
plan=nfft(2,N,M); % create plan of class type nfft

plan.x=x; % set nodes in plan
nfft_precompute_psi(plan); % precomputations

% NFFT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fhatv=fhat(:);

% Compute samples with NFFT
plan.fhat=fhatv; % set Fourier coefficients
nfft_trafo(plan); % compute nonequispaced Fourier transform
f=plan.f; % get samples

end

