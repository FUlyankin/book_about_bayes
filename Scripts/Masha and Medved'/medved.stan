data{
  int N; // число наблюдений
  real y[N]; // отдельные наблюдения (вектор длины N)
}
parameters{
  real m; // место, где прячется Маша
}
model{
  // априорно:
  m ~ uniform(0,10);
  // модель: как наблюдения связаны с параметром
  for (n in 1:N) {
    y[n] ~ normal(m,2);
  }
}
generated quantities {
  real y_new; // что вынюхает новый медвед
  y_new = normal_rng(m,2); // генерация будущего медведа
}
