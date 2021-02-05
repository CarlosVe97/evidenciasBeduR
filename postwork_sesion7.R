install.packages('mongolite')
install.packages('knitr')
install.packages('markdown')
install.packages('tidyverse')
library('mongolite')
library('knitr')
library('markdown')
library('tidyverse')
#Nota, para correr lo de abajo hay que correr el server de mongo desde la terminal
my_collection = mongo(collection = "match", db = "match_games") # create connection, database and collection
setwd('/home/carlos/Downloads/Programacion-con-R-Santander-master/Sesion-07/Postwork')
datos_a_subir<- read.csv('data.csv')
datos_a_subir
my_collection$insert(datos_a_subir)
#Una vez hecho esto, realizar un count para conocer el número de 
#registros que se tiene en la base
my_collection$count()
# Realiza una consulta utilizando la sintaxis de Mongodb, en la base de datos
# para conocer el número de goles que metió el Real Madrid el 20 de diciembre de
# 2015 y contra que equipo jugó, ¿perdió ó fue goleada?

#Aqui debido a que no se encuentra esa fecha buscaremos otra, realizando el query
#con la sintaxis de mongodb
my_collection$find('{"$or" : [{"HomeTeam":"Real Madrid"}, {"AwayTeam": "Real Madrid"}], "Date" : "2017-08-20"}')

#Agrega el dataset de mtcars a la misma BDD Por último, no olvides cerrar
#la conexión con la BDD.
#mantenemos la misma BDD pero cambiamos la coleccion
para_mtcars = mongo(collection = "mtcars", db = "match_games") # create connection, database and collection
para_mtcars$insert(mtcars)
para_mtcars$count()

#Luego para cerrar la conexion nos desconectamos desde la terminal
# con sudo systemctl stop mongod