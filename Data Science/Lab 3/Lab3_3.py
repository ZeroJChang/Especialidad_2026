
# Laboratorio 3.3
# Contador de palabras

try:
    # Solicitar texto al usuario
    texto = input("Ingrese un texto: ").strip()

    # Validar que el texto no esté vacío
    if texto == "":
        print("No se ingresó ningún texto.")
    else:
        # Separar el texto en palabras usando espacios
        palabras = texto.split()

        # Contar las palabras
        cantidad_palabras = len(palabras)

        # Mostrar resultado
        print("Cantidad de palabras:", cantidad_palabras)

except Exception as e:
    print("Ocurrió un error:", e)
