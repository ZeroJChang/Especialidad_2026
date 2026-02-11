

setwd("C:/Users/jdele/OneDrive/Escritorio/Maestria/Estadistica para Data Science/Lab 3")


library(janitor) # Limpieza de datos
library(skimr) # Resumenes estadisticos mas dinamicos
library(modest) # Limpieza de datos
library(modeest) # Calculo de la moda

library(tidyverse) # Tiene varias librerias para limpieza de datos
library(lubridate) # Manipulacion fechas en R
library(scales) #añadir efectos visuales a los graficos ggplot
library(plotly) #graficos mas dinamicos dentro de R

#Cargar Datos
df <- read.csv("DataRRHH-fuga empleados.csv", sep = ";")

#Estructura de los datos
str(df)
summary(df)

#Convierto en variable
df$Attrition <- as.factor(df$Attrition)

#Veo la distribucion de edad vs los Si fugados #Inciso 1
ggplot(df %>% filter(Attrition == "Yes"), aes(x = Age)) +
  geom_histogram(
    binwidth = 5,
    fill = "yellow",
    color = "red",
    alpha = 0.8
  ) +
  labs(title = "Distribucion de edad vs los empleados fugados", x = "Edad", y = "Frecuencia (cantidad)") +
  theme_bw()

#Grafico comparativo de a;os enla compañia y la variable fuga

ggplot(df, aes(x = YearsAtCompany, fill = Attrition)) +
  geom_density(alpha = 0.5) +
  scale_fill_manual(values = c("No" = "#377eb8", "Yes" = "gray")) +
  labs(title = "Distribucion de años en la empresa  vs los empleados fugados", x = "Edad", y = "Frecuencia Densidad (cantidad)") +
  theme_bw()


ggplot(df, aes(x = YearsAtCompany, fill = Attrition)) +
  geom_bar(position = "dodge") +
  labs(title = "Antigüedad en la empresa vs Fuga de empleados", x = "Años en la empresa", y = "Cantidad de empleados") +
  scale_fill_manual(values = c("No" = "#4daf4a", "Yes" = "#E41A1C")) +
  theme_minimal()


#Grafico de satisfaccion de los empleados por departamento
df_satisfaccion <- df %>%
  group_by(Department, JobSatisfaction) %>%
  tally () %>%
  mutate (pct = n / sum(n))

ggplot(df_satisfaccion, aes(
  x = Department,
  y = pct,
  fill = factor(JobSatisfaction)
)) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_brewer(palette = "RdYlGn", name = "Nivel de Satisfaccion") +
  labs(title = "Satisfaccion por departamento", x = "Departamento", y = "Porcentaje") +
  theme_bw() + coord_flip()


# Correlación entre años trabajando vs entrenamientos
ggplot(df %>% filter(Attrition == "Yes"),
       aes(x = YearsAtCompany, y = TrainingTimesLastYear)) +
  geom_jitter(
    color = "#E41A1C",
    alpha = 0.6,
    width = 0.5,
    height =  0.2
  ) +
  geom_smooth(method = "lm")


#Diferencia en aumentos vs fugas
ggplot(df, aes(x = Attrition, y = Age, fill = Attrition)) +
  geom_boxplot() +
  scale_fill_manual(values = c("No" = "green", "Yes" = "red")) +
  labs(title = "Diagrama de cajas Attrition vs Edad", x = "Attrition", y = "Edad") +
  theme_bw()


#Grafico de horas extra vs Attrition
ggplot(df, aes(x = OverTime, fill = Attrition)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent)

ggplot(df, aes(x = OverTime, fill = Attrition)) +
  geom_bar(position = "stack")


#----------------------------------------
#---------------------------------------
#LABORATORIO
#----------------------------------------
#---------------------------------------

#Inciso 1
#Veo la distribucion de edad vs los Si fugados #Inciso 1
ggplot(df %>% filter(Attrition == "Yes"), aes(x = Age)) +
  geom_histogram(
    binwidth = 5,
    fill = "yellow",
    color = "red",
    alpha = 0.8
  ) +
  labs(title = "Distribucion de edad vs los empleados fugados", x = "Edad", y = "Frecuencia (cantidad)") +
  theme_bw()

#Inciso 3
ggplot(df, aes(x = YearsAtCompany, fill = Attrition)) +
  geom_bar(position = "dodge") +
  labs(title = "Antigüedad en la empresa vs Fuga de empleados", x = "Años en la empresa", y = "Cantidad de empleados") +
  scale_fill_manual(values = c("No" = "#4daf4a", "Yes" = "#E41A1C")) +
  theme_minimal()


