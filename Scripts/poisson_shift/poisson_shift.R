library(rstan)
library(bayesplot)

df <- read.csv("message.csv")
y <- df$message_cnt
model <- stan_model(file = "poisson_shift.stan")

# В списке переменные надо называть точно также как и в STAN
dff <- list(N = length(y), y = y)

# Получаем выборку из апостериорных распределений:
fit <- sampling(model, data = dff,iter = 5000)

# Посмотрим на наш fit 
fit

# визуализируем всё это дело 
fit_array = as.array(fit)
mcmc_hist(fit_array)
# апостериорная плотность, распределение нового игрека и логарифмическое правдоподобие

library("shinystan")
launch_shinystan(fit)


# Картинка для динамики сообщений 
ggplot(df, aes(x=1:length(y), y=message_cnt))+
  geom_bar(stat="identity", width=0.7, fill="steelblue") + 
  xlab('Days') + ylab('Count') + 
  geom_line(aes(x=1:length(y), y=c(rep(mean(y[1:45]),45),rep(NaN,29))),col='red',size=1)  +
  geom_line(aes(x=1:length(y), y=c(rep(NaN,45),rep(mean(y[45:length(y)]),29))),col='red',size=1)

