library('bayesplot')  # plots
library('rstanarm')   # ready made models
library('loo')        # leave one out
library('HSAUR3')     # just for datasets

# ols 
mod <- stan_lm(data = cars, dist ~ speed, prior = R2(location = 0.5, what = 'mean'), #по дефолту локатион моды
                     prior_intercept = normal(0, 10))

?stan_lm 


# loo 
loo_1 <- loo(mod)
loo_2 <- loo(mod_2)

diff(loo_1, loo_2)


# get code 
stancode <- rstan::get_stancode(mod$stanfit)
cat(stancode)

# some plots 
mcmc_hist(as.array(mod), pars = c("sigma",'speed'))
mcmc_violin(as.array(mod), pars = c("sigma",'speed'))
mcmc_intervals(as.array(mod))

mod$stan_summary


# logit
library('dplyr')
glimpse(womensrole)
View(womensrole)
# respondents
sum(womensrole$agree) + sum(womensrole$disagree)

mod_logit <- stan_glm(data = womensrole, cbind(agree,disagree)~ education + gender,
                      family = binomial(link = 'logit'),
                      prior = normal(0,10),
                      prior_intercept = normal(0,10)
                      )
mod_logit
summary(mod_logit,digits = 3)
mcmc_violin((as.array(mod_logit)))

new_data <- data_frame(education = c(16,17), gender  = c("Male",'Male'),
                       agree = c(20,20), disagree = c(0,0))
posterior_interval(mod_logit)
posterior_vs_prior(mod_logit)

predict(mod_logit, newdata = new_data)

forecast <- posterior_predict(mod_logit, newdata = new_data)
str(forecast)
library('ggplot2')
qplot(forecast[,1])
# Если мы возьмём 20 первых филиппов, то вероятность того, что большинство из них
# согласятся с утверждением о том, что место женщины на кухне очень мала. 
# От 0 Филиппов до 5 соглашаются с тем, что место женщины у плиты. 
qplot(forecast[,2])
# 20 филиппов на год умнее. Распределение ползёт влево. Вероятность того,
# что согласится 10 Филиппов нулевая! 


# Что модно? 
mod_logit2 <- stan_glmer(data = womensrole, cbind(agree,disagree) ~ (education | gender),
                      family = binomial(link = 'logit'),
                      prior = normal(0,10),
                      prior_intercept = normal(0,10)
)
# Я предполагаю, что у каждой группы коэффициент при education свой. 


help(package = 'bayesplot')
help(package = 'rstanarm')




library('bsts')  # for time series