#inciso 4
ggplot(df %>%
         filter(Attrition == "Yes"),
       aes(x = DistanceFromHome, y = JobSatisfaction)) +
  geom_jitter(
    color = "#E41A1C",
    alpha = 0.6,
    width = 0.5,
    height = 0.2
  ) +
  geom_smooth(method = "lm",
              se = FALSE,
              color = "black") +
  labs(title = "Distancia al trabajo vs Satisfacción laboral\n(Empleados que abandonaron la empresa)", x = "Distancia desde casa", y = "Nivel de satisfacción laboral") +
  theme_minimal()

#Inciso 5
# Age vs YearsAtCompany
ggplot(df %>% filter(Attrition == "Yes"), aes(x = Age, y = YearsAtCompany)) +
  geom_jitter(alpha = 0.6, color = "blue") +
  geom_smooth(method = "lm", color = "black") +
  labs(title = "Relación entre Edad y Años en la Empresa", x = "Edad", y = "Años en la empresa") +
  theme_minimal()

#DistanceFromHome vs JobSatisfaction
ggplot(df %>% filter(Attrition == "Yes"),
       aes(x = DistanceFromHome, y = JobSatisfaction)) +
  geom_jitter(
    alpha = 0.6,
    color = "#4daf4a",
    width = 0.4,
    height = 0.2
  ) +
  geom_smooth(method = "lm", color = "black") +
  labs(title = "Relación entre Distancia al Trabajo y Satisfacción Laboral", x = "Distancia al trabajo", y = "Nivel de satisfacción laboral") +
  theme_minimal()

# Age vs JobSatisfaction
ggplot(df_empleados %>% filter(Attrition == "Yes"),
       aes(x = Age, y = JobSatisfaction)) +
  geom_jitter(
    alpha = 0.6,
    color = "steelblue",
    width = 0.4,
    height = 0.2
  ) +
  geom_smooth(method = "lm", color = "black") +
  labs(title = "Relación entre Edad y Satisfacción Laboral", x = "Edad", y = "Nivel de satisfacción laboral") +
  theme_minimal()


## ejercicio 6

ggplot(df, aes(x = Attrition, fill = MaritalStatus)) +
  scale_y_continuous(labels = scales::percent) +
  geom_bar(position = "fill") +
  labs(title = "Diagrama de abandono por estado civil", x = "Abandono", y = "Estado Civil") +
  theme_minimal()


#Inciso 7
ggplot(df, aes(x = Attrition, y = MonthlyIncome, fill = Attrition)) +
  geom_boxplot() +
  scale_fill_manual(values = c("No" = "#4daf4a", "Yes" = "#e41a1c")) +
  labs(title = "Diagrama de cajas Fugados vs Ingresos Mensuales", x = "Fugados", y = "Ingresos Mensuales") +
  theme_minimal()

#Inciso 8
df_satisfaccion <- df %>%
  filter(Attrition == "Yes") %>%
  group_by(Department, JobSatisfaction) %>%
  tally() %>%
  mutate(Porcentaje = n / sum(n))

ggplot(df_satisfaccion,
       aes(
         x = Department,
         y = Porcentaje,
         fill = factor(JobSatisfaction)
       )) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_brewer(palette = "RdYlGn", name = "Nivel de Satisfacción") +
  labs(title = "Nivel de Satisfacción Laboral por Departamento \n(Empleados que dejaron la empresa)", x = "Departamento", y = "Proporción") +
  coord_flip() +
  theme_minimal()

#Inciso 9
# Correlación entre años trabajando vs entrenamientos
ggplot(df %>% filter(Attrition == "Yes"),
       aes(x = YearsAtCompany, y = TrainingTimesLastYear)) +
  geom_jitter(
    color = "#E41A1C",
    alpha = 0.6,
    width = 0.5,
    height =  0.2
  ) +
  geom_smooth(method = "lm")

#Inciso 10
ggplot(df, aes(x = PercentSalaryHike, fill = Attrition)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_manual(values = c("No" = "#4daf4a", "Yes" = "#E41A1C")) +
  labs(title = "Aumento salarial vs Fuga de empleados", x = "Porcentaje de aumento salarial", y = "Proporción de empleados") +
  theme_minimal()

#
