import pandas as pd
import matplotlib.pyplot as plt

# ================================
# Cargar dataset
# ================================
df = pd.read_csv("ventas_tienda.csv")

# ==========================================================
# Parte de matplotlib
# ==========================================================

# ==========================================================
# GRAFICA 1
# Grafica de Barras
# Ventas por Categoría
# ==========================================================
ventas_categoria = df.groupby("Categoría")["Cantidad"].sum()

plt.figure(figsize=(8,5))
ventas_categoria.plot(kind="bar", color="skyblue")

plt.title("Cantidad total vendida por categoría")
plt.xlabel("Categoría")
plt.ylabel("Cantidad vendida")

plt.xticks(rotation=45)
plt.show()



# ==========================================================
# GRAFICA 2
# Grafica de Barras
# Ventas por Producto
# ==========================================================
ventas_producto = df.groupby("Producto")["Cantidad"].sum()

plt.figure(figsize=(10,5))
ventas_producto.plot(kind="bar", color="orange")

plt.title("Cantidad total vendida por producto")
plt.xlabel("Producto")
plt.ylabel("Cantidad vendida")

# se agrega un limite inferior con el objetivo de que la grafica sea más representativa y pueda transmitir una diferencia significativa y no sea ambigua de leer
plt.ylim(bottom=5000)

plt.xticks(rotation=45)
plt.show()



# ==========================================================
# GRAFICA 3
# Grafica de Barras
# Ventas por Vendedor
# ==========================================================
ventas_vendedor = df.groupby("Vendedor")["Cantidad"].sum()

plt.figure(figsize=(8,5))
ventas_vendedor.plot(kind="bar", color="green")

plt.title("Cantidad total vendida por vendedor")
plt.xlabel("Vendedor")
plt.ylabel("Cantidad vendida")

plt.xticks(rotation=45)
plt.show()



# ==========================================================
# GRAFICA 4
# Grafica de Pastel (Pie Chart)
# Participación de ventas por categoría
# ==========================================================
ventas_categoria = df.groupby("Categoría")["Cantidad"].sum()

plt.figure(figsize=(6,6))
plt.pie(
    ventas_categoria,
    labels=ventas_categoria.index,
    autopct='%1.1f%%',
    startangle=90
)

plt.title("Participación de ventas por categoría")
plt.show()



# ==========================================================
# GRAFICA 5
# Grafica de Líneas
# Tendencia de ventas por día
# ==========================================================
df["Fecha"] = pd.to_datetime(df["Fecha"])

ventas_fecha = df.groupby("Fecha")["Cantidad"].sum()

plt.figure(figsize=(10,5))
plt.plot(ventas_fecha.index, ventas_fecha.values, marker='o')

plt.title("Tendencia de ventas por día")
plt.xlabel("Fecha")
plt.ylabel("Cantidad vendida")

plt.xticks(rotation=45)
plt.show()



# ==========================================================
# GRAFICA 6
# Histograma
# Distribución de cantidad vendida
# ==========================================================
plt.figure(figsize=(8,5))

plt.hist(df["Cantidad"], bins=10, color="purple", edgecolor="black")

plt.title("Distribución de cantidades vendidas")
plt.xlabel("Cantidad")
plt.ylabel("Frecuencia")

plt.show()



# ==========================================================
# GRAFICA 7
# Grafica de dispersión
# Relación entre Cantidad y Precio Unitario
# ==========================================================
plt.figure(figsize=(8,5))

plt.scatter(df["Cantidad"], df["Precio Unitario"], color="red")

plt.title("Relación entre cantidad vendida y precio unitario")
plt.xlabel("Cantidad")
plt.ylabel("Precio Unitario")

plt.show()



# ==========================================================
# GRAFICA 8
# Grafica avanzada
# Ventas con promoción vs sin promoción
# ==========================================================
ventas_promocion = df.groupby("Promoción")["Cantidad"].sum()

plt.figure(figsize=(6,5))
ventas_promocion.plot(kind="bar", color=["blue","red"])

plt.title("Ventas con promoción vs sin promoción")
plt.xlabel("Promoción")
plt.ylabel("Cantidad vendida")
plt.ylim(bottom=22000)
plt.xticks(rotation=0)
plt.show()