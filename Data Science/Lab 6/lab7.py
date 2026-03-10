# LABORATORIO 7 PANDAS AVANZADO
# Análisis de Ventas de una Tienda
# Grupo 8


import pandas as pd
import random
from datetime import datetime, timedelta

ARCHIVO_CSV = "ventas_tienda.csv"

# CONFIGURACIÓN DE SIMULACIÓN 
TOTAL_REGISTROS = 12000  #Cantidad de datos
FECHA_INICIO = datetime(2022, 1, 1)
FECHA_FIN = datetime(2025, 12, 31)  # 4 AÑOS para tendencias anuales reales

FESTIVOS = {
    "01-01": "Año Nuevo",
    "02-14": "San Valentín",
    "07-04": "Día Especial",
    "11-25": "Black Friday Simulado",
    "12-24": "Noche Buena",
    "12-25": "Navidad"
}



# 1. GENERACIÓN DE DATOS

def generar_datos():
    """
    Genera un dataset realista de ventas.
    Incluye:
    - Categoría
    - Día de semana
    - Fin de semana
    - Festivo
    - Estacionalidad (Nov-Dic)
    - Horas pico
    """

    try:
        productos = ["Laptop", "Mouse", "Teclado", "Monitor", "Audífonos", "Tablet", "Cargador", "Disco SSD"]
        vendedores = ["Carlos", "Ana", "Pedro", "Luisa", "María", "Jorge"]
        promociones = ["Sí", "No"]

        categorias = {
            "Laptop": "Electrónica",
            "Monitor": "Electrónica",
            "Tablet": "Electrónica",
            "Mouse": "Accesorios",
            "Teclado": "Accesorios",
            "Audífonos": "Accesorios",
            "Cargador": "Accesorios",
            "Disco SSD": "Componentes"
        }

        dias_totales = (FECHA_FIN - FECHA_INICIO).days

        datos = []

        for _ in range(TOTAL_REGISTROS):

            # Fecha aleatoria en el rango
            fecha = FECHA_INICIO + timedelta(days=random.randint(0, dias_totales))
            producto = random.choice(productos)
            categoria = categorias[producto]
            vendedor = random.choice(vendedores)

            # Hora con picos (más probabilidad de 12-14 y 17-19)
            hora = random.choices(
                population=list(range(8, 21)),
                weights=[1,1,1,2,3,3,2,2,2,3,4,4,3],  # pico entre 12-14 y 17-19 aprox
                k=1
            )[0]

            # Base de cantidad
            cantidad = random.randint(1, 5)

            # Estacionalidad: Nov-Dic sube la cantidad
            if fecha.month in [11, 12]:
                cantidad += random.randint(1, 4)

            # Fines de semana sube la cantidad
            es_fin_semana = 1 if fecha.weekday() >= 5 else 0
            if es_fin_semana:
                cantidad += random.randint(1, 3)

            # Festivos simulados
            mmdd = fecha.strftime("%m-%d")
            es_festivo = 1 if mmdd in FESTIVOS else 0
            nombre_festivo = FESTIVOS.get(mmdd, "")

            # Precio según producto
            rangos_precio = {
                "Laptop": (700, 1800),
                "Monitor": (150, 600),
                "Tablet": (250, 1200),
                "Mouse": (10, 80),
                "Teclado": (20, 150),
                "Audífonos": (30, 300),
                "Cargador": (8, 60),
                "Disco SSD": (40, 350)
            }
            p_min, p_max = rangos_precio[producto]
            precio_unitario = round(random.uniform(p_min, p_max), 2)

            # Promoción: más probable en Nov-Dic y festivos
            if fecha.month in [11, 12] or es_festivo:
                promocion = random.choices(promociones, weights=[0.65, 0.35])[0]
            else:
                promocion = random.choices(promociones, weights=[0.40, 0.60])[0]

            datos.append([
                fecha, producto, categoria, cantidad, precio_unitario,
                vendedor, promocion, hora, es_fin_semana, es_festivo, nombre_festivo
            ])

        columnas = [
            "Fecha", "Producto", "Categoría", "Cantidad", "Precio Unitario",
            "Vendedor", "Promoción", "Hora", "EsFinDeSemana", "EsFestivo", "NombreFestivo"
        ]

        df = pd.DataFrame(datos, columns=columnas)
        df.to_csv(ARCHIVO_CSV, index=False)

        print(" CSV generado:", ARCHIVO_CSV)
        print(" Registros:", len(df))
        print(" Rango de fechas:", df["Fecha"].min(), "a", df["Fecha"].max())

        return df

    except Exception as e:
        print("Error generando datos:", e)
        return None



# 2. CARGA Y PREPARACIÓN

