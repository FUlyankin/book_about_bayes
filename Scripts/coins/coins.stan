// Тут лежат данные
data{
  int N; // число наблюдений
  int y[N]; // отдельные наблюдения (вектор длины N)
}
// Тут лежат параметры
parameters{
  real<lower=0, upper=1> p; // доля золотых монет в шляпе
}
model{
  // априорно:
  p ~ uniform(0, 1);
  // модель: как наблюдения связаны с параметром
  for (n in 1:N) {
    y[n] ~ bernoulli(p);
  }
}
generated quantities {
  int y_new; // какая монетка следующая?
  // тильда не означает генерации случайных чисел, это лишь наше мнение
  y_new = bernoulli_rng(p); // генерация будущего игрека
}
// Чтобы было коректно в последней строке традиционно энтер
