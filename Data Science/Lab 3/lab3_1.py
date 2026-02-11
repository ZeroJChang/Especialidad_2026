# Laboratorio 3.1
#NOMBRE: DIEGO JAVIER MORALES MONZÓN			CARNÉ: 1132119
#NOMBRE: ESTUARDO JOSÉ VILLEDA NAVARRO			CARNÉ: 1003519
#NOMBRE: JORGE WALDEMAR GARCÍA BALDIZÓN			CARNÉ: 1220019
#NOMBRE: JOSÉ DANIEL DE LEÓN CHANG				CARNÉ: 1170419
# Guardar únicamente números en una lista
# Al final filtrar solo los números pares
# Uso de try / except para validación

datos = []         # Lista con los números ingresados
numeros_pares = [] # Lista con los números pares

print("Ingrese SOLO números enteros.")
print("Escriba 'fin' para terminar.\n")

# Ingreso de datos
while True:
    entrada = input("Ingrese un número: ")

    # Condición para terminar
    if entrada.lower() == "fin":
        break

    try:
        # Intentar convertir la entrada a número entero
        numero = int(entrada)
        datos.append(numero)

    except ValueError:
        # Si no es un número, se muestra un mensaje
        print("Error: Solo se permiten números enteros.")

# Filtrar números pares
for numero in datos:
    try:
        if numero % 2 == 0:
            numeros_pares.append(numero)
    except Exception as e:
        print("Error inesperado:", e)

# Resultados
print("\nLista de números ingresados:")
print(datos)

print("\nLista de números pares:")
print(numeros_pares)
