setwd("C:/Users/jdele/OneDrive/Escritorio/Maestria/Estadistica para Data Science/Lab 10")

# ===============================
# BLOQUE 1: LIBRERÍAS
# ===============================
library(dplyr)
library(e1071)
library(caret)
library(tidyr)


# Leer líneas
df <- read.csv("titanic_cleaned.csv", stringsAsFactors = FALSE)

head(df)
str(df)
summary(df)
# Verificar
head(df)

# Convertir a factores
df$Survived <- as.factor(df$Survived)
df$Sex <- as.factor(df$Sex)
df$Pclass <- as.factor(df$Pclass)

# Convertir numéricos
df$Age <- as.numeric(df$Age)
df$Fare <- as.numeric(df$Fare)
# ===============================
# PREGUNTA 1
# ===============================

# Probabilidad de sobrevivir
prob_survive <- mean(df$Survived == "1")

prob_survive

# ===============================
# PREGUNTA 2
# ===============================

prob_no_survive <- mean(df$Survived == "0")

prob_no_survive

# ===============================
# PREGUNTA 3
# ===============================

prob_woman <- mean(df$Sex == "female")

prob_woman

# ===============================
# PREGUNTA 4
# ===============================

# Filtrar mujeres
women <- df %>% filter(Sex == "female")

# Probabilidad de sobrevivir siendo mujer
prob_survive_women <- mean(women$Survived == "1")

prob_survive_women

# ===============================
# PREGUNTA 5
# ===============================

men <- df %>% filter(Sex == "male")

prob_survive_men <- mean(men$Survived == "1")

prob_survive_men

# ===============================
# PREGUNTA 6
# ===============================

first_class <- df %>% filter(Pclass == "1")

prob_survive_first <- mean(first_class$Survived == "1")

prob_survive_first

# ===============================
# PREGUNTA 7
# ===============================

third_class <- df %>% filter(Pclass == "3")

prob_survive_third <- mean(third_class$Survived == "1")

prob_survive_third

# ===============================
# PREGUNTA 8
# ===============================

third_class <- df %>% filter(Pclass == 3)

prob_no_survive_third <- mean(third_class$Survived == "0")

prob_no_survive_third

# ===============================
# PREGUNTA 9
# ===============================

prob_survive_women
prob_survive_men

# ===============================
# PREGUNTA 10
# ===============================

df %>%
  group_by(Pclass) %>%
  summarise(prob_survive = mean(Survived == "1"))

# ===============================
# PREGUNTA 11 - NAIVE BAYES
# ===============================

# Seleccionar variables
df_model <- df %>%
  select(Survived, Sex, Pclass)

# Dividir datos
set.seed(123)

trainIndex <- createDataPartition(df_model$Survived, p = 0.7, list = FALSE)

train <- df_model[trainIndex, ]
test <- df_model[-trainIndex, ]

# Modelo Naive Bayes
model_nb <- naiveBayes(Survived ~ ., data = train)

# Predicciones
pred <- predict(model_nb, test)

# Accuracy
accuracy <- mean(pred == test$Survived)

accuracy

# ===============================
# PREGUNTA 12
# ===============================

# Ver el modelo
model_nb