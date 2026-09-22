import wollok.game.*


// se mide desde el inicio para que las notas sigan el tiempo real del juego
object reloj {


	const retrasoDelAudio = 0

	var inicio = 0

	method arrancar() {
		inicio = game.currentTime() + retrasoDelAudio
	}

	method tiempo() = game.currentTime() - inicio

}
