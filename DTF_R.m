% calculate DTF

function dtf = DTF_R(R, fftlen)
if ~exist('fftlen','var')
  fftlen = 1024;
end
p = size(R, 1);

[A2d, D] = ARregression(R);

dtf = DTF_A(A2d, D, fftlen);
