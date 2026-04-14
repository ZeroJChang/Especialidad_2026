setwd("C:/Users/jdele/OneDrive/Escritorio/Maestria/Estadistica para Data Science/Lab 7")

library(tidyverse)
library(caTools)
library(MLmetrics)
library(corrplot)

#Cargar que vamos a usar
#Datos entreno modelo
df_entreno_crudo <- read.csv("insurance - entreno.csv", sep = ";")
df_entreno_crudo <- read.csv("insurance - entreno.csv", sep = ";") %>% na.omit()

#Datos para utilizacion del modelo
df_uso_crudo <- read.csv("insurance - uso.csv", sep = ";") 

#Proceso de entrenamiento y prueba del modelo
split <- sample.split(df_entreno_crudo$smoker, SplitRatio = 0.8)

#Hago el proceso de entrenamiento y prueba
df_entreno <- subset(df_entreno_crudo, split == T)
df_prueba <- subset(df_entreno_crudo, split == F)

df_entreno_crudo %>% filter(smoker == "yes")

smoker_df <- df_entreno_crudo %>% filter(smoker == "yes") 
boxplot(smoker_df$charges)

no_smoker_df <- df_entreno_crudo %>% filter(smoker == "no") 
boxplot(no_smoker_df$charges)

ggplot(df_entreno_crudo, aes(x = smoker, y = charges)) + geom_boxplot()

#set de datos para los fumadores entreno y no fumadores

entreno_fumadores <- df_entreno %>% filter(smoker == "yes")
entreno_nofumadores <- df_entreno %>% filter(smoker == "no")

#entreno los modelos
modelo_lm_fumadores <- lm(charges ~ age + sex + bmi + children + region, data = entreno_fumadores )
modelo_lm_nofumadores <- lm(charges ~ age + sex + bmi + children + region, data = entreno_nofumadores )



 #Hago el set de prueba de cada uno
prueba_fumadores <- df_prueba %>% filter(smoker == "yes")
prueba_nofumadores <- df_prueba %>% filter(smoker == "no")

prueba_fumadores$pred <- predict(modelo_lm_fumadores, prueba_fumadores)
prueba_nofumadores$pred <- predict(modelo_lm_nofumadores, prueba_nofumadores)


#modelo para fumadores indicadores 
RMSE(prueba_fumadores$pred, prueba_fumadores$charges)
RMSE(prueba_nofumadores$pred, prueba_nofumadores$charges)

MAPE(prueba_fumadores$pred, prueba_fumadores$charges)
MAPE(prueba_nofumadores$pred, prueba_nofumadores$charges)

##Hago las predicciones

df_uso_fumadores <- df_uso_crudo %>% filter(smoker == "yes")
df_uso_nofumadores <- df_uso_crudo %>% filter(smoker == "no")

df_uso_fumadores$pred <- predict(modelo_lm_fumadores, df_uso_fumadores)
df_uso_nofumadores$pred <- predict(modelo_lm_nofumadores, df_uso_nofumadores)

df_uso_completo <- rbind(df_uso_fumadores, df_uso_nofumadores)



#Inciso 1
#Exploración inicial
glimpse(df_entreno_crudo)

summary(df_entreno_crudo)

str(df_entreno_crudo)

#Ejercicio 2
#Distribución de la edad
ggplot(df_entreno_crudo, aes(x = age)) +
  geom_histogram(fill = "steelblue", color = "black", bins = 30) +
  labs(
    title = "Distribución de la Edad de los Clientes",
    x = "Edad",
    y = "Frecuencia"
  ) +
  theme_minimal()



#Distribución del BMI
ggplot(df_entreno_crudo, aes(x = bmi)) +
  geom_histogram(fill = "orange", color = "black", bins = 30) +
  labs(
    title = "Distribución del (BMI)",
    x = "BMI",
    y = "Frecuencia"
  ) +
  theme_minimal()



#Distribución de los costos médicos
ggplot(df_entreno_crudo, aes(x = charges)) +
  geom_histogram(fill = "green", color = "black", bins = 30) +
  labs(
    title = "Distribución de los Charges",
    x = "(Charges)",
    y = "Frecuencia"
  ) +
  theme_minimal()

#ejercicio 4
ggplot(df_entreno_crudo, aes(x = charges)) +
  geom_histogram(fill = "orange", color = "black", bins = 30) +
  labs(
    title = "Distribución de Charges",
    x = "(Charges)",
    y = "Frecuencia"
  ) +
  theme_minimal()

#Ejercicio 5
ggplot(df_entreno_crudo, aes(y = age)) +
  geom_boxplot(fill = "steelblue", color = "black") +
  labs(
    title = "Valores Atípicos en la Edad",
    x = "Variable",
    y = "Edad"
  ) +
  theme_minimal()

ggplot(df_entreno_crudo, aes(y = bmi)) +
  geom_boxplot(fill = "orange", color = "black") +
  labs(
    title = "Valores Atípicos en el BMI",
    x = "Variable",
    y = "BMI"
  ) +
  theme_minimal()

ggplot(df_entreno_crudo, aes(y = charges)) +
  geom_boxplot(fill = "green", color = "black") +
  labs(
    title = "Valores Atípicos en los Charges",
    x = "Variable",
    y = "Costos Médicos (Charges)"
  ) +
  theme_minimal()

#ejercicio 7
#División de datos 80% entrenamiento y 20% prueba

split <- sample.split(df_entreno_crudo$smoker, SplitRatio = 0.8)

df_entreno <- subset(df_entreno_crudo, split == TRUE)
df_prueba <- subset(df_entreno_crudo, split == FALSE)

#Ver tamaño de los conjuntos
nrow(df_entreno)
nrow(df_prueba)

#ejercicio 8
#Modelo de regresión lineal para fumadores
modelo_lm_fumadores <- lm(charges ~ age + sex + bmi + children + region, data = entreno_fumadores)

#Modelo de regresión lineal para no fumadores
modelo_lm_nofumadores <- lm(charges ~ age + sex + bmi + children + region, data = entreno_nofumadores)

#Ver coeficientes del modelo
summary(modelo_lm_fumadores)
summary(modelo_lm_nofumadores)

#Ejercicio 9
#Calcular RMSE para fumadores
RMSE(prueba_fumadores$pred, prueba_fumadores$charges)

#Calcular RMSE para no fumadores
RMSE(prueba_nofumadores$pred, prueba_nofumadores$charges)

#Ejericio 10
#Calcular MAPE para fumadores
MAPE(prueba_fumadores$pred, prueba_fumadores$charges)

#Calcular MAPE para no fumadores
MAPE(prueba_nofumadores$pred, prueba_nofumadores$charges)