def cargar_datos():
    try:
        df = pd.read_csv(ARCHIVO_CSV, parse_dates=["Fecha"])
        df["Ventas Totales"] = df["Cantidad"] * df["Precio Unitario"]
        df["Mes"] = df["Fecha"].dt.month
        df["Año"] = df["Fecha"].dt.year
        df["Dia_Semana"] = df["Fecha"].dt.day_name()
        df["Dia"] = df["Fecha"].dt.day
        df["Semana"] = df["Fecha"].dt.isocalendar().week.astype(int)
        return df
    except Exception as e:
        print("Error cargando datos:", e)
        return None



# PREGUNTA 1: ANÁLISIS POR CATEGORÍA

def analisis_por_categoria(df):
    print("\n" + "="*70)
    print("P1) ANÁLISIS DE VENTAS POR CATEGORÍA DE PRODUCTOS")
    print("="*70)

    res = df.groupby("Categoría")["Ventas Totales"].agg(
        Ventas_Totales="sum",
        Promedio_Venta="mean",
        Transacciones="count"
    ).sort_values("Ventas_Totales", ascending=False)

    print(res)

    top = res.index[0]
    print(f"\n Categoría con MAYOR venta total: {top}")

    return res



# PREGUNTA 2: TENDENCIAS MENSUALES Y ANUALES

def tendencias_mensuales_anuales(df):
    print("\n" + "="*70)
    print("P2) TENDENCIAS DE VENTAS MENSUALES Y ANUALES")
    print("="*70)

    mensual = df.groupby(["Año", "Mes"])["Ventas Totales"].sum().reset_index()
    anual = df.groupby("Año")["Ventas Totales"].sum().reset_index()

    print("\nVentas Mensuales (primeros 15):")
    print(mensual.head(15))

    print("\nVentas Anuales:")
    print(anual)

    # Top mes por año
    top_mes = (
        mensual.sort_values(["Año", "Ventas Totales"], ascending=[True, False])
        .groupby("Año").first()
    )
    print("\n Mes con mayor venta por año:")
    print(top_mes)

    return mensual, anual



# PREGUNTA 3: FILTRADO Y SEGMENTACIÓN AVANZADA

def filtrado_segmentacion_avanzada(df):
    print("\n" + "="*70)
    print("P3) FILTRADO Y SEGMENTACIÓN AVANZADA")
    print("="*70)

    # A) Solo promociones
    promo = df[df["Promoción"] == "Sí"]
    print("\nA) Solo ventas con PROMOCIÓN")
    print("Total ventas con promoción:", promo["Ventas Totales"].sum())

    print("\nTop 5 productos con promoción:")
    print(promo.groupby("Producto")["Ventas Totales"].sum().sort_values(ascending=False).head(5))

    # B) Productos seleccionados
    productos_sel = ["Laptop", "Monitor", "Tablet"]
    sel = df[df["Producto"].isin(productos_sel)]
    print("\nB) Ventas de productos seleccionados:", productos_sel)
    print("Total ventas:", sel["Ventas Totales"].sum())

    print("\nVentas por producto seleccionado:")
    print(sel.groupby("Producto")["Ventas Totales"].sum().sort_values(ascending=False))

    # C) Rango de fechas: ejemplo (Nov-Dic 2024)
    rango = df[(df["Fecha"] >= "2024-11-01") & (df["Fecha"] <= "2024-12-31")]
    print("\nC) Ventas en rango de fechas (Nov-Dic 2024)")
    print("Total ventas:", rango["Ventas Totales"].sum())

    print("\nTop productos en Nov-Dic 2024:")
    print(rango.groupby("Producto")["Ventas Totales"].sum().sort_values(ascending=False).head(5))

    return promo, sel, rango



# PREGUNTA 4: VENTAS EN FUNCIÓN DEL TIEMPO (DÍAS / FESTIVOS / FINES)

def ventas_funcion_tiempo(df):
    print("\n" + "="*70)
    print("P4) ANÁLISIS DE VENTAS EN FUNCIÓN DEL TIEMPO")
    print("="*70)

    # ¿Qué días de la semana venden más?
    ventas_dia = df.groupby("Dia_Semana")["Ventas Totales"].sum().sort_values(ascending=False)
    print("\nVentas por día de semana:")
    print(ventas_dia)

    print("\n Día con mayor venta:", ventas_dia.idxmax())

    # Fin de semana vs no
    fin_semana = df.groupby("EsFinDeSemana")["Ventas Totales"].sum()
    print("\nVentas Fin de Semana (1) vs No (0):")
    print(fin_semana)

    # Festivos vs no festivos
    festivo = df.groupby("EsFestivo")["Ventas Totales"].sum()
    print("\nVentas Festivo (1) vs No (0):")
    print(festivo)

    # Top festivos por ventas
    festivos_top = (
        df[df["EsFestivo"] == 1]
        .groupby("NombreFestivo")["Ventas Totales"]
        .sum()
        .sort_values(ascending=False)
    )
    if len(festivos_top) > 0:
        print("\n Festivos con mayor venta:")
        print(festivos_top)

    return ventas_dia



