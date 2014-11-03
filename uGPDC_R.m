% calculate uGPDC

function pdc = uGPDC_R(R, fftlen)
if ~exist('fftlen','var')
  fftlen = 1024;
end
p = size(R, 1);

[A2d, D] = ARregression(R);

pdc = uGPDC_A(A2d, D, fftlen);
