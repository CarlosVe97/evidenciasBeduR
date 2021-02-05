install.packages('dplyr')
install.packages('readr')
install.packages('fbRanks')
library('dplyr')
library('readr')
library('fbRanks')
# A partir del conjunto de datos de soccer de la liga española de las temporadas 
# 2017/2018, 2018/2019 y 2019/2020, crea el data frame SmallData, que contenga las 
# columnas date, home.team, home.score, away.team y away.score; esto lo puedes 
# hacer con ayuda de la función select del paquete dplyr. Luego crea un directorio
# de trabajo y con ayuda de la función write.csv guarde el data frame como un
# archivo csv con nombre soccer.csv. Puedes colocar como argumento row.names=FALSE 
# en write.csv.

url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
datos1 <- read.csv(file = url1)
datos2 <- read.csv(file = url2)
datos3 <- read.csv(file = url3)


lista <- list(datos1, datos2, datos3)
nlista <- lapply(lista, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
nlista[[1]] <- mutate(nlista[[1]], Date = as.Date(Date, "%d/%m/%y"))
nlista[[2]] <- mutate(nlista[[2]], Date = as.Date(Date, "%d/%m/%Y"))
nlista[[3]] <- mutate(nlista[[3]], Date = as.Date(Date, "%d/%m/%Y"))


SmallData <- select(data, date = Date, home.team = HomeTeam, 
                    home.score = FTHG, away.team = AwayTeam, 
                    away.score = FTAG)
head(SmallData)
write.csv(x = SmallData, file = "soccertest.csv", row.names = FALSE)
# Con la función create.fbRanks.dataframes del paquete fbRanks importa el archivo
# soccer.csv a R y al mismo tiempo asignarlo a una variable llamada listasoccer. 
# Se creará una lista con los elementos scores y teams que son data frames listos
# para la función rank.teams. Asigna estos data frames a variables
# llamadas anotaciones y equipos.
listasoccer <- create.fbRanks.dataframes("soccertest.csv")
anotaciones <- listasoccer$scores
equipos <- listasoccer$teams
# Con ayuda de la función unique crea un vector de fechas (fecha) que no se repitan
# y que correspondan a las fechas en las que se jugaron partidos. Crea una variable
# llamada n que contenga el número de fechas diferentes. Posteriormente, con la función
# rank.teams y usando como argumentos los data frames anotaciones y equipos, crea
# un ranking de equipos usando únicamente datos desde la fecha inicial y hasta la
# penúltima fecha en la que se jugaron partidos, estas fechas las deberá especificar
# en max.date y min.date. Guarda los resultados con el nombre ranking.
unico <- unique(anotaciones$date)
anotaciones$date[n-1]
n <- length(unico)
ranking <- rank.teams(scores=anotaciones, teams=equipos, max.date = unico[n-1] ,min.date = unico[1])
# Finalmente estima las probabilidades de los eventos, el equipo de casa gana,
# el equipo visitante gana o el resultado es un empate para los partidos que se
# jugaron en la última fecha del vector de fechas fecha. Esto lo puedes hacer con
# ayuda de la función predict y usando como argumentos ranking y fecha[n] que deberá
# especificar en date. 
predict(ranking, date= unico[n])
