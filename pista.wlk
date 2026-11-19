import wollok.game.*

object pista {
	const property filaDeAcierto = 2

	// Lo pone la dificultad del nivel elegido, antes de que arranque la partida
	var msPorFila = 140

	method usar(unaDificultad) {
		msPorFila = unaDificultad.msPorFila()
	}

	method filaPara(cuantoFalta) = filaDeAcierto + self.filasPara(cuantoFalta)

	method filasPara(milisegundos) = milisegundos / msPorFila

	method entraAlTablero(cuantoFalta) = self.filaPara(cuantoFalta) <= game.height() + 1
}

// Un carril es una columna del mastil: todas sus notas bajan por ahi y se tocan
// con su propia tecla. Como cada uno sabe su nombre, sus notas se dibujan con la
// flecha que apunta hacia la tecla que hay que apretar.
class Carril {
	const property columna
	const nombre

	method imagenDeNota() = "nota_" + nombre + ".png"
	method imagenDeSostenida() = "sostenida_" + nombre + ".png"
	method imagenDeTrampa() = "trampa_" + nombre + ".png"
	method imagenDeBonus() = "bonus_" + nombre + ".png"
}

const carrilIzquierda = new Carril(columna = 4, nombre = "izquierda")
const carrilAbajo = new Carril(columna = 6, nombre = "abajo")
const carrilArriba = new Carril(columna = 8, nombre = "arriba")
const carrilDerecha = new Carril(columna = 10, nombre = "derecha")

const carriles = [carrilIzquierda, carrilAbajo, carrilArriba, carrilDerecha]

// Mutables porque cada visual reusa su posicion (ver nota.wlk)
class PosicionPrecisa {
	var property x
	var property y

	method round() = self
}

// El circulo fijo que marca donde hay que tocar. Hay uno por carril
class Receptor {
	const carril

	method image() = "receptor.png"
	method position() = game.at(carril.columna(), pista.filaDeAcierto())
}

const receptores = carriles.map({ carril => new Receptor(carril = carril) })
