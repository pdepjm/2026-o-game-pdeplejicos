import wollok.game.*

// Agrega y saca listas de visuales, para no repetir el forEach en cada pantalla
object tablero {
	method mostrar(visuales) {
		visuales.forEach({ visual => game.addVisual(visual) })
	}

	method ocultar(visuales) {
		visuales.forEach({ visual => game.removeVisual(visual) })
	}
}
