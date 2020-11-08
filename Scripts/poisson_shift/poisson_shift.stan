data{
  int N; 
  int y[N]; 
}
parameters{
  real <lower=1, upper=70> tau;  // момент сдвига
  real <lower=0> lambda1;
  real <lower=0> lambda2;
}
model{
  // априорно:
  tau ~ uniform(1, 70); 
  lambda1 ~ exponential(0.05);
  lambda2 ~ exponential(0.05);
  // модель: как наблюдения связаны с параметром
  for (n in 1:N) {
    if(n < tau){
      y[n] ~ poisson(lambda1);
    }else{
      y[n] ~ poisson(lambda2);
    }
  }
}

// Чтобы было коректно в последней строке традиционно энтер
