import reloj.*

// Lo prende la nota amarilla: mientras dura, cada acierto vale el doble
object bonus {
	const cuantoDura = 4000
	const multiplicadorPrendido = 2

	var vence = 0

	method prender() {
		vence = reloj.tiempo() + cuantoDura
	}

	method apagar() {
		vence = 0
	}

	method estaPrendido() = reloj.tiempo() < vence

	method multiplicador() = if (self.estaPrendido()) multiplicadorPrendido else 1

	method texto() = if (self.estaPrendido()) "BONUS x2" else ""
}
