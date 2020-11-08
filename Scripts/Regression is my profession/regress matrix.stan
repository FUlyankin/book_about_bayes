// Тут лежат данные
data{
  int N;             // число наблюдений
  // int N2;            // число наблюдений для прогноза
  int P;             // число регрессоров 
  vector[N] y;         // наблюдения у
  matrix[N,P] X;     // наблюдения х
//  matrix[N2,P] X_new; // наблюдения для прогноза
}
// Тут лежат параметры
parameters{
  vector[P] beta;     // параметры для нашего уравнения! 
  real<lower=0> sigma; 
}
model{
  // априорно:
  for(i in 1:P){
    beta[i] ~ normal(0,30);
  }
  sigma ~ inv_gamma(7,40);
  //for(i in 1:N){
  //sigma[i] ~ inv_gamma(7, 40);
  //}
  // модель: как наблюдения связаны с параметром
  y ~ normal(X*beta, sigma);
}
generated quantities {
  vector[N] y_new; // какая скорость следующая?
  // тильда не означает генерации случайных чисел, это лишь наше мнение
  y_new = normal_rng(X*beta, sigma); // генерация будущего игрека
  // если с матрицей X_new
  // vector[N2] y_pred;
  // y_pred = X_new*beta; 
}
// Чтобы было коректно в последней строке традиционно энтер
