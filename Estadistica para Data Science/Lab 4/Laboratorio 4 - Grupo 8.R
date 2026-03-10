setwd("C:/Users/jdele/OneDrive/Escritorio/Maestria/Estadistica para Data Science/Lab 4")

#Cargar Libreria
library(dplyr)
library(ggplot2)
library(ggthemes)
library(scales)
library(reshape2)
library(corrplot)

df <- read.csv("loan_data.csv")

#En Clase

#Resumen estadistico y estructura de las variables
srt(df)

df$credit.policy <- as.factor(df$credit.policy)
df$purpose <- as.factor(df$purpose)
df$not.fully.paid <- as.factor(df$not.fully.paid)
df$pub.rec <- as.factor(df$pub.rec)

summary(df)

#Relacion entre variable de interes vs riesgo
ggplot(df, aes(x=fico, y = int.rate)) + 
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red") + 
  labs(title = "Tasa de interes vs score de riesgo", x = "Score de riesgo", y = "Tasa de interes") + theme_minimal() 

#veo la relacion entre la variable de not fully paid y la de deuda

ggplot(df, aes(x=dti, y = not.fully.paid)) + 
  geom_jitter(color = "darkblue") + geom_boxplot(alpha = 0.6)  +
  labs(title = "Ratio deuda ingreso vs variable de no pago de prestamo", x = "Deuda Ingreso", y = "PAgo no pago") + theme_minimal() 


#Hago la matriz de correlacion
variables_Numericas <- df %>% select_if(is.numeric)

#Hago la matriz de correlacion
matriz_corr <- cor(variables_Numericas, use = "complete.obs")

#Hago la visualizacion de la matriz
corrplot(matriz_corr, method = "color", addCoef.col = "black")
corrplot(matriz_corr, method = "color", addCoef.col = "black", type = "upper")


#Laboratorio 4
#1
ggplot(df, aes(x=fico, y = int.rate)) + 
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red") + 
  labs(title = "Tasa de interes vs score de riesgo", x = "Score de riesgo", y = "Tasa de interes") + theme_minimal() 

#2
ggplot(df, aes(x=dti, y = not.fully.paid)) + 
  geom_jitter(color = "darkblue") + geom_boxplot(alpha = 0.6)  +
  labs(title = "Ratio deuda ingreso vs variable de no pago de prestamo", x = "Deuda Ingreso", y = "PAgo no pago") + theme_minimal() 

ggplot(df, aes(x=not.fully.paid, y = dti)) + 
  geom_jitter(color = "darkblue") + geom_boxplot(alpha = 0.6)  +
  labs(title = "Ratio deuda ingreso vs variable de no pago de prestamo", x = "Deuda Ingreso", y = "PAgo no pago") + theme_minimal() 

#3
ggplot(df, aes(x = factor(not.fully.paid), y = int.rate)) +
  geom_boxplot(fill = "salmon", alpha = 0.7) +
  labs(title = "Tasa de interés vs No Pago",
       x = "No pagó completamente (0 = No, 1 = Sí)",
       y = "Tasa de interés") +
  theme_minimal()

#Ejercicio 4
ggplot(df, aes(x = factor(not.fully.paid), y = revol.bal)) +
  geom_boxplot(alpha = 0.8, fill = c("lightblue", "red")) +
  scale_y_log10() +
  labs(title = "Saldo crédito rotativo vs Impago",
       x = "Impago - Pago",
       y = "Saldo crédito rotativo") +
  theme_minimal()

#5
ggplot(df, aes(x = factor(not.fully.paid), y = revol.util)) +
  geom_boxplot(fill = "lightgreen", alpha = 0.7) +
  labs(title = "Utilización del crédito vs Impago",
       x = "No pagó completamente (0 = No, 1 = Sí)",
       y = "Utilización del crédito (%)") +
  theme_minimal()

ggplot(df, aes(x = revol.util, fill = factor(not.fully.paid))) +
  geom_density(alpha = 0.4) +
  labs(title = "Densidad de utilización del crédito",
       x = "Utilización del crédito (%)",
       fill = "Impago (0=No,1=Sí)") +
  theme_minimal()

#6 
#Hago la matriz de correlacion
variables_Numericas <- df %>% select_if(is.numeric)

#Hago la matriz de correlacion
matriz_corr <- cor(variables_Numericas, use = "complete.obs")

#Hago la visualizacion de la matriz
corrplot(matriz_corr, method = "color", addCoef.col = "black")
corrplot(matriz_corr, method = "color", addCoef.col = "black", type = "upper")

#7 
ggplot(df, aes(x = factor(inq.last.6mths), fill = factor(not.fully.paid))) +
  geom_bar(position = "fill") +
  labs(title = "Consultas recientes vs Impago",
       x = "Número de consultas en los últimos 6 meses",
       y = "Proporción")
       +
  theme_minimal()


#8 

ggplot(df, aes(x = factor(not.fully.paid), y = days.with.cr.line)) +
  geom_boxplot(fill = "lightblue", alpha = 0.7) +
  coord_flip() +
  labs(title = "Duración de línea de crédito vs No PAgo",
       x = "No pagó completamente",
       y = "Días con línea de crédito") +
  theme_minimal()