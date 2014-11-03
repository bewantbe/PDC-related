% calculate PDC

function pdc = GPDC_A(A2d, D, fftlen)
p = size(A2d, 1);

Abar = cat(3, eye(p), reshape(A2d, p, p, []));
Afrq = fft(Abar, fftlen, 3);

d = diag(D);
dd = diag(1./d);
pdc = zeros(size(Afrq));
for j = 1 : p
  for k = 1 : fftlen
    pdc(:,j,k) = Afrq(:,j,k) ./ sqrt(d) ./ sqrt(real(Afrq(:,j,k)' * dd * Afrq(:,j,k)));
  end
end

