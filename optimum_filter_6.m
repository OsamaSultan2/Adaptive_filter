%% design of optimum filter for moise cancellation
% initializing parameters
clear all;
clc;
rng('default');
limit = 6;
N = 500;
w0 = 0.05 * pi;
n1 = (0:N-1).';
d1 = sin(w0 * n1);
g1 = randn(N, 1);

v1 = zeros(N, 1);
v1(1)= g1(1);
for i = 2:N
  v1(i) = g1(i) + 0.8 * v1(i-1);
end

v2 = zeros(N,1);
v2(1) = g1(1);
for i = 2:N
  v2(i) = -0.6*(v2(i-1)) + g1(i);
end

x1= d1 + v1;
%% calculating the optimum filter coefficients
% calculating the autocorrelation of v2
r2_calculated = my_corr(v2, v2);
r2 = r2_calculated(1:limit +1);
Rv2 = toeplitz(r2);
% calulating the crosscorrelation of v1 and v2
cor_v1_v2     = my_corr(v1, v2);
cor_v1_v2_lim = cor_v1_v2(1:limit +1);
w = Rv2\cor_v1_v2_lim;
%% calculating the output of the optimum filter
v1_estimate = filter(w,1,v2);
e1 = x1 - v1_estimate;







%% designing of 12 order filter
% initializing parameters
rng('default');
limit = 12;
w0 = 0.05 * pi;
n2 = (0:N-1).';
d2 = sin(w0 * n2);
g1 = randn(N, 1);

v1 = zeros(N, 1);
v1(1)= g1(1);
for i = 2:N
  v1(i) = g1(i) + 0.8 * v1(i-1);
end

v2 = zeros(N,1);
v2(1) = g1(1);
for i = 2:N
  v2(i) = -0.6*(v2(i-1)) + g1(i);
end

x2= d2 + v1;
%% calculating the optimum filter coefficients
% calculating the autocorrelation of v2
r2_calculated = my_corr(v2, v2);
r2 = r2_calculated(1:limit +1);
Rv2 = toeplitz(r2);
% calulating the crosscorrelation of v1 and v2
cor_v1_v2     = my_corr(v1, v2);
cor_v1_v2_lim = cor_v1_v2(1:limit +1);
w = Rv2\cor_v1_v2_lim;
%% calculating the output of the optimum filter
v1_estimate = filter(w,1,v2);
e2 = x2 - v1_estimate;




%% plotting the results
figure(1);
subplot(2, 1, 1);
plot(n1,x1,'b');
xlabel('n');
xlim([0 200]);
ylabel('d1(n)');
title(' distorted signal x1(n) sixth order filter');
grid on
subplot(2, 1, 2);
plot(n1,e1,'r');
xlabel('n');
xlim([0 200]);
ylabel("d1(n)");
title("cleaned signal d(n) sixth order filter");
grid on

% 12th order filter
figure(2);
subplot(2, 1, 1);
plot(n2,x2,'b');
xlabel('n');
xlim([0 200]);
ylabel('d2(n)');
title(' distorted signal x2(n) 12th order filter');
grid on
subplot(2, 1, 2);
plot(n2,e2,'r');
xlabel('n');
ylabel("d2(n)");
xlim([0 200]);
title("cleaned signal d(n) 12th order filter");
grid on

