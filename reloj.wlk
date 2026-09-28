import wollok.game.*

object reloj {
	var inicio = 0

	method arrancar() {
		inicio = game.currentTime()
	}

	method tiempo() = game.currentTime() - inicio
}
