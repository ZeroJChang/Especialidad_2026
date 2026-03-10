setwd("C:/Users/jdele/OneDrive/Escritorio/Maestria/Estadistica para Data Science/Lab 5")


# Cargo las librerías a utilizar
library(tidyr)
library(tidyverse)
library(corrplot)
library(mice)   # librería para poder hacer el proceso de limpieza de datos
library(VIM)    # librería para poder visualizar los valores faltantes

# Cargo el set de datos a utilizar
df <- read.csv("bike_buyers.csv", stringAsFactors = T)
df <- read.csv("bike_buyers.csv")


#Coloco los valores faltantes
df$Gender <- ifelse(df$Gender == "", NA, df$Gender)
df$Marital.Status <- ifelse(df$Marital.Status == "", NA, df$Marital.Status)
df$Home.Owner <- ifelse(df$Home.Owner == "", NA, df$Home.Owner)


# Veo si tengo valores faltantes en mi set de datos
missing_values <- colSums(is.na(df))
missing_values

#Visualizar valores faltantes que tenemos con la libreria VIM
aggr(df, col = c("darkblue", "darkred"), numbers = TRUE, sortVars = TRUE,
     labels = names(df), main = "Patron valores faltantes", cex.axis=0.7, gap =3 )

#Tratamiento de datos faltantes categoricos
imputar_moda <- function(x) {
  ux <- unique(na.omit(x))
  x[is.na(x)] <- ux[which.max(tabulate(match(x, ux)))]
  return(x)
}
#Utilizo la funcion para el proceso de imputar la moda

df <- df %>% mutate(Gender = imputar_moda(Gender), Marital.Status = imputar_moda(Marital.Status),
                    imputar_moda(Home.Owner))

#Hago el proceso de limpieza de datos con libreria MICE
temp_mice <- mice(df[,c("Income", "Age", "Cars", "Children")], m = 5, method = "pmm")

#Corro el proceso mice que hice
df_limpio <- df
  
df_limpio[,c("Income", "Age", "Cars", "Children")] <- complete (temp_mice,1)
summary(df_limpio)
                    
#Procedimiento de rango intercuartil
Q1 <- quantile(df_limpio$Income, 0.25)
Q3 <- quantile(df_limpio$Income, 0.75)

IQR <- Q3 - Q1

limite_superior <- Q3+ IQR*1.5

df_limpio[df_limpio$Income > limite_superior,] <- limite_superior
boxplot(df_limpio$Income)


#Laboratorio 5

#ejercicio 1
#VALORES FALTANTES
missing_values <- colSums(is.na(df))
missing_values

#ejercicio 2

#Imputacion media
df_media <- df

df_media$Income[is.na(df_media$Income)] <- mean(df_media$Income, na.rm = TRUE)
df_media$Age[is.na(df_media$Age)] <- mean(df_media$Age, na.rm = TRUE)
df_media$Cars[is.na(df_media$Cars)] <- mean(df_media$Cars, na.rm = TRUE)
df_media$Children[is.na(df_media$Children)] <- mean(df_media$Children, na.rm = TRUE)

#Imputacion mediana
df_mediana <- df

df_mediana$Income[is.na(df_mediana$Income)] <- median(df_mediana$Income, na.rm = TRUE)
df_mediana$Age[is.na(df_mediana$Age)] <- median(df_mediana$Age, na.rm = TRUE)
df_mediana$Cars[is.na(df_mediana$Cars)] <- median(df_mediana$Cars, na.rm = TRUE)
df_mediana$Children[is.na(df_mediana$Children)] <- median(df_mediana$Children, na.rm = TRUE)

temp_mice <- mice(df[,c("Income", "Age", "Cars", "Children")], 
                  m = 5, 
                  method = "pmm")

df_regresion <- df
df_regresion[,c("Income", "Age", "Cars", "Children")] <- complete(temp_mice,1)

summary(df_media$Income)
summary(df_mediana$Income)
summary(df_regresion$Income)

#Ejercicio 3
Q1 <- quantile(df_limpio$Income, 0.25)
Q3 <- quantile(df_limpio$Income, 0.75)
IQR <- Q3 - Q1
limite_superior <- Q3 + IQR * 1.5

