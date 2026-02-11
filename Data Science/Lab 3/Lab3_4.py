# Laboratorio 3.4
# Crear una función que invierta una cadena

def invertir_cadena(cadena):
    try:
        # Validar que la entrada sea una cadena
        if not isinstance(cadena, str):
            return "Error: el valor ingresado no es una cadena."

        # Invertir la cadena
        cadena_invertida = cadena[::-1]

        return cadena_invertida

    except Exception as e:
        return f"Ocurrió un error: {e}"


# Programa principal
texto = input("Ingrese una cadena de texto: ")

resultado = invertir_cadena(texto)

print("Cadena invertida:", resultado)
