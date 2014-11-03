% calculate PDC

function dtf = DTF(X, m, fftlen)
if ~exist('fftlen','var')
  fftlen = 1024;
end
[p, len] = size(X);

covz = getcovzpd(X, m);
[A2d, D] = ARregressionpd(covz, p);

dtf = DTF_A(A2d, D, fftlen);
