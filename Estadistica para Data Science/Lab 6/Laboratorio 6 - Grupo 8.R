setwd("C:/Users/jdele/OneDrive/Escritorio/Maestria/Estadistica para Data Science/Lab 6")

#Cargar Librerias a utilizar
library(dplyr)
library(ggplot2)
library(mice)
library(corrplot)
library(psych)

#Cargar Datos
df <- read.csv("diamantes.csv", sep = ";", stringsAsFactors = TRUE)


#Hacer resumen general
summary(df)

#Hago proceso de imputacion de variable faltantes
imputacion <- mice(df, m= 1, method = "pmm", maxit = 5)
df_limpio <- complete(imputacion)

summary(df_limpio)

#hago el proceso de suavisar valores atipicos
suavizar <- function(x){
  H <- 1.5*IQR(x, na.rm = T)
  qnt <- quantile(x, probs = c(0.25,0.75))
  caps <- quantile(x, probs = c(0.05,0.95))
  x[x<(qnt[1]-H)] <- caps[1]
  x[x>(qnt[2]+H)] <- caps[2]
  return(x)
}

boxplot(df_limpio$price)

#Aplico las variables
df_limpio$x <- suavizar(df_limpio$x)
df_limpio$y <- suavizar(df_limpio$y)
df_limpio$z <- suavizar(df_limpio$z)
df_limpio$price <- suavizar(df_limpio$price)
summary(df_limpio)

df_limpio <- df_limpio %>%
  mutate(
    x = suavizar(df_limpio$x),
    y = suavizar(df_limpio$y),
    z = suavizar(df_limpio$z),
    price = suavizar(df_limpio$price),
    
  )
corr <- cor(df_num)

#visualizo la correlacion de todas las variables
corrplot(corr)

#hago la regresion lineal
regresion_lineal <- lm(price ~ carat + depth + table + x + y + z + cut + color + clarity,
                       data = df_limpio)

summary(regresion_lineal)


regresion_lineal <- lm(price ~ carat + depth + table + x + cut + color + clarity,
                       data = df_limpio)


#Laboratorio 6
#Ejercicio 1
#verificar valores faltantes
colSums(is.na(df))

#Ejercicio 3

#Hago proceso de imputacion de variable faltantes
imputacion <- mice(df, m= 1, method = "pmm", maxit = 5)
df_limpio <- complete(imputacion)

#Ejercicio 4
#Valores atipicos
df <- read.csv("diamantes.csv", sep = ";", stringsAsFactors = TRUE)
boxplot(df$x, main="Boxplot dimensión X")
boxplot(df$y, main="Boxplot dimensión Y")
boxplot(df$z, main="Boxplot dimensión Z")

df_limpio$x <- suavizar(df_limpio$x)
df_limpio$y <- suavizar(df_limpio$y)
df_limpio$z <- suavizar(df_limpio$z)
boxplot(df_limpio$x, main="Boxplot dimensión X")
boxplot(df_limpio$y, main="Boxplot dimensión Y")
boxplot(df_limpio$z, main="Boxplot dimensión Z")

#ejercicio 5
#Distribución de variables categóricas

ggplot(df_limpio, aes(x = cut)) +
  geom_bar(fill = "steelblue") +
  labs(title = "Distribución del corte del diamante", x = "Cut", y = "Frecuencia")

ggplot(df_limpio, aes(x = color)) +
  geom_bar(fill = "darkgreen") +
  labs(title = "Distribución del color del diamante", x = "Color", y = "Frecuencia")

ggplot(df_limpio, aes(x = clarity)) +
  geom_bar(fill = "purple") +
  labs(title = "Distribución de la claridad del diamante", x = "Clarity", y = "Frecuencia")

#Ejercicio 6
ggplot(df_limpio, aes(x = carat, y = price)) +
  geom_point(color = "blue", alpha = 0.4) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Relación entre quilates y precio",
       x = "Peso en quilates (carat)",
       y = "Precio") +
  theme_minimal()

#Ejercicio 7
df_num <- df_limpio %>% select (carat,depth,table, price,x,y,z)
corr <- cor(df_num)

#visualizo la correlacion de todas las variables
corrplot(corr)

#Ejercicio 8
ggplot(df_limpio, aes(x = price)) +
  geom_histogram(fill = "orange", color = "black") +
  labs(title = "Distribución del precio de los diamantes",
       x = "Precio",
       y = "Frecuencia") +
  theme_minimal()

ggplot(df_limpio, aes(x = carat, y = price)) +
  geom_point(color = "blue", alpha = 0.4) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Relación entre quilates y precio",
       x = "Peso en quilates (carat)",
       y = "Precio") +
  theme_minimal()

#Ejercicio 9
regresion_lineal <- lm(price ~ carat + cut + color + clarity + depth + table + x +  y +z,
                       data = df_limpio)

regresion_lineal <- lm(price ~ carat + depth + table + x + cut + color + clarity,
                       data = df_limpio)

summary(regresion_lineal)

