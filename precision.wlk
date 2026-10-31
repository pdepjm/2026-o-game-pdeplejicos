import colores.*

// Que tan justo le pegaste a una nota. Cada uno sabe su texto, su color y la
// imagen que se enciende en la tele del fondo
object perfecto {
	method alcanza(desfasaje) = desfasaje <= 40
	method puntos() = 150
	method texto() = "PERFECTO"
	method sumarA(unasEstadisticas) {
		unasEstadisticas.unaPerfecta()
	}
	method color() = verde
	method imagen() = "perfecto.png"
}

object bien {
	method alcanza(desfasaje) = desfasaje <= 90
	method puntos() = 100
	method texto() = "BIEN"
	method sumarA(unasEstadisticas) {
		unasEstadisticas.unaBien()
	}
	method color() = celeste
	method imagen() = "bien.png"
}

// La ultima acepta cualquier desfasaje: si llego hasta aca, es acierto
object apenas {
	method alcanza(_desfasaje) = true
	method puntos() = 50
	method texto() = "APENAS"
	method sumarA(unasEstadisticas) {
		unasEstadisticas.unaApenas()
	}
	method color() = blanco
	method imagen() = "mal.png"
}

// Estos no son aciertos, pero tambien tienen que poder mostrarse en el cartel
object fallo {
	method texto() = "MAL"
	method color() = rojo
	method imagen() = "fallaste.png"
}

object cayoEnTrampa {
	method texto() = "TRAMPA!"
	method color() = violeta
	method imagen() = "fallaste.png"
}

object sinTocar {
	method texto() = ""
	method color() = blanco
	method imagen() = "vacio.png"
}
