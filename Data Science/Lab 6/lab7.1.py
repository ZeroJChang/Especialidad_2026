# =========================================================
# SEMANA 7 - PANDAS
# Todos los códigos de la presentación
# - Laboratorio 7.1
# =========================================================

import pandas as pd
import numpy as np

print("="*60)
print("1) CREACIÓN DE SERIES")
print("="*60)

serie = pd.Series([1, 2, 3, 4])
print("Serie creada:")
print(serie)
print("Primer elemento:", serie[0])


# =========================================================
print("\n" + "="*60)
print("2) CREACIÓN DE DATAFRAME")
print("="*60)

data = {
    "Nombre": ["Juan", "Ana"],
    "Edad": [30, 25]
}

df = pd.DataFrame(data)
print(df)
print("\nInformación del DF:")
print(df.info())


# =========================================================
print("\n" + "="*60)
print("3) OPERACIONES CON DATAFRAME")
print("="*60)

# Filtrado
df_filtrado = df[df["Edad"] > 25]
print("\nFiltrado Edad > 25:")
print(df_filtrado)

# Selección columnas
print("\nColumna Edad:")
print(df["Edad"])

# Selección filas
print("\nPrimera fila con iloc:")
print(df.iloc[0])

# Asignación nuevos valores
df["Edad"] = df["Edad"] + 1
print("\nEdad incrementada en 1:")
print(df)

# Condición compleja
df_cond = df[(df["Edad"] > 25) & (df["Nombre"] == "Juan")]
print("\nCondición compleja:")
print(df_cond)


# =========================================================
print("\n" + "="*60)
print("4) ESTADÍSTICAS DESCRIPTIVAS")
print("="*60)

print(df.describe())

media_edad = df["Edad"].mean()
mediana_edad = df["Edad"].median()

print("Media edad:", media_edad)
print("Mediana edad:", mediana_edad)

print("Valores únicos Nombre:", df["Nombre"].nunique())
print("Frecuencia nombres:")
print(df["Nombre"].value_counts())


# =========================================================
print("\n" + "="*60)
print("5) AGRUPACIÓN Y AGREGACIÓN")
print("="*60)

data2 = {
    "Nombre": ["Juan", "Ana", "Pedro", "Luisa"],
    "Edad": [22, 25, 22, 24],
    "Grado": ["2do", "3er", "2do", "3er"]
}

df_estudiantes = pd.DataFrame(data2)

print("DataFrame estudiantes:")
print(df_estudiantes)

# Agrupar por grado
df_agregado = df_estudiantes.groupby("Grado").mean(numeric_only=True)
print("\nPromedio edad por grado:")
print(df_agregado)

df_agregado2 = df_estudiantes.groupby("Grado").agg({"Edad": ["mean", "max", "min"]})
print("\nAgregaciones múltiples:")
print(df_agregado2)


# =========================================================
print("\n" + "="*60)
print("6) MANEJO DE VALORES FALTANTES")
print("="*60)

# Crear datos con nulos
data_nulos = {
    "Nombre": ["Juan", "Ana", "Pedro", "Luisa"],
    "Edad": [22, None, 22, None],
    "Grado": ["2do", "3er", "2do", "3er"]
}

df_nulos = pd.DataFrame(data_nulos)

print("DF con nulos:")
print(df_nulos)

print("\nValores nulos por columna:")
print(df_nulos.isnull().sum())

# Rellenar con media
df_nulos["Edad"] = df_nulos["Edad"].fillna(df_nulos["Edad"].mean())

print("\nEdad rellenada con media:")
print(df_nulos)


# =========================================================
print("\n" + "="*60)
print("7) LABORATORIO 7.1")
print("="*60)

# Crear nuevamente con nulos
df_lab = pd.DataFrame({
    "Nombre": ["Juan", "Ana", "Pedro", "Luisa"],
    "Edad": [22, None, 22, None],
    "Grado": ["2do", "3er", "2do", "3er"]
})

print("Antes de rellenar:")
print(df_lab)

#Rellenar con MEDIANA 
mediana = df_lab["Edad"].median()
df_lab["Edad"] = df_lab["Edad"].fillna(mediana)

print("\nDespués de rellenar con MEDIANA:")
print(df_lab)
