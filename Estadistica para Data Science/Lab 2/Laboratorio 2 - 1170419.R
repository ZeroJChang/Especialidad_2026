##CARGAR LIBRERIA
library(tidyverse)
library(lubridate)
library(janitor)
library(skimr)
library(modest)
#install.packages("modeest")
library(modeest)

#Cargar El Set de Datos
setwd("C:/Users/jdele/OneDrive/Escritorio/Maestria/Estadistica para Data Science/Lab 2")


df_ventas <- read_csv("stores_sales_forecasting.csv") %>%
  clean_names() %>%
  mutate(order_date= mdy(order_date),
         ship_date= mdy(ship_date))

df_ventas


#Resumen estadistico de los datgos
#Resumen #1
resumen_1 <- df_ventas  %>%
  summarise(
    media = mean(sales, na.rm = T),
    mediana = median(sales, na.rm = T)
  )

resumen_1

#UTILIDADES POR LAS DISTINTAS  CATEGORIAS DE PRODUCTOS
analisis_categoria <- df_ventas %>% 
  group_by(category) %>%
  summarise(promedio_profit= mean(profit, na.rma = T),
            mediana_profit= median(profit, na.rma= T)
            )

analisis_categoria

#UTILIDADES POR LAS DISTINTAS  sub - CATEGORIAS DE PRODUCTOS
analisis_sub_categoria <- df_ventas %>% 
  group_by(sub_category) %>%
  summarise(promedio_profit= mean(profit, na.rma = T),
            mediana_profit= median(profit, na.rma= T)
  )

analisis_sub_categoria

#UTILIDADES POR LAS DISTINTAS  sub - CATEGORIAS DE PRODUCTOS y segmento
analisis_sub_categoria_segmento <- df_ventas %>% 
  group_by(segment, sub_category) %>%
  summarise(promedio_profit= mean(profit, na.rma = T),
            mediana_profit= median(profit, na.rma= T)
  )

analisis_sub_categoria_segmento

#Otro ejemplo

analisis_sub_categoria_segmento_filtro <- df_ventas %>% 
  filter(sub_category== "Tables")%>% 
  group_by(segment, sub_category) %>%
  summarise(promedio_profit= mean(profit, na.rma = T),
            mediana_profit= median(profit, na.rma= T)
  )

analisis_sub_categoria_segmento_filtro


#Resumen de datos pero con SKimr
df_south <- df_ventas %>% filter(region == "South")

#Hacer un analisis estadistico mas dinamico
df_south %>% select(sales,profit) %>% skim()


#Hacer grafico para entender la relacion entre descuentos y utilidades
ggplot(df_ventas, aes(x = discount, y = profit)) +
  geom_jitter()+
  geom_smooth(method = "lm" ) + 
  labs( title = "Impacto descuentos vs rentabilidad",
          x = "Descuento", y = "Utilidad")+theme_minimal()

#MATRIZ de utilidad cateogia y region
matriz_profit <- tapply(df_ventas$profit, list(df_ventas$sub_category, df_ventas$region), mean)

#Analisis mensual de rentabilidad
analisis_mensual <- df_ventas %>% 
  mutate(mes_anio = floor_date(order_date, "month")) %>%
  group_by(mes_anio) %>%
  summarise(avg_sales = mean(sales, na.rm = T),
            avg_profit = mean(profit, na.rm = T),)


#Grafico
ggplot(analisis_mensual, aes(x = mes_anio)) + 
  geom_line(aes(y = avg_sales, color = "Ventas"))+
  geom_line(aes(y = avg_profit, color = "Profit")) + 
  scale_y_continuous() + 
  labs(title = "Evolutivo ventas y resntabilidad", x = "Mes y Año", y = "Monto $")

#lab2
#ejercicio1
#Resumen #1
resumen_ventas <- df_ventas %>%
  summarise(
    media_sales   = mean(sales, na.rm = TRUE),
    mediana_sales = median(sales, na.rm = TRUE),
    moda_sales    = mfv(sales)
  )

resumen_ventas

#ejercicio2
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

#ejercicio3
analisis_profit_categoria <- df_ventas %>%
  group_by(category) %>%
  summarise(
    promedio_profit = mean(profit, na.rm = TRUE),
    mediana_profit  = median(profit, na.rm = TRUE)
  )

analisis_profit_categoria
#Otro ejemplo

