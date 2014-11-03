% calculate DTF

function dtf = DTF_A(A2d, D, fftlen)
p = size(A2d, 1);

Abar = cat(3, eye(p), reshape(A2d, p, p, []));
Afrq = fft(Abar, fftlen, 3);

H = zeros(size(Afrq));
for k = 1 : fftlen
  H(:,:,k) = inv(Afrq(:,:,k));
end

dtf = zeros(size(Afrq));
for i = 1 : p
  for k = 1 : fftlen
    dtf(i,:,k) = H(i,:,k) / sqrt(real(H(i,:,k) * H(i,:,k)'));
  end
end

