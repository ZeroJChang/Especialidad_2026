# =========================================================
# LABORATORIO 9 - SCIKIT LEARN
# =========================================================

try:
    # =====================================================
    # PASO 1: IMPORTAR LIBRERÍAS
    # =====================================================
    import pandas as pd
    import numpy as np

    from sklearn.datasets import load_iris
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import StandardScaler

    from sklearn.linear_model import LogisticRegression
    from sklearn.neighbors import KNeighborsClassifier
    from sklearn.svm import SVC

    from sklearn.metrics import accuracy_score, confusion_matrix, classification_report

    import joblib

    # =====================================================
    # PARTE 1: CARGAR Y EXPLORAR DATASET
    # =====================================================
    print("===== PARTE 1: CARGA Y EXPLORACIÓN =====")

    # Cargar dataset Iris
    iris = load_iris()

    # Convertir a DataFrame
    df = pd.DataFrame(iris.data, columns=iris.feature_names)

    # Agregar columna objetivo
    df["target"] = iris.target

    # Mostrar primeras filas
    print("\nPrimeras 5 filas:")
    print(df.head())

    # Información general
    print("\nInformación del dataset:")
    print(df.info())

    # Estadísticas
    print("\nEstadísticas descriptivas:")
    print(df.describe())


    # =====================================================
    # PARTE 2: DIVISIÓN DE DATOS
    # =====================================================

    # Separar variables
    X = df.drop("target", axis=1)
    y = df["target"]

    # División 80% entrenamiento - 20% prueba
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )


    # =====================================================
    # PARTE 3: ESCALADO DE CARACTERÍSTICAS
    # =====================================================
    scaler = StandardScaler()

    # Ajustar SOLO con entrenamiento
    X_train_scaled = scaler.fit_transform(X_train)

    # Transformar test
    X_test_scaled = scaler.transform(X_test)

    # =====================================================
    # PARTE 4: REGRESIÓN LOGÍSTICA
    # =====================================================

    model_lr = LogisticRegression()

    # Entrenar modelo
    model_lr.fit(X_train_scaled, y_train)

    # Predicciones
    y_pred_lr = model_lr.predict(X_test_scaled)

    # =====================================================
    # PARTE 5: EVALUACIÓN
    # =====================================================
    print("\n===== PARTE 5: EVALUACIÓN =====")

    print("\nAccuracy:")
    print(accuracy_score(y_test, y_pred_lr))

    print("\nMatriz de confusión:")
    print(confusion_matrix(y_test, y_pred_lr))

    print("\nReporte de clasificación:")
    print(classification_report(y_test, y_pred_lr))


    # =====================================================
    # PARTE 6: OTROS MODELOS (KNN y SVM)
    # =====================================================
    print("\n===== PARTE 6: OTROS MODELOS =====")

    # ----- KNN -----
    knn = KNeighborsClassifier(n_neighbors=5)
    knn.fit(X_train_scaled, y_train)
    y_pred_knn = knn.predict(X_test_scaled)

    print("\nKNN Accuracy:")
    print(accuracy_score(y_test, y_pred_knn))


    # ----- SVM -----
    svm = SVC()
    svm.fit(X_train_scaled, y_train)
    y_pred_svm = svm.predict(X_test_scaled)

    print("\nSVM Accuracy:")
    print(accuracy_score(y_test, y_pred_svm))


    # =====================================================
    # PARTE 7: GUARDAR Y CARGAR MODELO
    # =====================================================
    print("\n===== GUARDAR Y CARGAR =====")

    # Guardar modelo
    joblib.dump(model_lr, "modelo_iris.pkl")

    # Cargar modelo
    modelo_cargado = joblib.load("modelo_iris.pkl")

    # Probar predicción (primer dato del test)
    ejemplo = [X_test_scaled[0]]
    pred = modelo_cargado.predict(ejemplo)

    # ===============================
    # MOSTRAR RESULTADOS
    # ===============================

    print("\n--- RESULTADO DE PREDICCIÓN ---")

    # Predicción del modelo
    print("Predicción (número):", pred[0])
    print("Predicción (nombre):", iris.target_names[pred[0]])

    # Valor real
    valor_real = y_test.iloc[0]
    print("\nValor real (número):", valor_real)
    print("Valor real (nombre):", iris.target_names[valor_real])

    # Comparación
    if pred[0] == valor_real:
        print("\nEl modelo acertó")
    else:
        print("\nEl modelo falló")

# =========================================
# VER RESULTADOS EN TABLA
# =========================================

    resultados = pd.DataFrame({
        "Real": y_test.values,
        "Predicción": y_pred_lr
    })

    # Convertir a nombres
    resultados["Real Nombre"] = resultados["Real"].apply(lambda x: iris.target_names[x])
    resultados["Predicción Nombre"] = resultados["Predicción"].apply(lambda x: iris.target_names[x])

    # Comparación
    resultados["Correcto"] = resultados["Real"] == resultados["Predicción"]

    print("\n===== RESULTADOS DEL MODELO =====")
    print(resultados.head(10))
# =========================================================
# MANEJO DE ERRORES
# =========================================================
except ImportError as e:
    print("Error: Falta instalar una librería")
    print(e)

except FileNotFoundError as e:
    print("Error: Archivo no encontrado")
    print(e)

except Exception as e:
    print("Error inesperado:")
    print(e)