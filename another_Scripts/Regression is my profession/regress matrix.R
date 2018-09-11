# Почувствуем обратное гамма-распределение!

library('MCMCpack')
library('ggplot2')

df <- mtcars
y <- df$mpg
X <- as.matrix(df)[,-1]
X

library(rstan)
library(bayesplot)
# Session - Set Working Directory - Source file location 

model <- stan_model(file = "regress matrix.stan")

# В списке переменные надо называть точно также как и в STAN
dff <- list(N = nrow(x),P = ncol(X), X = X, y = y)

# Получаем выборку из апостериорных распределений:
fit <- sampling(model, data = dff)

# Посмотрим на наш fit 
fit

# визуализируем всё это дело 
fit_array = as.array(fit)
mcmc_hist(fit_array)
# апостериорная плотность, распределение нового игрека и логарифмическое правдоподобие

traditional_model <- lm(data = df, dist~speed)
summary(traditional_model)






