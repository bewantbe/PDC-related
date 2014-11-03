% calculate PDC

function pdc = PDC_A(A2d, D, fftlen)
p = size(A2d, 1);

Abar = cat(3, eye(p), reshape(A2d, p, p, []));
Afrq = fft(Abar, fftlen, 3);

%H = zeors(size(Afrq));
%for k = 1 : fftlen
%  H(:,:,k) = inv(Afrq(:,:,k));
%end

pdc = zeros(size(Afrq));
for j = 1 : p
  for k = 1 : fftlen
    pdc(:,j,k) = Afrq(:,j,k) / sqrt(real(Afrq(:,j,k)' * Afrq(:,j,k)));
  end
end

