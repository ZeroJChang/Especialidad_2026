def main():
    continuar = True
    # Se utiliza un ciclo while para permitir múltiples operaciones
    # hasta que el usuario ingrese ene para salir
    while continuar:
        try:

            # mostramos el menú de operaciones
            print("\n\n\n\n\n\nSeleccione la operación:")
            print("1. Suma")
            print("2. Resta")
            print("3. Multiplicación")
            print("4. División")
            print("Si deseas salir presiona 0")
            operacion = int(input("Ingrese el número de la operación (1-4): "))
            if operacion == 0:
                print("Adiós c:")
                break
            elif operacion not in [1, 2, 3, 4]:
                print(
                    "Operación inválida"
                )  # Si ingresa un número no válido, muestra mensaje de error
                continue

            # Se solicitan los números al usuario
            numero1 = float(input("Ingrese el primer número: "))
            numero2 = float(input("Ingrese el segundo número: "))

            #
            if operacion == 1:
                resultado = suma(numero1, numero2)
                print(f"La suma de {numero1} y {numero2} es: {resultado}")
            elif operacion == 2:
                resultado = resta(numero1, numero2)
                print(f"La resta de {numero1} y {numero2} es: {resultado}")
            elif operacion == 3:
                resultado = multiplicacion(numero1, numero2)
                print(f"La multiplicación de {numero1} y {numero2} es: {resultado}")
            elif operacion == 4:
                resultado = division(numero1, numero2)
                print(f"La división de {numero1} entre {numero2} es: {resultado}")

            respuesta = input("¿Desea realizar otra operación? (s/n): ").lower()
            if (
                respuesta != "s"
            ):  # si el usuario ya no desea continuar, rompe el ciclo while
                continuar = False
        except (
            ValueError
        ):  # Si la conversión a numero falla imprime el mensaje de error
            print("\n\n\n\n\nEntrada inválida. Por favor, ingrese números válidos.")


# Operaciones básicas #
# definimos funcion de suma
def suma(a, b):
    return a + b


# definimos funcion de resta
def resta(a, b):
    return a - b


# definimos funcion de multiplicación
def multiplicacion(a, b):
    return a * b


# Validamos que el divisor no sea cero
def division(a, b):
    if b == 0:
        return "\nIndefinido (división por cero)"
    return a / b


main()  # ejecutar programa
