%% LMS algorithm implementation
function [W, E, X] = my_LMS(d, mu)
N = length(d);
W_e = zeros(N, 2);
Y = zeros(N, 1); % y======> estimated output
E = zeros(N, 1); % e======> error
W_e(1,:) = [0, 0];
W_e(2,:) = [0, 0];
for i = 3:N
  Y(i) = W_e(i-1,1) *d(i-1) + W_e(i-2,2) * d(i-2);
  E(i) = d(i) - Y(i);
  W_e(i,1) = W_e(i-1,1) + mu * E(i) * d(i-1);
  W_e(i,2) = W_e(i-1,2) + mu * E(i) * d(i-2);
end
W = W_e;
X = Y;
end