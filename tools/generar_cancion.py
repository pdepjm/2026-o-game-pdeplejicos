# -*- coding: utf-8 -*-
"""
Genera cancion.wlk a partir de un archivo .chart (formato Clone Hero / Moonscraper).

No es parte del juego: es la herramienta que usamos una sola vez para pasar
el chart a una lista de notas, con sus tiempos en milisegundos, que Wollok pueda leer.

    python tools/generar_cancion.py notes.chart
"""
import re
import sys

DIFICULTAD = "EasySingle"   # 1 carril. Para 4 carriles usar "MediumSingle"
HASTA_MS = 30000            # primera entrega: solo los primeros 30 segundos
SALIDA = "cancion.wlk"


def leer_secciones(texto):
    return {m.group(1): m.group(2)
            for m in re.finditer(r"\[(\w+)\]\s*\{(.*?)\n\}", texto, re.S)}


def cambios_de_bpm(sync):
    cambios = [(int(m.group(1)), int(m.group(2)) / 1000.0)
               for m in re.finditer(r"^\s*(\d+)\s*=\s*B\s+(\d+)", sync, re.M)]
    return sorted(cambios)


def tick_a_ms(tick, cambios, resolucion):
    """Un chart puede cambiar de tempo, asi que acumulamos tramo por tramo."""
    ms = 0.0
    for i, (desde, bpm) in enumerate(cambios):
        if tick <= desde:
            break
        hasta = cambios[i + 1][0] if i + 1 < len(cambios) else float("inf")
        ms += (min(tick, hasta) - desde) / resolucion * (60000.0 / bpm)
    return ms


def main(ruta_chart):
    texto = open(ruta_chart, encoding="utf-8-sig", errors="replace").read()
    secciones = leer_secciones(texto)

    datos = dict(re.findall(r"^\s*(\w+)\s*=\s*(.+?)\s*$", secciones["Song"], re.M))
    resolucion = int(datos["Resolution"])
    cambios = cambios_de_bpm(secciones["SyncTrack"])

    # En el .chart los trastes 5, 6 y 7 no son notas sino modificadores
    # (force / tap / open), asi que los descartamos.
    # Cada nota trae su largo en ticks: si es 0 hay que tocarla, si no hay que
    # mantenerla. Si dos trastes caen en el mismo tick nos quedamos con el mas largo.
    largos = {}
    for m in re.finditer(r"^\s*(\d+)\s*=\s*N\s+([0-4])\s+(\d+)",
                         secciones[DIFICULTAD], re.M):
        tick, largo = int(m.group(1)), int(m.group(3))
        largos[tick] = max(largo, largos.get(tick, 0))

    # Una sola lista con todas las notas, EN ORDEN DE TIEMPO: la partida solo mira
    # la primera que falta aparecer, asi que el orden no es opcional.
    notas = []
    cantidad_sostenidas = 0
    for tick, largo in sorted(largos.items()):
        tiempo = round(tick_a_ms(tick, cambios, resolucion))
        if tiempo >= HASTA_MS:
            continue
        if largo == 0:
            notas.append(f"new Nota(tiempo = {tiempo})")
        else:
            duracion = round(tick_a_ms(tick + largo, cambios, resolucion)) - tiempo
            notas.append(f"new NotaSostenida(comienzo = new Nota(tiempo = {tiempo}), duracion = {duracion})")
            cantidad_sostenidas += 1

    nombre = datos["Name"].strip('"')
    artista = datos["Artist"].strip('"')

    cuerpo = ",\n\t\t".join(notas)

    with open(SALIDA, "w", encoding="utf-8") as f:
        f.write(f'''import nota.*

// Cuando se llama, con que archivo suena y en que momentos hay que tocar.
//
// OJO: este archivo esta generado, no se edita a mano. Los tiempos estan en
// milisegundos desde que arranca el audio y salen de tools/generar_cancion.py
// sobre notes.chart (dificultad {DIFICULTAD}, primeros {HASTA_MS // 1000} segundos).
// Las notas van ordenadas por tiempo, y la partida cuenta con eso.
object bedGoesUp {{

\tmethod nombre() = "{nombre}"

\tmethod artista() = "{artista}"

\tmethod archivo() = "bedGoesUp.ogg"

\tmethod duracion() = {HASTA_MS}

\t// Van en orden de tiempo (ver la nota de arriba)
\tmethod notas() = [
\t\t{cuerpo}
\t]

}}
''')
    print(f"{SALIDA}: {len(notas)} notas, {cantidad_sostenidas} sostenidas "
          f"({DIFICULTAD}), en orden de tiempo")


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "notes.chart")
