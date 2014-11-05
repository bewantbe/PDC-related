% calculate PDC

function [pdc2,gpdc2,ugpdc2,GC,gpdc3,ugpdc3] = PDCall(X, m, fftlen)

f_mean_sqr = @(c) real(mean( c.*conj(c), 3 ));

if ~exist('fftlen','var')
  fftlen = 1024;
end
[p, len] = size(X);

covz = getcovzpd(X, m);
[A2d, D] = ARregressionpd(covz, p);

pdc = PDC_A(A2d, D, fftlen);
gpdc = GPDC_A(A2d, D, fftlen);
ugpdc = uGPDC_A(A2d, D, fftlen);

pdc2 = f_mean_sqr(pdc);
gpdc2 = f_mean_sqr(gpdc);
ugpdc2 = f_mean_sqr(ugpdc);
% ugpdc3 = f_mean_sqr(ugpdc);
ugpdc3 = real(mean(log(1+ugpdc.*conj(ugpdc)),3));ugpdc3 = ugpdc3 - diag(diag(ugpdc3));

GC = pos_nGrangerT2(X,m);
% GC2 = exp(GC)-ones(p);
gpdc3 = real(mean(-log(1-gpdc.*conj(gpdc)),3));gpdc3 = gpdc3 - diag(diag(gpdc3));



% As = [-0.9 ,  0.0, 0.5, 0.0;-1.6, -0.8, 4.2, 0.5];