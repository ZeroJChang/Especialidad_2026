# Laboratorio 3.2
# Programa que realiza operaciones en una lista de elementos:
# agregar, eliminar y mostrar elementos

lista = []  # Lista donde se almacenan los elementos

while True:
    print("\n--- MENÚ ---")
    print("1. Agregar elemento")
    print("2. Eliminar elemento")
    print("3. Mostrar lista")
    print("4. Salir")

    opcion = input("Seleccione una opción: ")

    # Opción 1: Agregar elemento
    if opcion == "1":
        elemento = input("Ingrese un elemento (texto, número, carácter): ")
        lista.append(elemento)
        print("Elemento agregado correctamente.")

    # Opción 2: Eliminar elemento
    elif opcion == "2":
        if not lista:
            print("La lista está vacía, no hay elementos para eliminar.")
        else:
            elemento = input("Ingrese el elemento a eliminar: ")
            if elemento in lista:
                lista.remove(elemento)
                print("Elemento eliminado correctamente.")
            else:
                print("El elemento no se encuentra en la lista.")

    # Opción 3: Mostrar lista
    elif opcion == "3":
        if lista:
            print("Lista actual:", lista)
        else:
            print("La lista está vacía.")

    # Opción 4: Salir
    elif opcion == "4":
        print("Programa finalizado.")
        break

    # Opción inválida
    else:
        print("Opción inválida. Intente nuevamente.")
