import wollok.game.*

object pista {
	const property filaDeAcierto = 2

	const msPorFila = 140

	method filaPara(cuantoFalta) = filaDeAcierto + self.filasPara(cuantoFalta)

	method filasPara(milisegundos) = milisegundos / msPorFila

	method entraAlTablero(cuantoFalta) = self.filaPara(cuantoFalta) <= game.height() + 1
}

// Un carril conoce su posicion horizontal y la tecla que lo activa.
// Por ahora solo existe el carril central, asociado a la flecha arriba.
class Carril {
	const posicionHorizontal
	const teclaAsignada

	method columna() = posicionHorizontal
	method tecla() = teclaAsignada
}

const carrilCentral = new Carril(
	posicionHorizontal = game.width().div(2),
	teclaAsignada = "up"
)

class PosicionPrecisa {
	// Mutables porque cada visual reusa su posicion (ver nota.wlk)
	var property x
	var property y

	method round() = self
}

object receptor {
	method image() = "receptor.png"
	method position() = game.at(carrilCentral.columna(), pista.filaDeAcierto())
}
