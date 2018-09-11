data{
  int N;      // число наблюдений
  int y[N];  // был ли деффект
  vector[N] t;  // температура
}
parameters{
  real alpha;
  real beta; 
}
model{
  // априорно:
  alpha ~ normal(0,0.01);
  beta ~ normal(0,0.01);
  // модель: как наблюдения связаны с параметром
  y ~ bernoulli_logit(alpha + beta*t);
}
