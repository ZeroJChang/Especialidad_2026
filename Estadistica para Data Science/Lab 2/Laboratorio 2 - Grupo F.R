# Limpiar el entorno
rm(list = ls())

##Cargo las librerias a usar
library(tidyverse) # Tiene varias librerias para limpieza de datos
library(lubridate) # Manipulacion fechas en R
library(janitor) # Limpieza de datos
library(skimr) # Resumenes estadisticos mas dinamicos
library(modest) # Limpieza de datos
library(modeest) # Calculo de la moda

# Carga de set de datos
setwd("C:/Users/Diego/Desktop/Especializacion en Data Science/ESTADISTICA PARA DATA SCIENCE/Semana 2")

# Cargo el set de datos
df_ventas <- read_csv("stores_sales_forecasting..csv") %>%
  clean_names() %>% # Limpio los nombres de las columnas
  mutate(order_date = mdy(order_date),
         ship_date = mdy(ship_date)) # Cambio el formato de la columna fecha (month-day-year)

str(df_ventas) # Estructura del set de datos

## PREGUNTA 1
# Resumen estadistico del set de datos
Ejercicio1 <- df_ventas %>%
  summarise(
    media = mean(sales, na.rm = T),
    mediana = median(sales, na.rm = T), # na.rm = T para omitir datos faltantes
    moda =  mfv(sales)
  )

# Frecuencia de ventas
df_sales_frequency <- df_ventas %>%
  count(sales)

Ejercicio1

## PREGUNTA 2
# Grafico de distribucion de ventas
ggplot(df_ventas, aes(x = sales)) +
  geom_histogram(aes(y = after_stat(density)), bins = 30) +
  geom_density() +
  theme_minimal()
media <- mean(df_ventas$sales, na.rm = TRUE)
sd_ <- sd(df_ventas$sales, na.rm = TRUE)

ggplot(df_ventas, aes(x = sales)) +
  geom_histogram(aes(y = after_stat(density)),
                 bins = 30,
                 fill = "lightgray",
                 color = "black") +
  stat_function(
    fun = dnorm,
    args = list(mean = media, sd = sd_),
    linewidth = 1
  ) +
  theme_minimal()

## PREGUNTA 3
# Utilidades por distinta sub categoria de producto
Ejercicio3 <- df_ventas %>%
  group_by(segment, sub_category) %>%
  summarise(
    promedio_profit = mean(profit, na.rm = T),
    mediana_profit = median(profit, na.rm = T)
  )
Ejercicio3

## PREGUNTA 4
#Se filtra la tabla para solo tener la región South
df_south <- df_ventas %>% 
  filter(region == "South")

#Se obtiene el promedio y la mediana de la region South
Ejercicio4_South <- df_south %>%
  summarise(
    Promedio_Ventas_South = mean(sales, na.rm = T),
    Mediana_Ventas_South = median(sales, na.rm = T)
    )

#Se obtiene el promedio y la mediana de los datos generales
Ejercicio4_General <- df_ventas %>%
  summarise(
    Promedio_Ventas = mean(sales, na.rm =T),
    Mediana_Ventas = median(sales, na.rm = T)
  )

## PREGUNTA 5 
# Se obtiene el promedio del descuento filtrando por subcategoría y segmento
Ejercicio5 <- df_ventas %>%
  group_by(segment, sub_category) %>%
  summarise(promedio_descuento = mean(discount, na.rm = T))

## PREGUNTA 6
# Se realiza la matriz por la cantidad, agrupando por region y por subcategoría,segmento
Ejercicio6 <- tapply(df_ventas$quantity, list(df_ventas$region, df_ventas$sub_category, df_ventas$segment),mean)
Ejercicio6

## PREGUNTA 7
#Se obtiene el promedio de ventas por mes
Ejercicio7 <- df_ventas %>%
  mutate(mes_anio = floor_date(order_date, "month")) %>%
  group_by(mes_anio) %>%
  summarise(Promedio_Ventas_Mes= mean(sales, na.rm = T))