analisis_sub_categoria_segmento_filtro <- df_ventas %>% 
  filter(sub_category== "Tables")%>% 
  group_by(segment, sub_category) %>%
  summarise(promedio_profit= mean(profit, na.rma = T),
            mediana_profit= median(profit, na.rma= T)
  )

analisis_sub_categoria_segmento_filtro


#EJERCICIO 4
#EJERCICIO 4
#Se filtra la tabla para solo tener la región South
df_south <- df_ventas %>% filter(region == "South")

#Se obtiene el promedio y la mediana de la region South
Ejercicio4_South <- df_south %>%
  summarise(Promedio_Ventas_South = mean(sales, na.rm = T),
            Mediana_Ventas_South = median(sales, na.rm = T))

#Se obtiene el promedio y la mediana de los datos generales
Ejercicio4_General <- df_ventas %>%
  summarise(
    Promedio_Ventas = mean(sales, na.rm =T),
    Mediana_Ventas = median(sales, na.rm = T)
  )
Ejercicio4_South
Ejercicio4_General

#EJERCICIO 5
# Se obtiene el promedio del descuento filtrando por subcategoría y segmento
Ejercicio5 <- df_ventas %>%
  group_by(segment, sub_category) %>%
  summarise(promedio_descuento = mean(discount, na.rm = T))

Ejercicio5
#EJERCICIO 6
# Se realiza la matriz por la cantidad, agrupando por region y por subcategoría,segmento
Ejercicio6 <- tapply(df_ventas$quantity, list(df_ventas$region, df_ventas$sub_category, df_ventas$segment),mean)
Ejercicio6


#EJERCICIO 7
#Se obtiene el promedio de ventas por mes
Ejercicio_7 <- df_ventas %>%
  mutate(mes_anio = floor_date(order_date, "month")) %>%
  group_by(mes_anio) %>%
  summarise(Promedio_Ventas_Mes= mean(sales, na.rm = T))
Ejercicio_7
#EJERCICIO 8
#Se hace un gráfico para analizar la relación Descuento y Utilidad
ggplot(df_ventas, aes(x =discount, y = profit)) +
  geom_jitter() +
  geom_smooth(method = "lm") +
  labs(title = "Impacto Descuentos vs Utilidades",
       x = "Descuento",
       y = "Utilidad")+
  theme_minimal()
#EJERCICIO 9
#EJERCICIO 9
##Se filtra la tabla para solo tener la región South
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

view(Ejercicio9_Subcategoria)
view(Ejercicio9_Region)
view(Ejercicio9_ShipMode)

## PREGUNTA 10

ship_mode_sales <- df_ventas %>%
  group_by(ship_mode) %>%
  summarise(avg_sales = mean(sales))

ggplot(ship_mode_sales, aes(x = ship_mode, y = avg_sales)) +
  geom_col() +
  labs(x = "Modo Envío", y = "Promedio Ventas", title = "Promedio ventas por tipo de envío")
resumen_ship_mode_sales <- df_ventas %>%
  select(sales, ship_mode) %>%
  group_by(ship_mode) %>%
  summarise(
    promedio_profit = mean(sales, na.rm = T),
    mediana_profit = median(sales, na.rm = T),
    moda = mfv1(sales),
    sd_ventas = sd(sales, na.rm = T),
    var_ventas = var(sales, na.rm = T),
    min_ventas = min(sales, na.rm = T),
    max_ventas = max(sales, na.rm = T)
  )

## PREGUNTA 11
profit_category_region <- tapply(df_ventas$profit, list(df_ventas$sub_category, df_ventas$region), mean)
profit_category_region

## PREGUNTA 12
producto_segmento <- df_ventas %>%
  group_by(segment, sub_category) %>%
  summarise(avg_sales = mean(sales), n = n())

ggplot(producto_segmento, aes(
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
producto_segmento

## PREGUNTA 13
analisis_mensual <- df_ventas %>%
  mutate(mes_anio=floor_date(order_date, "month"))%>%
  group_by(mes_anio) %>%
  summarise(avg_sales = mean(sales, na.rm =T),
            avg_profit = mean(profit, na.rm=T))

analisis_mensual

ggplot(analisis_mensual, aes(x=mes_anio)) + 
  geom_line(aes(y=avg_sales, color = "Ventas")) +
  geom_line(aes(y=avg_profit, color = "Profit")) + 
  scale_y_continuous() +
  labs(x="mes/año",
       y="ventas promedio",
       title = "Utilidades por mes"
  )