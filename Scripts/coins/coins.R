library(rstan)
library(bayesplot)
library(ggplot2)
# Session - Set Working Directory - Source file location 

model <- stan_model(file = "coins.stan")

# В списке переменные надо называть точно также как и в STAN
df <- list(N = 7, y <- c(1, 1, 1, 1, 0, 1, 1))
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


