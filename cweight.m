

function E = cweight(u)

disp('Compute all thresholds');
F = ones(size(u));
X = fftshift(ifftn(F)) * (prod(size(F)))^(1/3);
tic, C = fdct3d_forward(X); toc;

% Compute norm of curvelets (exact)
E = cell(size(C));

for s=1:length(C)
  E{s} = cell(size(C{s}));

  for w=1:length(C{s})
    A = C{s}{w};
    E{s}{w} = ones(size(A))*sqrt(sum(sum(sum(A.*conj(A))) / prod(size(A))));

  end
    if (s == length(C))
        E{s}{w} = 5 * E{s}{w};
    end

end

end

