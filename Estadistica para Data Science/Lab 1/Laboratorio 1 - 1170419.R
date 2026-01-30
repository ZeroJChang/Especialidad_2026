#Directorio de Datos
setwd("C:/Users/jdele/OneDrive/Escritorio/Maestria/Estadistica para Data Science/Lab 1")

#Cargar Librerias
library(tidyverse) #funcion para cargar libreria R para manipular Datos

#Paso 1
#Cargo el archivo que voy a utilizar
df <- read.csv("Credit.csv")

#Ver la estructura
str(df)

#Convertir las variables en tipo necesario
#Convertir variables de caracter a factor
df$Gender <- as.factor(df$Gender)
df$Student <- as.factor(df$Student)
df$Married <- as.factor(df$Married)
df$Ethnicity <- as.factor(df$Ethnicity)


#Pregunta 1
#DLYR MANIPULACION DE DATOS

tabla_genero <- df %>%
  count(Gender) %>%
  mutate(Porcentaje = n/sum(n)*100)

str(tabla_genero)

#Libreria para graifcar GGPLOT2
library(ggplot2)

#Estructura del grafico
ggplot(df, aes(x = Gender, fill = Gender)) + geom_bar() + labs(title = "Distribucion de Genero de los Clientes", subtitle = "Conteo de hombres y mujeres", x = "Genero", y = "cantidad")
+ theme_dark()

# PRegunta2
summary(df)


# Pregunta 3 
#Relacion entre tarjeta y balance 
ggplot(df, aes(x =Cards, y = Balance)) + geom_point() + geom_smooth(method = "lm", color = "red")
+ labs(title = "Relacion entre tarjetas y saldo",
       x = "Tarjetas",
       y = "Saldo de la tarjeta")


#TablaCruzada entre etnia y estado civil
tabla_etnia_estado <- df %>%
  count(Ethnicity, Married) 

tabla_etnia_estado2 <- df %>%
  group_by(Ethnicity, Married)%>%
  summarise(Promedio_income = mean(Income))

ggplot(df, aes(x = Ethnicity, fill = Married ))+ geom_bar(position = "dodge")+
  labs(title = "Relacion entre Etnia y estado civil",
       x = "Etnia",
       y = "Cantidad")+ theme_gray()


#Pregunta 5
resumen_balance_genero_etnia <- df %>% 
  group_by(Ethnicity, Gender)%>%
  summarise(Promedio_balance = mean (Balance), cantidad = n())

#Pregunta 6
#Relacion entre Saldo y Ingreso 
# variable en donde se tendra una tabla con la relacion entre balance e ingreso
ggplot(df, aes(x = Income, y = Balance)) +
  geom_point() +
  geom_smooth(method = "lm", color = "blue") +
  labs(title = "Relación entre Ingreso y Saldo",
       x = "Ingreso",
       y = "Balance") +
  theme_minimal()
#Pregunta 7

clientes_tarjeta_2 <- df %>% 
  filter( Cards >= 2 )

clientes_tarjeta_2 <- df %>% 
  filter( Cards >= 2, Age <= 50 ) %>% 
  group_by(Ethnicity) %>%
  summarise(Cantidad = n(), Promedio_ingreso= mean(Income))

# Pregunta 8
# Relacion entre Edad y numero de tarjetas
ggplot(df, aes(x = Age, y = Cards)) +
  geom_point() +
  geom_smooth(method = "lm", color = "blue") +
  labs(
    title = "Relacion entre Edad y Numero de Tarjetas",
    x = "Edad",
    y = "Numero de Tarjetas"
  ) +
  theme_minimal()


# Pregunta 9
# Promedio de Balance por estado civil y si es estudiante
promedio_balance_estadoCivil_Estudiante <- tapply(
  df$Balance,
  list(df$Married, df$Student),
  mean
)
dimnames(promedio_balance_estadoCivil_Estudiante) <- list(
  "Estado Civil" = c("No Casado", "Casado"),
  "Es Estudiante" = c("No", "Sí")
)


promedio_balance_estadoCivil_Estudiante


# Pregunta 10
# Promedio de balance por estado civil y genero
resumen_balance <- df %>%
  group_by(Married, Gender) %>%
  summarise(Promedio_Balance = mean(Balance))

ggplot(resumen_balance, aes(x = Married, y = Promedio_Balance, fill = Gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Saldo Promedio por Estado Civil y Genero",
    x = "Estado Civil",
    y = "Saldo Promedio"
  ) +
  theme_classic()