# PREGUNTA 5: CRECIMIENTO MENSUAL (MES ACTUAL VS MES PASADO)

def crecimiento_ventas(df):
    print("\n" + "="*70)
    print("P5) CRECIMIENTO PORCENTUAL DE VENTAS (MES ACTUAL VS MES PASADO)")
    print("="*70)

    mensual = df.groupby(["Año", "Mes"])["Ventas Totales"].sum().reset_index()
    mensual = mensual.sort_values(["Año", "Mes"])
    mensual["Periodo"] = mensual["Año"].astype(str) + "-" + mensual["Mes"].astype(str)
    mensual["Crecimiento_MoM(%)"] = mensual["Ventas Totales"].pct_change() * 100

    print(mensual[["Periodo", "Ventas Totales", "Crecimiento_MoM(%)"]].head(20))

    # Mostrar top 5 crecimientos
    top_growth = mensual.sort_values("Crecimiento_MoM(%)", ascending=False).head(5)
    print("\n Top 5 meses con mayor crecimiento:")
    print(top_growth[["Periodo", "Ventas Totales", "Crecimiento_MoM(%)"]])

    return mensual



# PREGUNTA 6: VENTAS POR VENDEDOR (TOTAL + PROMEDIO DIARIO)

def ventas_por_vendedor(df):
    print("\n" + "="*70)
    print("P6) VALOR TOTAL DE VENTAS POR VENDEDOR + PROMEDIO DIARIO")
    print("="*70)

    total = df.groupby("Vendedor")["Ventas Totales"].sum()

    promedio_diario = (
        df.groupby(["Vendedor", "Fecha"])["Ventas Totales"]
        .sum()
        .groupby("Vendedor")
        .mean()
    )

    res = pd.DataFrame({
        "Ventas Totales": total,
        "Promedio Diario": promedio_diario
    }).sort_values("Ventas Totales", ascending=False)

    print(res)

    top_vendedor = res.index[0]
    print(f"\n Vendedor con más ventas: {top_vendedor}")

    return res



# PREGUNTA 7: PROMOCIONES EN DIFERENTES PERIODOS (DÍAS / MESES)

def promociones_periodos(df):
    print("\n" + "="*70)
    print("P7) PROMOCIONES VS DÍAS DE LA SEMANA / MESES")
    print("="*70)

    promo = df[df["Promoción"] == "Sí"]
    no_promo = df[df["Promoción"] == "No"]

    print("\nPromedio de venta CON promoción:", promo["Ventas Totales"].mean())
    print("Promedio de venta SIN promoción:", no_promo["Ventas Totales"].mean())

    promo_dia = promo.groupby("Dia_Semana")["Ventas Totales"].sum().sort_values(ascending=False)
    print("\n Ventas con promoción por día de semana:")
    print(promo_dia)

    promo_mes = promo.groupby("Mes")["Ventas Totales"].sum().sort_values(ascending=False)
    print("\n Ventas con promoción por mes:")
    print(promo_mes)

    return promo_dia, promo_mes



# PREGUNTA 8: OUTLIERS (IQR)

def detectar_outliers_iqr(df):
    print("\n" + "="*70)
    print("P8) DETECCIÓN DE OUTLIERS CON IQR")
    print("="*70)

    Q1 = df["Ventas Totales"].quantile(0.25)
    Q3 = df["Ventas Totales"].quantile(0.75)
    IQR = Q3 - Q1

    limite_inf = Q1 - 1.5 * IQR
    limite_sup = Q3 + 1.5 * IQR

    outliers = df[(df["Ventas Totales"] < limite_inf) | (df["Ventas Totales"] > limite_sup)]

    print("Cantidad de outliers:", len(outliers))
    print("\nTop 10 outliers por ventas:")
    print(outliers.sort_values("Ventas Totales", ascending=False).head(10)[
        ["Fecha", "Producto", "Categoría", "Cantidad", "Precio Unitario", "Ventas Totales", "Vendedor", "Promoción"]
    ])

    return outliers



# MAIN

def main():
    generar_datos()
    df = cargar_datos()

    if df is None:
        return

    print("\n" + "="*70)
    print("EXPLORACIÓN BÁSICA")
    print("="*70)
    print(df.head())
    print(df.describe())

    analisis_por_categoria(df)
    tendencias_mensuales_anuales(df)
    filtrado_segmentacion_avanzada(df)
    ventas_funcion_tiempo(df)
    crecimiento_ventas(df)
    ventas_por_vendedor(df)
    promociones_periodos(df)
    detectar_outliers_iqr(df)


if __name__ == "__main__":
    main()