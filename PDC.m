% calculate PDC

function pdc = PDC(X, m, fftlen)
if ~exist('fftlen','var')
  fftlen = 1024;
end
[p, len] = size(X);

covz = getcovzpd(X, m);
[A2d, D] = ARregressionpd(covz, p);

pdc = PDC_A(A2d, D, fftlen);
