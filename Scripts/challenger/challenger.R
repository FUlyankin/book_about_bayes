library(rstan)
library(bayesplot)
# Session - Set Working Directory - Source file location 

model <- stan_model(file = "challenger.stan")
df <- read.csv('challenger.csv', sep='\t')
t = df$Temperature
y = df$Damage.Incident
t_new = 31

# В списке переменные надо называть точно также как и в STAN
df <- list(N = length(y), y = y, t = t)
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
