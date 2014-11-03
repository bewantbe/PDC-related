% test the effect of whiten

f_SM = @(x) real(mean(x.*conj(x),3));

D = [1.0, 0.4; 0.4, 0.7];
%D = [1.0, 0.0; 0.0, 0.7];
A2d = [-0.9 ,  0.6, 0.5, 0.1;
       -0.16, -0.8, 0.2, 0.5];
%A2d = [-0.9 ,  0.0, 0.5, 0.0;
       %-0.016, -0.8, 0.02, 0.5];

%D = eye(2);
%A2d = [-0.9 ,  0.0, 0.5, 0.0;
       %-0.016, -0.8, 0.002, 0.5];

od = 199;
fftlen = 65536;
S = A2S_new(A2d, D, fftlen);
R = S2cov(S, od);

% compare GC and PDC square mean
GC = RGrangerT(R)
PDC_SM = f_SM( PDC_R(R) )
GPDC_W_SM = f_SM( GPDC_R(R) )

SW = StdWhiteS(S);
RW = S2cov(SW, od);

% compare GC and PDC square mean for whitenned data
GC_W = RGrangerT(RW)
PDC_W_SM = f_SM( PDC_R(RW) )

GPDC_W_SM = f_SM( GPDC_R(RW) )

