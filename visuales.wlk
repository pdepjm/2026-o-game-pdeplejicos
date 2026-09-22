import wollok.game.*
import partida.*

const blanco = "FFFFFFFF"

class Cartel {

	const property position

	const texto

	method text() = texto

	method textColor() = blanco

}

class Marcador {

	const property position

	const prefijo

	method text() = prefijo + partida.puntaje()

	method textColor() = blanco

}

const marcador = new Marcador(position = game.at(1, 0), prefijo = "Puntaje: ")

const puntajeFinal = new Marcador(position = game.at(3, 7), prefijo = "Puntaje final: ")