## PREGUNTA 8
#Se hace un gráfico para analizar la relación Descuento y Utilidad
ggplot(df_ventas, aes(x =discount, y = profit)) +
  geom_jitter() +
  geom_smooth(method = "lm") +
  labs(title = "Impacto Descuentos vs Utilidades",
       x = "Descuento",
       y = "Utilidad")+
  theme_minimal()

## PREGUNTA 9
#Se filtra la tabla para solo tener las ventas mayores o iguales a 1000 
df_GreatSales <- df_ventas %>% 
  filter(sales >= 1000)

#Segmento y Subcategoría
Ejercicio9_Subcategoria <- df_GreatSales %>%
  group_by(segment, sub_category) %>%
  summarise(Promedio_Ventas = mean(sales, na.rm = T),
            Promedio_Utilidades = mean(profit, na.rm = T))

#Region
Ejercicio9_Region <- df_GreatSales %>%
  group_by(region) %>%
  summarise(Promedio_Ventas = mean(sales, na.rm = T),
            Promedio_Utilidades = mean(profit, na.rm = T))

#Modo de entrega
Ejercicio9_ShipMode <- df_GreatSales %>%
  group_by(ship_mode) %>%
  summarise(Promedio_Ventas = mean(sales, na.rm = T),
            Promedio_Utilidades = mean(profit, na.rm = T))

Ejercicio9_los4 <- df_GreatSales %>%
  group_by(ship_mode, segment, sub_category, region) %>%
  summarise(Promedio_Ventas = mean(sales, na.rm = T),
            Promedio_Utilidades = mean(profit, na.rm = T))

view(Ejercicio9_Subcategoria)
view(Ejercicio9_Region)
view(Ejercicio9_ShipMode)

## PREGUNTA 10
# Se realiza un resumen estadístico de las ventas por cada modo de envio (ship mode)
Ejercicio10 <- df_ventas %>%
  select(sales, ship_mode) %>%
  group_by(ship_mode) %>%
  summarise(
    promedio_ventas = mean(sales, na.rm = T),
    mediana_ventas = median(sales, na.rm = T),
    moda = mfv1(sales),
    sd_ventas = sd(sales, na.rm = T),
    var_ventas = var(sales, na.rm = T),
    min_ventas = min(sales, na.rm = T),
    max_ventas = max(sales, na.rm = T)
  )

# Grafico del promedio de ventas por tipo de envio 
ggplot(Ejercicio10, aes(x = ship_mode, y = promedio_ventas)) +
  geom_col() +
  labs(x = "Modo Envío", y = "Promedio Ventas", title = "Promedio ventas por tipo de envío")

## PREGUNTA 11
# Se realiza el promedio de utilidad por subcategoría y región
Ejercicio11 <- tapply(df_ventas$profit, list(df_ventas$sub_category, df_ventas$region), mean)

## PREGUNTA 12
# Se realiza el promedio de ventas por segmento y subcategoría
Ejercicio12 <- df_ventas %>%
  group_by(segment, sub_category) %>%
  summarise(avg_sales = mean(sales), n = n())

# Gráfico del promedio de ventas por segmento y subcategoría
ggplot(Ejercicio12, aes(
  x = segment,
  y = avg_sales,
  fill = sub_category
)) +
  geom_col(position = "dodge") +
  labs(
    y = "Ventas promedio",
    x = "Segmento",
    fill = "Sub Categoria"
  )
Ejercicio12

## PREGUNTA 13
# Promedio mensual de utilidades y ventas
Ejercicio13 <- df_ventas %>%
  mutate(mes_anio=floor_date(order_date, "month"))%>%
  group_by(mes_anio) %>%
  summarise(avg_sales = mean(sales, na.rm =T),
            avg_profit = mean(profit, na.rm=T))

Ejercicio13

#Grafico de ventas y utilidades por mes
ggplot(Ejercicio13, aes(x=mes_anio)) + 
  geom_line(aes(y=avg_sales, color = "Ventas")) +
  geom_line(aes(y=avg_profit, color = "Profit")) + 
  scale_y_continuous() +
  labs(x="mes/año",
       y="ventas promedio",
       title = "Utilidades por mes"
  )
