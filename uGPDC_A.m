% calculate PDC

function pdc = uGPDC_A(A2d, D, fftlen)
p = size(A2d, 1);

Abar = cat(3, eye(p), reshape(A2d, p, p, []));
Afrq = fft(Abar, fftlen, 3);

%H = zeors(size(Afrq));
%for k = 1 : fftlen
%  H(:,:,k) = inv(Afrq(:,:,k));
%end

pdc = zeros(size(Afrq));
d = diag(D);
for j = 1 : p
  for k = 1 : fftlen
    pdc(:,j,k) = sqrt(d(j)./d) .* Afrq(:,j,k) / sqrt(real(Afrq(j,j,k)' * Afrq(j,j,k)));
  end
end

