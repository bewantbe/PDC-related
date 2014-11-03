%
f_SM = @(x) real(mean(x.*conj(x),3));

%D = [1.0, 0.4; 0.4, 0.7];
%D = [1.0, 0.0; 0.0, 0.7];
%D = [1.0, 0.0; 0.0, 1.0];

%A2d = [-0.9 ,  0.6, 0.5, 0.1;
       %-0.16, -0.8, 0.2, 0.5];

%A2d = [-0.9 ,  0.0, 0.5, 0.0;
       %-0.016, -0.8, 0.02, 0.5];
%A2d = [-0.9 ,  0.0, 0.5, 0.0;
       %-0.16, -0.8, 0.2, 0.5];
%A2d = [-0.9 ,  0.0, 0.5, 0.0;
       %-0.6, -0.8, 1.2, 0.5];
%A2d = [-0.9 ,  0.0, 0.5, 0.0;
       %-1.6, -0.8, 4.2, 0.5];

D = diag([0.3 1.0 0.2]);
A2d = [-0.8  0.0 -0.4  0.5 -0.2  0.0;
        0.0 -0.9  0.0  0.0  0.8  0.0;
        0.0 -0.5 -0.5  0.0  0.0  0.2];

ARroots(A2d);  % check if the system is stable

%D = eye(2);
%A2d = [-0.9 ,  0.0, 0.5, 0.0;
       %-0.016, -0.8, 0.002, 0.5];

od = 99;
fftlen = 8192;
S = A2S_new(A2d, D, fftlen);
R = S2cov(S, od);

% compare GC and PDC square mean
GC = RGrangerT(R);
EXPm1_GC = expm1(GC)
GPDC_SM = f_SM( GPDC_R(R) )
uGPDC_SM = f_SM( uGPDC_R(R) )
m_G_uG = 0.24*GPDC_SM + 0.76*uGPDC_SM

SW = StdWhiteS(S);
RW = S2cov(SW, od);

% compare GC and PDC square mean for whitenned data
GC_W = RGrangerT(RW);
GPDC_W_SM = f_SM( GPDC_R(RW) );
uGPDC_W_SM = f_SM( uGPDC_R(RW) );

maxabs = @(x) max(abs(x(:)));
if maxabs(GC_W - GC)>1e-9
  GC_W - GC
  warning('GC is Not filter invariant!!');
end
if maxabs(GPDC_SM - GPDC_W_SM)>1e-9
  GPDC_W_SM - GPDC_SM
  warning('GPDC is Not filter invariant!!');
end
if maxabs(uGPDC_SM - uGPDC_W_SM)>1e-9
  uGPDC_W_SM - uGPDC_W_SM
  warning('uGPDC is Not filter invariant!!');
end

