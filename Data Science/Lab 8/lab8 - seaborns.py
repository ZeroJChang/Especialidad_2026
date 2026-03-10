import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# ================================
# Cargar dataset
# ================================
df = pd.read_csv("ventas_tienda.csv")

# Convertir fecha
df["Fecha"] = pd.to_datetime(df["Fecha"])

# Estilo visual
sns.set(style="whitegrid")

# ==========================================================
# GRAFICA 1
# Grafica de Barras (Barplot)
# Ventas totales por categoría
#
# Descripción:
# Permite identificar qué categoría de productos
# tiene mayor volumen de ventas.
# ==========================================================
plt.figure(figsize=(8,5))
sns.barplot(x="Categoría", y="Cantidad", data=df, estimator=sum)
plt.title("Ventas totales por categoría")
plt.show()



# ==========================================================
# GRAFICA 2
# Countplot
# Número de ventas registradas por vendedor
#
# Descripción:
# Muestra la frecuencia de ventas por vendedor
# para evaluar participación del equipo comercial.
# ==========================================================
plt.figure(figsize=(8,5))
sns.countplot(x="Vendedor", data=df)
plt.title("Número de ventas por vendedor")
plt.show()



# ==========================================================
# GRAFICA 3
# Boxplot
# Distribución del precio unitario por categoría
#
# Descripción:
# Permite analizar variabilidad de precios y detectar
# valores atípicos dentro de cada categoría.
# ==========================================================
plt.figure(figsize=(8,5))
sns.boxplot(x="Categoría", y="Precio Unitario", data=df)
plt.title("Distribución de precios por categoría")
plt.show()



# ==========================================================
# GRAFICA 4
# Violin Plot
# Distribución de cantidades vendidas por categoría
#
# Descripción:
# Combina densidad y distribución para observar
# comportamiento de ventas dentro de cada categoría.
# ==========================================================
plt.figure(figsize=(8,5))
sns.violinplot(x="Categoría", y="Cantidad", data=df)
plt.title("Distribución de cantidades por categoría")
plt.show()



# ==========================================================
# GRAFICA 5
# Scatterplot
# Relación entre cantidad vendida y precio unitario
#
# Descripción:
# Permite observar si existe relación entre
# precio del producto y cantidad vendida.
# ==========================================================
plt.figure(figsize=(8,5))
sns.scatterplot(x="Precio Unitario", y="Cantidad", hue="Categoría", data=df)
plt.title("Relación entre precio y cantidad vendida")
plt.show()



# ==========================================================
# GRAFICA 6
# Histogram + KDE
# Distribución del precio unitario
#
# Descripción:
# Muestra cómo se distribuyen los precios de los
# productos vendidos.
# ==========================================================
plt.figure(figsize=(8,5))
sns.histplot(df["Precio Unitario"], kde=True)
plt.title("Distribución del precio unitario")
plt.show()



# ==========================================================
# GRAFICA 7
# Lineplot
# Tendencia de ventas por fecha
#
# Descripción:
# Permite observar cómo evolucionan las ventas
# a lo largo del tiempo.
# ==========================================================
ventas_fecha = df.groupby("Fecha")["Cantidad"].sum().reset_index()

plt.figure(figsize=(10,5))
sns.lineplot(x="Fecha", y="Cantidad", data=ventas_fecha)
plt.title("Tendencia de ventas por fecha")
plt.show()



# ==========================================================
# GRAFICA 8
# Heatmap
# Correlación entre variables numéricas
#
# Descripción:
# Permite identificar relaciones entre variables
# como cantidad y precio.
# ==========================================================
plt.figure(figsize=(6,5))
corr = df[["Cantidad","Precio Unitario"]].corr()
sns.heatmap(corr, annot=True, cmap="coolwarm")
plt.title("Mapa de correlación")
plt.show()



# ==========================================================
# GRAFICA 9
# Stripplot
# Distribución individual de ventas por categoría
#
# Descripción:
# Permite observar cada punto de venta individual
# dentro de cada categoría.
# ==========================================================
plt.figure(figsize=(8,5))
sns.stripplot(x="Categoría", y="Cantidad", data=df)
plt.title("Distribución de ventas por categoría")
plt.show()



# ==========================================================
# GRAFICA 10
# Stripplo
# Distribución detallada de cantidades vendidas por categoría
#
# Descripción:
# Permite observar cada venta individual dentro de
# cada categoría de producto.
# ==========================================================
plt.figure(figsize=(8,5))
sns.stripplot(x="Categoría", y="Cantidad", data=df, jitter=True)

plt.title("Distribución detallada de ventas por categoría")
plt.xlabel("Categoría")
plt.ylabel("Cantidad vendida")

plt.show()



# ==========================================================
# GRAFICA 11
# Pairplot
# Relación entre variables numéricas
#
# Descripción:
# Permite observar correlaciones y distribuciones
# entre múltiples variables al mismo tiempo.
# ==========================================================

# Si el dataset es grande se toma una muestra para que sea rápido
df_sample = df.sample(min(len(df), 200))

sns.pairplot(df_sample[["Cantidad","Precio Unitario"]])

plt.suptitle("Relación entre variables numéricas", y=1.02)

plt.show()



# ==========================================================
# GRAFICA 12
# Barplot
# Impacto de promociones en las ventas
#
# Descripción:
# Permite analizar si las promociones influyen
# en el volumen promedio de ventas.
# ==========================================================
plt.figure(figsize=(6,5))
sns.barplot(x="Promoción", y="Cantidad", data=df)

plt.title("Impacto de promociones en ventas")
plt.xlabel("Promoción")
plt.ylabel("Cantidad promedio vendida")

plt.show()