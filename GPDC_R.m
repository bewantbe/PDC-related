% calculate PDC

function pdc = GPDC_R(R, fftlen)
if ~exist('fftlen','var')
  fftlen = 1024;
end
p = size(R, 1);

[A2d, D] = ARregression(R);

pdc = GPDC_A(A2d, D, fftlen);
