library(rstan)
library(bayesplot)
# Session - Set Working Directory - Source file location 

model <- stan_model(file = "medved.stan")

# В списке переменные надо называть точно также как и в STAN
df <- list(N = 2, y = c(0.5, -1))
# Получаем выборку из апостериорных распределений:
fit <- sampling(model, data = df)
# Посмотрим на наш fit 
fit

# визуализируем всё это дело 
# апостериорная плотность, распределение нового игрека и логарифмическое правдоподобие
fit_array = as.array(fit)
mcmc_hist(fit_array)

# интерактивные картинки
library("shinystan")
launch_shinystan(fit)
