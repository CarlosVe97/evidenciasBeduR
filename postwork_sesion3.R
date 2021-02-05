 
# Con el último data frame obtenido en el postwork de la sesión 2, elabora 
# tablas de frecuencias relativas para estimar las siguientes probabilidades:
setwd("/home/carlos/Documents/BeduCursoR/Programacion-con-R-Santander-master/Sesion-02/datosPostwork")
df_soccer <- load('df_pw_sesion2')
# La probabilidad (marginal) de que el equipo que juega en casa anote x
# goles (x=0,1,2,)
soccer_full
dim(soccer_full)[1]
prob_rel_1 <- table(soccer_full$FTHG)/dim(soccer_full)[1]

 # La probabilidad (marginal) de que el equipo que juega como visitante anote 
# y goles (y=0,1,2,)
prob_rel_2 <- table(soccer_full$FTAG)/dim(soccer_full)[1]

# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles 
#y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
prob_rel_3 <- table(soccer_full$FTHG, soccer_full$FTAG)/dim(soccer_full)[1]

# Realiza lo siguiente:
# Un gráfico de barras para las probabilidades marginales estimadas del número 
# de goles que anota el equipo de casa
prob_df_1 <- as.data.frame(prob_rel_1)
prob_df_1

ggplot(prob_df_1, aes(x=Var1, y=Freq)) + geom_bar(stat='Identity')
#Un gráfico de barras para las probabilidades marginales estimadas del número
#de goles que anota el equipo visitante.
prob_df_2 <- as.data.frame((prob_rel_2))
ggplot(prob_df_2, aes(x=Var1, y=Freq)) + geom_bar(stat='Identity')

# Un HeatMap para las probabilidades conjuntas estimadas de los números de 
# goles que anotan el equipo de casa y el equipo visitante en un partido.
prob_mat_3 <- as.matrix(prob_rel_3) 
heatmap(prob_mat_3, scale = 'none')
