%% Adaptive filter implementation using the Least Mean Squares (LMS) algorithm
% initializing parameters
rng('default');
N = 900; % Number of samples
v = randn(N, 1);
d = zeros(N, 1);
d(1) = v(1);
d(2) = v(2);
for i = 3:N
  d(i) = 1.2728 * d(i-1) - 0.81 * d(i-2) + v(i);
end
mu1 = 0.02;
mu2 = 0.04;
%% LMS algorithm implementation
[W1, E1, X1] = my_LMS(d, mu1);
[W2, E2, X2] = my_LMS(d, mu2);
%% plotting the results and the learning curve
i = 1:N;
figure(1);
subplot(2, 1, 1);
plot(i,W1(:,1),'r');
hold on;
plot(i,W1(:,2),'b');
xlabel('iteration');
ylabel('filter coefficients value (W1)');
title('LMS filter coefficients with step size 0.02');
grid on
legend('W1(1)', 'W1(2)');
subplot(2, 1, 2);
plot(i,E1,'b');
xlabel('iteration');
ylabel('error value (E1)');
title('LMS error with step size 0.02');
grid on


% STEP SIZE 0.04
figure(2);
subplot(2, 1, 1);
plot(i,W2(:,1),'r');
hold on;
plot(i,W2(:,2),'b');
xlabel('iteration');
ylabel('filter coefficients value (W2)');
title('LMS filter coefficients with step size 0.04');
grid on
legend('W2(1)', 'W2(2)');
subplot(2, 1, 2);
plot(i,E2,'b');
xlabel('iteration');
ylabel('error value (E2)');
title('LMS error with step size 0.04');
grid on
%% POWER SPECTRAL DENSITY
num = 1;
den = [1, -1.2728, 0.81];
%transfer function = 1 / (1 - 1.2728 z^-1 + 0.81 z^-2)
[H, w_freq] = freqz(num, den, 1024, 'whole');
PSD = abs(H).^2;
figure(3);
plot(w_freq/pi, PSD);
title('Power Spectral Density of x(n)');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Power/Frequency');
grid on;
%% AUTOCORRELATION
r = my_corr(d,d); % calculate autocorrelation of d(n)
rx = r(1:2); % take the first two values to form the autocorrelation matrix
Rx =  toeplitz(rx) %generating the autocorrelation matrix
Eigenvalues = eig(Rx) % calculate the eigenvalues of the autocorrelation matrix
lambda_max = max(Eigenvalues) % maximum eigenvalue
mu_bound = 2/(lambda_max) % calculate the upper bound for the step size