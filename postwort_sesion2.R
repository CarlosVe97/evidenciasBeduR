
#POSTWORK 2 
#CARLOS ALEJANDRO VELAZQUEZ VALDEZ
#EQUIPO 17
#Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la 
#primera división de la liga española a R, los datos los puedes encontrar en el siguiente 
#enlace: https://www.football-data.co.uk/spainm.php
library('dplyr')
getwd()
setwd('/home/carlos/Documents/BeduCursoR/Programacion-con-R-Santander-master/Sesion-02/datosPostwork')
data_soccer <- lapply(dir(), read.csv)
#Obten una mejor idea de las características de los data frames al usar 
#las funciones: str, head, View y summary
str(data_soccer)
head(data_soccer)
View(data_soccer)
summary(data_soccer)
# Con la función select del paquete dplyr selecciona únicamente las columnas 
# Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data frames. 
# (Hint: también puedes usar lapply).
data_soccer_columns <- lapply(data_soccer,select, Date,HomeTeam,AwayTeam,FTHG,FTAG,FTR)
data_soccer_columns
# Asegúrate de que los elementos de las columnas correspondientes de los 
# nuevos data frames sean del mismo tipo (Hint 1: use as.Date y mutate para arreglar las fechas).
str(data_soccer_columns)
for (i in 1:3){
data_soccer_columns[[i]] <- mutate(data_soccer_columns[[i]], Date = as.Date(Date, "%d/%m/%Y"))
}
# Con ayuda de la función rbind forma un único data frame que contenga las seis columnas mencionadas 
# en el punto 3 (Hint 2: la función do.call podría ser utilizada).
soccer_full <- do.call(rbind, data_soccer_columns)
soccer_full
dim(soccer_full)
str(soccer_full)
save(soccer_full, file="df_pw_sesion2")
dir()
getwd()
