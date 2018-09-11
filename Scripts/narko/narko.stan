// Тут лежат данные
data{
  int N;    // число наблюдений
  int y[N]; // вектор ололо и юпи
  real q;
}
// Тут лежат параметры
parameters{
  real<lower=0, upper=1> p; // доля поробовавших
  //real<lower=0, upper=1>q; // вероятность выпадения орла на монете
}
model{
  // априорно:
  p ~ uniform(0, 1);
  // модель: как наблюдения связаны с параметром
  for (n in 1:N) {
    //y[n] ~ bernoulli(0.25*p + 0.75*(1-p));
    y[n] ~ bernoulli(q*p + (1-q)*(1-p));
    //[n] ~ bernoulli(p);
  }
}
