install.packages('dplyr')
library('dplyr')
library('hydroTSM')
# Importa el conjunto de datos match.data.csv a R y realiza lo siguiente:
match_data <- read.csv('match.data.csv')
str(match_data)
head(match_data)
match_df <- as.data.frame(match_data)
# Agrega una nueva columna sumagoles que contenga la suma de goles por partido.
match_df$sumadegoles <- match_df$home.score + match_df$away.score 
head(match_df)
# Obtén el promedio por mes de la suma de goles.
match_df <- mutate(match_df, date = as.Date(date, "%Y-%m-%d"))
match_df <- mutate(match_df, mes = format(date, "%Y-%m"))
promedio_mensual <- group_by(match_df, mes) %>% summarise(mean = mean(sumadegoles))
promedio_mensual

# Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.
serie_de_tiempo <- ts(promedio_mensual$mean, frequency = 12,end = c(2019,12))

# Grafica la serie de tiempo.
plot(serie_de_tiempo)
