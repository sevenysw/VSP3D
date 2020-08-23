function  fhat = nfft2d_wrap(x,f,N1,N2)
% A simple wrapping for nfft1d .
% input:
%   x: input signals positons
%   f: input signals
%   N: output frequency number (defaut: length(f))
% output:
%   fhat: fourier spectrum

M=length(x); % number of nodes
%N=24; % number of Fourier coefficients in first direction

% Initialisation
N = [N1;N2];
plan=nfft(2,N,M); % create plan of class type nfft
%n=2^(ceil(log(N)/log(2))+1);
%plan=nfft(1,N,M,n,7,bitor(PRE_PHI_HUT,PRE_PSI),FFTW_MEASURE); % use of nfft_init_guru

plan.x=x; % set nodes in plan
nfft_precompute_psi(plan); % precomputations

plan.f = f; % get samples

% Computation with NFFT
nfft_adjoint(plan);
fhat=plan.fhat;



