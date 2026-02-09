#NOMBRE: DIEGO JAVIER MORALES MONZÓN				CARNÉ: 1132119
#NOMBRE: ESTUARDO JOSÉ VILLEDA NAVARRO			CARNÉ: 1003519
#NOMBRE: JORGE WALDEMAR GARCÍA BALDIZÓN			CARNÉ: 1220019
#NOMBRE: JOSÉ DANIEL DE LEÓN CHANG				CARNÉ: 1170419
#Laboratorio 3

setwd("C:/Users/jdele/OneDrive/Escritorio/Maestria/Estadistica para Data Science/Lab 3")

library(tidyverse) # Tiene varias librerias para limpieza de datos
library(lubridate) # Manipulacion fechas en R
library(janitor) # Limpieza de datos
library(skimr) # Resumenes estadisticos mas dinamicos
library(modest) # Limpieza de datos
library(modeest) # Calculo de la moda

df_empleados <- read_csv2(
  "DataRRHH-fuga empleados.csv",
  locale = locale(encoding = "UTF-8")
)

#Inciso 1
empleados_fuga <- df_empleados %>%
  filter(Attrition == "Yes")

ggplot(empleados_fuga, aes(x = Age)) +
  geom_histogram(
    bins = 10,
    fill = "steelblue",
    color = "black"
  ) +
  labs(
    title = "Histograma de la edad de empleados que dejaron la empresa",
    x = "Edad",
    y = "Número de empleados"
  ) +
  theme_minimal()

#Inciso 3
df_years <- df_empleados %>%
  mutate(
    years_group = case_when(
      YearsAtCompany <= 2 ~ "0–2 años",
      YearsAtCompany <= 5 ~ "3–5 años",
      YearsAtCompany <= 10 ~ "6–10 años",
      YearsAtCompany > 10 ~ "Más de 10 años"
    )
  )
ggplot(df_years, aes(x = years_group, fill = Attrition)) +
  geom_bar(position = "dodge") +
  labs(
    title = "Antigüedad en la empresa y fuga de empleados",
    x = "Años en la empresa",
    y = "Número de empleados",
    fill = "Fuga de empleados"
  ) +
  theme_minimal()

#Inciso 4
empleados_fuga <- df_empleados %>%
  filter(Attrition == "Yes")

ggplot(empleados_fuga, aes(x = DistanceFromHome, y = JobSatisfaction)) +
  geom_point(alpha = 0.6, color = "steelblue") +
  labs(
    title = "Distancia al trabajo vs Satisfacción laboral (Empleados que dejaron la empresa)",
    x = "Distancia al trabajo",
    y = "Satisfacción laboral"
  ) +
  theme_minimal()

ggplot(empleados_fuga, aes(x = DistanceFromHome, y = JobSatisfaction)) +
  geom_jitter(
    width = 0.4,
    height = 0.1,
    alpha = 0.6,
    color = "steelblue"
  ) +
  labs(
    title = "Distancia al trabajo vs Satisfacción laboral\n(Empleados que dejaron la empresa)",
    x = "Distancia al trabajo",
    y = "Satisfacción laboral"
  ) +
  theme_minimal()
