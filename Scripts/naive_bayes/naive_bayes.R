
df_train <- read.csv("spam_train.csv")   # подгрузили тренировочную выборку
df_test <- read.csv("spam_test.csv")     # подгрузили тестовую выборку 

n_col = ncol(df_train)   # число столбцов
n_row = nrow(df_train)   # число наблюдений
p_spam = 0.5             # априорная вероятность спама 

# сделали срез по всем сообщениям со спамом и нашли сумму по столбцам
words_spam_freq <- colSums(df_train[df_train[,1] == 1,])

# избавились от столбца с ответами и поделили на число спамных строк
words_spam_freq <- words_spam_freq[2:n_col]/sum(df_train[,1] == 1)

# сделали то же самое с неспамными словами 
words_ham_freq <- colSums(df_train[df_train[,1] == 0,])
words_ham_freq <- words_ham_freq[2:n_col]/sum(df_train[,1] == 0)

names(df_test[1,2:n_col])[1]   # выдаст имя первой колонки, то есть слово, 
                               # которому соотвествуют частоты в столбце

# выдаст P(w_i | spam) для этого слова 
words_spam_freq[names(df_test[1,2:n_col])[1]]  

# найдём P(text | spam)*P(spam)
spam = prod(words_spam_freq[names(df_test[,2:n_col])[df_test[1,2:n_col] > 0]])*p_spam
spam

# найдём P(text | ham)*P(ham)
ham = prod(words_ham_freq[names(df_test[,2:n_col])[df_test[1,2:n_col] > 0]])*(1 -p_spam)
ham

df_test[1,1]  # в реальности сообщение спам
spam > ham    # и в прогнозе тоже! УРА! 

# Сделаем прогнозы по всей тестовой выборке
forecasts = c()
for(i in 1: nrow(df_test)){
  spam = prod(words_freq[names(df_test[,2:n_col])[df_test[i,2:n_col] > 0]])*p_spam
  ham = prod(words_ham_freq[names(df_test[,2:n_col])[df_test[i,2:n_col] > 0]])*(1 -p_spam)
  if(spam > ham){
    forecasts = append(forecasts,1)
  }else{
    forecasts = append(forecasts,0)
  }
}

sum(df_test[,1] == forecasts)/length(forecasts)

 