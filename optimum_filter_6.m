%% design of optimum filter for moise cancellation
% initializing parameters
clear all;
clc;
rng('default');
limit = 6;
w0 = 0.05 * pi;
n1 = [0:limit];
d1 = sin(w0 * n1);
g1 = randn(limit +1, 1);

v1 = zeros(limit +1, 1);
v1(1)= g1(1);
for i = 2:limit +1
  v1(i) = g1(i) + 0.8 * v1(i-1);
end

v2 = zeros(limit +1, 1);
v2(1) = g1(1);
for i = 2:limit+1
  v2(i) = -0.6*(v2(i-1)) + g1(i);
end

x= d1 + v1;
%% calculating the optimum filter coefficients
% calculating the autocorrelation of v2
r2 = zeros(limit +1, 1);
for i = 1:limit +1
  r2(i) = (-0.6)^(i-1);
end
Rv2 = toeplitz(r2);
% calulating the crosscorrelation of v1 and v2
cor_v1_v2 = xcorr(v1, v2,'biased');
cor_v1_v2 = cor_v1_v2(limit +1:end);
w = Rv2\cor_v1_v2
%% calculating the output of the optimum filter
v1_estimate = filter(w,1,v2)
v1
e = v1 - v1_estimate