df_limpio$Income[df_limpio$Income > limite_superior] <- limite_superior

boxplot(df_limpio$Income,
        main = "Analisis de Income",
        col = "lightblue")

#Pregunta 4
ggplot(df_limpio, aes(x=Income, y = Purchased.Bike))+
  geom_boxplot(alpha = 0.8, fill = c("lightblue"))+
  labs(title = "Ingreso vs Bicicleta comprada",
       x = "Ingreso",
       y = "Bicicleta comprada") +
  theme_minimal()

# Pregunta 5
ggplot(df_limpio %>% filter(Purchased.Bike == "Yes"),  aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black") +
  labs(title = "Distribución de Edad - Compradores",
       x = "Edad",
       y = "Frecuencia") +
  theme_minimal()

## ejercicio 6
df_limpio$Income[df_limpio$Income > limite_superior] <- limite_superior

#Corro el proceso mice que hice
df_limpio <- df

df_limpio[,c("Income", "Age", "Cars", "Children")] <- complete (temp_mice,1)
summary(df_limpio)

df_limpio <- df_limpio %>%
  mutate(Purchased.Bike = as.factor(df_limpio$Purchased.Bike))

ggplot(df_limpio, aes(x = Cars, fill = Purchased.Bike)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(title = "Relacion entre numero de carros y compra de bicicletas",
       x = "Carros",
       y = "Cantidad",
       fill = "Compraron Bicicleta")

#Ejercicio 7
imputar_moda <- function(x) {
  ux <- unique(na.omit(x))
  x[is.na(x)] <- ux[which.max(tabulate(match(x, ux)))]
  return(x)
}

df <- df %>% mutate(
  Gender = imputar_moda(Gender),
  Marital.Status = imputar_moda(Marital.Status),
  imputar_moda(Home.Owner)
)

table(df$Gender, df$Purchased.Bike)

tabla_genero <- table(df$Gender, df$Purchased.Bike)

ggplot(df, aes(x = Purchased.Bike, fill = Gender)) +
  geom_bar(position = "dodge") +
  labs(title = "Género vs Compra de Bicicleta",
       x = "Compra de Bicicleta",
       y = "Cantidad") +
  theme_minimal()

#Pregunta 8
numericas <- df_limpio[, c("Age", "Income", "Cars")]

cor_matrix <- cor(numericas)

cor_matrix

corrplot(cor_matrix, 
         method = "color", 
         addCoef.col = "white")

#Ejercicio 9
df_limpio <- df

df_limpio[,c("Income", "Age", "Cars", "Children")] <- complete (temp_mice,1)
summary(df_limpio)

df_limpio <- df_limpio %>%
  mutate(Purchased.Bike = as.factor(df_limpio$Purchased.Bike))

ggplot(df_limpio, aes(x=Purchased.Bike, fill = Commute.Distance))+
  geom_bar(position = "fill")+
  labs(title = "Bicicleta comprada vs Distancia al Trabajo",
       x = "Bicicleta comprada",
       y = "Distancia al Trabajo") +
  theme_minimal()
#Ejercicio 10
boxplot(df_limpio$Cars,
        main = "Número de Autos",
        col = "Green",
        ylab = "Cantidad de Autos")


Q1_cars <- quantile(df_limpio$Cars, 0.25)
Q3_cars <- quantile(df_limpio$Cars, 0.75)

IQR_cars <- Q3_cars - Q1_cars

limite_superior_cars <- Q3_cars + 1.5 * IQR_cars
limite_inferior_cars <- Q1_cars - 1.5 * IQR_cars

df_limpio[df_limpio$Cars > limite_superior_cars |
            df_limpio$Cars < limite_inferior_cars, ]

df_limpio$Cars[df_limpio$Cars > limite_superior_cars] <- limite_superior_cars
df_limpio$Cars[df_limpio$Cars < limite_inferior_cars] <- limite_inferior_cars
boxplot(df_limpio$Cars,
        main = "Número de Autos",
        col = "Green",
        ylab = "Cantidad de Autos")
