import wollok.game.*

object pista {

	const property filaDeAcierto = 2

	// asi el movimiento depende del tiempo y no de cada tick del juego
	const msPorFila = 140

	method columna() = game.width().div(2)

	method filaPara(cuantoFalta) = filaDeAcierto + (cuantoFalta / msPorFila).round()

}

object receptor {

	method image() = "receptor.png"

	method position() = game.at(pista.columna(), pista.filaDeAcierto())

}
