%% Adaptive filter implementation using the Least Mean Squares (LMS) algorithm
% initializing parameters
rng('default');
N = 1000;
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
[E1, W1, X1] = my_LMS(d, mu1);
[E2, W2, X2] = my_LMS(d, mu2);
%% plotting the results and the learning curve
i = 1:N;
figure(1);
subplot(2, 1, 1);
plot(i,W1,'r');
xlabel('iteration');
ylabel('filter coefficients value (W1)');
title('LMS filter coefficients with step size 0.02');
grid on
subplot(2, 1, 2);
plot(i,E1,'b');
xlabel('iteration');
ylabel('error value (E1)');
title('LMS error with step size 0.02');
grid on
% STEP SIZE 0.04
figure(2);
subplot(2, 1, 1);
plot(i,W2,'r');
xlabel('iteration');
ylabel('filter coefficients value (W2)');
title('LMS filter coefficients with step size 0.04');
grid on
subplot(2, 1, 2);
plot(i,E2,'b');
xlabel('iteration');
ylabel('error value (E2)');
title('LMS error with step size 0.04');
grid on
%% waiting !