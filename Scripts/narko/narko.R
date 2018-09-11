library(rstan)
library(bayesplot)
# Session - Set Working Directory - Source file location 

model <- stan_model(file = "narko.stan")

# В списке переменные надо называть точно также как и в STAN
df <- list(N = 14, y <- c(1,1,1,1,1,1,1,1,1,1,0,0,0,0), q = 0.01)
# Получаем выборку из апостериорных распределений:
fit <- sampling(model, data = df)
# Посмотрим на наш fit 
fit

p = extract(fit)$p
qplot(p)

# визуализируем всё это дело 
fit_array = as.array(fit)
mcmc_hist(fit_array)
# апостериорная плотность, распределение нового игрека и логарифмическое правдоподобие

# И ещё один красивый рисунок! 
mcmc_trace(fit_array)

library("shinystan")
launch_shinystan(fit)


