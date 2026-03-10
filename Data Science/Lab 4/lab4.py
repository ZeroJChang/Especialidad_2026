import csv
import json
import pandas as pd


# Leer el archivo CSV y mostrar su contenido
def main():
    # pedimos el nombre del archivo. Si es archivo de texto, lo leemos y obtenemos sus estadísticas, si no, solo lo leemos y mostramos su contenido
    filename = input("Ingrese el nombre del archivo (con extensión): ")
    content = read_file(filename)

    # Si el archivo no es un archivo de texto, solo imprimimos su contenido y no hacemos nada más
    if not content:
        return

    # si es un archivo de texto, realizamos la wordización y el conteo de palabras
    words = content_cleaner(content)
    word_freq = word_counter(words)
    common = common_words(word_freq)
    # calcular el promedio de longitud de palabras
    average = average_word_counter(words)
    # reutilizamos el contador de palabras para obtener la frecuencia de caracteres, pero en lugar de contar palabras, contamos caracteres
    # quitamos los espacios en blanco para contar solo los caracteres y hacemos una lista de los caracteres
    char_freq = word_counter(list("".join(words).replace(" ", "")))

    # escribimos los resultados en un archivo de texto
    write_file(len(words), word_freq, common, char_freq, average)


# parte 1 - lectura del archivo de texto y mostrar su contenido
def read_file(filename):
    try:
        with open(
            filename,
            "r",
        ) as file:

            if filename.endswith(".csv"):
                reader = csv.reader(file, delimiter=",")
                for row in reader:
                    print(row)
            elif filename.endswith(".json"):
                data = json.load(file)
                print(data)
            elif filename.endswith(".xlsx"):
                df = pd.read_excel(file)
                print(df)
            elif filename.endswith(".txt"):
                content = file.read()
                print(content)
                return content
    except Exception as e:
        print(f"Error al leer el archivo: {e}")


# parte 2 - limpieza de texto
def content_cleaner(content):
    text = content.lower()  # Convertir a minúsculas
    # Quitamos los caracteres especiales y espacios en blanco
    for p in '.,!?¿;:"()[]{}<>¡¿':
        text = text.replace(p, "")
    return text.split()


# parte 3 - conteo de palabras
def word_counter(words):
    word_freq = {}
    for word in words:
        if word in word_freq:
            word_freq[word] += 1
        else:
            word_freq[word] = 1

    print("Conteo de palabras")
    for word, count in word_freq.items():
        print(f"{word}: {count}")
    print("Total de palabras:", len(words))

    return word_freq


# parte 4 - palabras comunes
def common_words(word_freq, n=10):
    sorted_words = sorted(word_freq.items(), key=lambda item: item[1], reverse=True)
    print(f"\nLas {n} palabras más comunes son:")
    result = ""
    for word, count in sorted_words[:n]:
        print(f"{word}: {count}")
        result += f"{word}: {count}\n"
    return result


# parte 5 - promedio de palabras
def average_word_counter(words):
    length = 0
    for word in words:
        length += len(word)
    average = length / len(words) if words else 0
    return average


# parte 7 - escribir archivo
def write_file(word_len, word_freq, common_words, char_freq, average):
    # escribimos los resultados en un archivo de texto
    with open("resultado_analisis.txt", "w") as file:
        file.write(f"--- Total de palabras: {word_len}\n\n")
        file.write("--- Frecuencia de palabras:\n")
        for word, count in word_freq.items():
            file.write(f"{word}: {count}\n")
        file.write(f"\n--- Palabras comunes:\n{common_words}")
        file.write(f"\n--- Promedio de longitud de palabras: {average:.2f}\n")
        file.write("\n--- Frecuencia de caracteres:\n")
        for char, count in char_freq.items():
            file.write(f"{char}: {count}\n")
        file.write(f"\n--- Total de caracteres: {sum(char_freq.values())}\n")


main()
