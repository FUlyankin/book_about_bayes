# загрузим ряд 
library(sophisthse)
View(series_info)
df <- sophisthse('UNEMPL_M')
str(df)
# sophist.hse.ru

# 1. ETS - предшественник BS-TS
library(forecast)  # ETS (предшественник BS-TS)
# Модель определяется по табличкам из Hydman
model_ets <- ets(df, model = "AAA",dampe = FALSE) # A - сама модель для ряда # A - тренд  # A - сезонность
model_ets

forecast(model_ets, h=4)
# * интерпретируема
model_ets$states
tsdisplay(model_ets$states[,3])
tsdisplay(model_ets$states[,2])
plot(model_ets)

model_auto_ets <- ets(df)
model_auto_ets


# 2. bayesian structural time series 
# априорное распределение
# модель данных 
# * одномерных временных рядов 
# * интерпретируемы (в отличие от ARIMA)

library(bsts)      # bayesian structural TS 
library(tidyverse) # data manipulation

# Спецификация модели и баесовские предположения
# Тут мы только специфицировали модель. Все баесовски предположения дефолтные
# Можно порыться в пакете и указать дофигище распределений. 
model_structure <- list( ) %>% 
  AddLocalLinearTrend(df) %>% 
  AddSeasonal(df, nseasons = 12)

model <- bsts(df, state.specification = model_structure, niter = 1000)
forecast <- predict.bsts(model, h = 4)
forecast$mean
forecast$median
forecast$interval
qplot(x = forecast$distribution[, 2])

plot(model, "comp")

# ETS vs ARIMA vs others 
library(forecastHybrid)
model_hybrid <- hybridModel(df[, 1], model = "aef") # f - theta-метод 
# У нас матрицы 276х1, а он хочет вектор. Вредина. 
# Ещё в пакете есть простенькие нейронки... 
# Прогнозы моделей усредняются 
forecast(model_hybrid, h = 4)








