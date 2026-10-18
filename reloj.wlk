import wollok.game.*

object reloj {
	// El audio tarda un toque en arrancar, asi que el reloj sale atrasado y las
	// notas no se adelantan a la musica. Si llegan antes, subirlo; si llegan
	// despues, bajarlo.
	var property retrasoDelAudio = 150

	var inicio = 0

	method arrancar() {
		inicio = game.currentTime() + retrasoDelAudio
	}

	method tiempo() = game.currentTime() - inicio
}
