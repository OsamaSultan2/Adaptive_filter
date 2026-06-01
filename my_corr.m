function output = my_corr(X, Y)
N = length(X);
Z = zeros(N, 1);
Y_mat = toeplitz(Y);
for i = 1:N
  Z(i) = (X.') * Y_mat(:, i);
  Z(i) = Z(i) / N;
end
output = Z;
end