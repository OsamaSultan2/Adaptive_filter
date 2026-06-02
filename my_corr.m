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