import wollok.game.*

object tablero {

	method mostrar(visuales) {
		visuales.forEach({ visual => game.addVisual(visual) })
	}

	method ocultar(visuales) {
		visuales.forEach({ visual => game.removeVisual(visual) })
	}

}
