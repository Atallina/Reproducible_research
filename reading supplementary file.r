#установка пакета для открытия файлов excel
install.packages("openxlsx")
#подключение библиотеки
library(openxlsx)
supplement_data<-read.xlsx('253_2023_12863_MOESM2_ESM.xlsx',sheet = 2)
summary(supplement_data)
