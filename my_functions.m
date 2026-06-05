%% correlation function
function output = my_corr(X, Y)
N = length(X);
Z = zeros(N, 1);
for i = 1:N
  Z(i) = (X.') * Y;
  Z(i) = Z(i) / N;
  Y= [zeros(1, 1); Y(1:end-1)];
end
output = Z;
end
%% LMS algorithm implementation
function [W, E, X] = my_LMS(d, mu)
N = length(d);
W_e = zeros(N, 2);
Y = zeros(N, 1); % y======> estimated output

Y(1) =0;
Y(2) =0;
E(1) = d(1) - Y(1);
E(2) = d(2) - Y(2);
W_e(1,:) = [0, 0];
W_e(2,:) = [0, 0];
for i = 3:N
  W_e(i,1) = W_e(i-1,1) + mu * E(i-1) * Y(i-1);
  W_e(i,2) = W_e(i-1,2) + mu * E(i-1) * Y(i-2);
  Y(i) = W_e(i,1) * Y(i-1) + W_e(i,2) * Y(i-2);
  E(i) = d(i) - Y(i);
end
W = W_e;
X = Y;
end


