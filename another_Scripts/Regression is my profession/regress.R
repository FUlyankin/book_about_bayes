# Почувствуем обратное гамма-распределение!

library('MCMCpack')
library('ggplot2')

x = rinvgamma(1000,7,8)
qplot(x)
y = rinvgamma(1000,40,8)
qplot(y)
z = rinvgamma(1000,7,40)
qplot(z)

df <- cars
x <- df$speed
y <- df$dist

library(rstan)
library(bayesplot)
# Session - Set Working Directory - Source file location 

model <- stan_model(file = "regress.stan")

# В списке переменные надо называть точно также как и в STAN
dff <- list(N = length(x), x = x, y = y)

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






