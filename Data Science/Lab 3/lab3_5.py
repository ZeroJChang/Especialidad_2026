# Laboratorio 3.5
# Programa de manipulación de cadenas:
# contar caracteres, invertir y formatear una cadena
# Uso del método .format()

def contar_caracteres(cadena):
    #Cuenta la cantidad de caracteres de una cadena
    return len(cadena)

def invertir_cadena(cadena):
    #Invierte una cadena de texto
    return cadena[::-1]

def formatear_cadena(cadena):
    #Devuelve diferentes formatos de la cadena
    mayusculas = cadena.upper()
    minusculas = cadena.lower()
    capitalizada = cadena.capitalize()
    return mayusculas, minusculas, capitalizada


# Programa principal
try:
    texto = input("Ingrese una cadena de texto: ").strip()

    if texto == "":
        print("No se ingresó ningún texto.")
    else:
        cantidad = contar_caracteres(texto)
        invertida = invertir_cadena(texto)
        mayus, minus, cap = formatear_cadena(texto)

        print("\n--- RESULTADOS ---")
        print("Texto ingresado: {}".format(texto))
        print("Cantidad de caracteres: {}".format(cantidad))
        print("Cadena invertida: {}".format(invertida))
        print("En mayúsculas: {}".format(mayus))
        print("En minúsculas: {}".format(minus))

except Exception as e:
    print("Ocurrió un error: {}".format(e))
