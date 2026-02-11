# Laboratorio 3
#NOMBRE: DIEGO JAVIER MORALES MONZÓN			CARNÉ: 1132119
#NOMBRE: ESTUARDO JOSÉ VILLEDA NAVARRO			CARNÉ: 1003519
#NOMBRE: JORGE WALDEMAR GARCÍA BALDIZÓN			CARNÉ: 1220019
#NOMBRE: JOSÉ DANIEL DE LEÓN CHANG				CARNÉ: 1170419
# MENÚ GENERAL - LABORATORIOS UNIDAD 3

# LABORATORIO 3.1
# Guardar números y filtrar pares

def laboratorio_31():
    datos = []         # Lista con los números ingresados
    numeros_pares = [] # Lista con los números pares

    print("\nLaboratorio 3.1 - Números pares")
    print("Ingrese SOLO números enteros.")
    print("Escriba 'fin' para terminar.\n")

    # Ingreso de datos
    while True:
        entrada = input("Ingrese un número: ")

        if entrada.lower() == "fin":
            break

        try:
            numero = int(entrada)   # Permite positivos y negativos
            datos.append(numero)
        except ValueError:
            print("Error: Solo se permiten números enteros.")

    # Filtrar números pares
    for numero in datos:
        if numero % 2 == 0:
            numeros_pares.append(numero)

    print("\nLista de números ingresados:", datos)
    print("Lista de números pares:", numeros_pares)



# LABORATORIO 3.2
# Operaciones con lista de elementos

def laboratorio_32():
    lista = []  # Lista de elementos

    while True:
        print("\nLaboratorio 3.2 - Lista de elementos")
        print("1. Agregar elemento")
        print("2. Eliminar elemento")
        print("3. Mostrar lista")
        print("4. Volver al menú principal")

        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            elemento = input("Ingrese un elemento: ")
            lista.append(elemento)
            print("Elemento agregado correctamente.")

        elif opcion == "2":
            if not lista:
                print("La lista está vacía.")
            else:
                elemento = input("Ingrese el elemento a eliminar: ")
                if elemento in lista:
                    lista.remove(elemento)
                    print("Elemento eliminado.")
                else:
                    print("El elemento no existe.")

        elif opcion == "3":
            print("Lista actual:", lista)

        elif opcion == "4":
            break

        else:
            print("Opción inválida.")



# LABORATORIO 3.3
# Contador de palabras

def laboratorio_33():
    print("\nLaboratorio 3.3 - Contador de palabras")
    texto = input("Ingrese un texto: ").strip()

    if texto == "":
        print("No se ingresó ningún texto.")
    else:
        palabras = texto.split()
        print("Cantidad de palabras:", len(palabras))



# LABORATORIO 3.4
# Invertir una cadena

def laboratorio_34():
    print("\nLaboratorio 3.4 - Invertir cadena")
    texto = input("Ingrese una cadena: ")
    print("Cadena invertida:", texto[::-1])



# LABORATORIO 3.5
# Manipulación de cadenas

def laboratorio_35():
    print("\nLaboratorio 3.5 - Manipulación de cadenas")
    texto = input("Ingrese una cadena de texto: ").strip()

    if texto == "":
        print("No se ingresó ningún texto.")
    else:
        print("\n--- RESULTADOS ---")
        print("Texto ingresado: {}".format(texto))
        print("Cantidad de caracteres: {}".format(len(texto)))
        print("Cadena invertida: {}".format(texto[::-1]))
        print("En mayúsculas: {}".format(texto.upper()))
        print("En minúsculas: {}".format(texto.lower()))



# MENÚ PRINCIPAL

while True:
    print("\n====== MENÚ PRINCIPAL ======")
    print("1. Laboratorio 3.1 - Números pares")
    print("2. Laboratorio 3.2 - Lista de elementos")
    print("3. Laboratorio 3.3 - Contador de palabras")
    print("4. Laboratorio 3.4 - Invertir cadena")
    print("5. Laboratorio 3.5 - Manipulación de cadenas")
    print("6. Salir")

    opcion = input("Seleccione una opción: ")

    if opcion == "1":
        laboratorio_31()
    elif opcion == "2":
        laboratorio_32()
    elif opcion == "3":
        laboratorio_33()
    elif opcion == "4":
        laboratorio_34()
    elif opcion == "5":
        laboratorio_35()
    elif opcion == "6":
        print("Programa finalizado.")
        break
    else:
        print("Opción inválida. Intente nuevamente.")
