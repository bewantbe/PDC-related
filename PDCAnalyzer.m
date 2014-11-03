% Calculate and show Partial Directed Coherence (PDC)
% and Directed Transfer Function (DTF)
% Example:
%  A2d=[
%   0.5  0.3 -0.4
%  -0.5  0.3 -0.1
%   0.0 -0.3  0.2];  % same graph as the paper (Fig.1)
%  D = diag([1,1,1]);
%  X = gendata_linear(A2d, D, 1e5);
%  [mpdc, ~, mdtf, ~] = PDCAnalyzer(X, 3);

function [mean_sqr_pdc, pdc, mean_sqr_dtf, dtf] = PDCAnalyzer(X, is_plot)
if ~exist('is_plot','var')
  is_plot = 0;
end
fftlen = 1024;
p = size(X, 1);
m = chooseOrderAuto(X);

f_mean_sqr = @(c) real(mean( c.*conj(c), 3 ));

pdc = PDC(X, m, fftlen);
mean_sqr_pdc = f_mean_sqr(pdc);

if is_plot == 1 || is_plot == 3
  global g_figure_id
  if ~isempty(g_figure_id)
    figure(g_figure_id + 0);
  else
    figure(91);
  end
  fqn = 1:fftlen/2;
  fqs = fqn / fftlen;
  for j = 1 : p
    for k = 1 : p
      subplot(p,p,(j-1)*p+k);
      area(fqs, abs(squeeze(pdc(j,k,fqn))));
      axis([0, 0.5, 0, 1]);
      set(gca, 'XTickLabel','');
      set(gca, 'XTick', []);
      set(gca, 'YTickLabel','');
      set(gca, 'YTick', []);
    end
  end
end

dtf = DTF(X, m, fftlen);
mean_sqr_dtf = f_mean_sqr(dtf);

if is_plot == 2 || is_plot == 3

  global g_figure_id
  if ~isempty(g_figure_id)
    figure(g_figure_id + 1);
  else
    figure(92);
  end
  fqn = 1:fftlen/2;
  fqs = fqn / fftlen;
  for j = 1 : p
    for k = 1 : p
      subplot(p,p,(j-1)*p+k);
      area(fqs, abs(squeeze(dtf(j,k,fqn))));
      axis([0, 0.5, 0, 1]);
      set(gca, 'XTickLabel','');
      set(gca, 'XTick', []);
      set(gca, 'YTickLabel','');
      set(gca, 'YTick', []);
    end
  end
end
