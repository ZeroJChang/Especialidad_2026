def factorial(x):
    # el factorial de 0 y 1 es 1
    if x == 0 or x == 1:
        return 1

    # mientras x sea mayor a 1, se llama a si misma (recursividad)
    return x * factorial(x - 1)


def main():
    continuar = True
    while continuar:
        try:
            # solicitamos el número al usuario
            numero = int(
                input(
                    "Ingrese un numero para calcular su factorial que sea entero y mayor a cero: "
                )
            )

            # verificamos que el número sea entero y sea mayor a cero
            if numero >= 0:
                print(f"El factorial de {numero} es: {factorial(numero)}")
            else:
                # si no cumple la condicion mostramos mensaje de error
                print("Error: El número debe ser un entero no negativo.")
        except ValueError:
            # si no ingresa un numero valido mostramos mensaje de error
            print("Error: Debe ingresar un número entero válido.")

        respuesta = input("¿Deseas continuar? (s/n): ").lower()
        if (
            respuesta != "s"
        ):  # si el usuario ya no desea continuar, rompe el ciclo while
            continuar = False


main()  # ejecutar programa
