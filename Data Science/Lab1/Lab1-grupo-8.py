# Laboratorio 1 - Grupo 8
# Diego Morales - 1132119
# Estuardo Villeda - 1003519
# Jorge Garcia - 1220019
# Jose De Leon - 1170419


import random  # Para el 2

# Laboratorio 1.1 Area de un rectangulo


def area_rectangulo(base, altura):
    if base <= 0 or altura <= 0:
        return None
    return base * altura


while True:
    try:
        b = float(input("Ingrese la base: "))
        h = float(input("Ingrese la altura: "))

        resultado = area_rectangulo(b, h)

        if resultado is None:
            print("Error: los valores deben ser mayores que cero.")
        else:
            if b == h:
                print("La figura es un cuadrado.")
            else:
                print("La figura es un rectángulo.")

            print("Área:", resultado)
            break

    except ValueError:
        print("Error: debe ingresar valores numéricos.")


# Laboratorio 1.2 Adivina el numero
numero_secreto = random.randint(1, 10)
intentos = 4

print("\n\nAdivina el número (entre 1 y 10)")
print(f"Tienes {intentos} intentos.\n")

while intentos > 0:
    try:
        numero = int(input("Ingresa un número: "))

        # Validar rango
        if numero < 1 or numero > 10:
            intentos -= 1
            print(
                f"Error: el número debe estar entre 1 y 10."
                f"Intentos restantes: {intentos}\n"
            )
            continue

        if numero == numero_secreto:
            print("¡Correcto! Adivinaste el número.")
            break
        elif numero < numero_secreto:
            intentos -= 1
            print(f"El número MÁS ALTO. Intentos restantes: {intentos}\n")
        else:
            intentos -= 1
            print(f"El número MÁS BAJO. Intentos restantes: {intentos}\n")

    except ValueError:
        print("Error: debes ingresar un número entero válido.\n")

if intentos == 0:
    print(f"Se acabaron los intentos. El número era {numero_secreto}.")


# Laboratorio 1.3 Numero Primo
def verificar_primo():
    print("\n\nVerificar número primo")

    try:
        n = int(input("Ingresa un número: "))
    except ValueError:
        print("Error: debes ingresar un número entero válido.")
        return

    if n <= 1:
        print(n, "no es primo")
        return

    for i in range(2, n):
        if n % i == 0:
            print(n, "no es primo")
            return

    print(n, "es primo")


verificar_primo()


# Laboratorio 4 - Fibonacci
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)


while True:
    try:
        n = int(input("\n\nIngrese cuántos números de Fibonacci desea ver: "))

        if n <= 0:
            print("Error: debe ingresar un número entero mayor que 0.\n")
        else:
            print("Serie de Fibonacci:")
            for i in range(n):
                print(f"Fibonacci({i}) = {fibonacci(i)}")
            break

    except ValueError:
        print("Error: debe ingresar un número entero válido.\n")
