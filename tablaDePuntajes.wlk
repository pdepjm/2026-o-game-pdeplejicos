// Los mejores puntajes de cada combinacion de cancion y dificultad: un puntaje
// en experto no compite contra uno en facil.
//
// Vive mientras el juego este abierto: Wollok Game no guarda nada en disco.
object tablaDePuntajes {
	const cuantosEntran = 5

	const puntajes = []

	method anotar(unaCancion, unaDificultad, puntos, nombre) {
		puntajes.add(new Puntaje(cancion = unaCancion, dificultad = unaDificultad,
			puntos = puntos, nombre = nombre))
	}

	method vaciar() {
		puntajes.clear()
	}

	method mejores(unaCancion, unaDificultad) =
		puntajes.filter({ puntaje => puntaje.esDe(unaCancion, unaDificultad) })
			.sortedBy({ uno, otro => uno.puntos() > otro.puntos() })
			.take(cuantosEntran)

	// El texto de cada renglon de la pantalla final. Los lugares que todavia no
	// tiene nadie los llena sinPuntaje, asi no hay que preguntar si hay o no hay
	method renglon(lugar, unaCancion, unaDificultad) =
		lugar.toString() + ".  " + self.puestos(unaCancion, unaDificultad).get(lugar - 1).texto()

	method puestos(unaCancion, unaDificultad) =
		(self.mejores(unaCancion, unaDificultad) + (1 .. cuantosEntran).map({ lugar => sinPuntaje }))
			.take(cuantosEntran)
}

class Puntaje {
	const cancion
	const dificultad
	const nombre

	const property puntos

	method esDe(unaCancion, unaDificultad) = cancion == unaCancion && dificultad == unaDificultad

	method texto() = nombre + "  " + puntos
}

// El lugar que todavia nadie alcanzo
object sinPuntaje {
	method texto() = "---"
}
